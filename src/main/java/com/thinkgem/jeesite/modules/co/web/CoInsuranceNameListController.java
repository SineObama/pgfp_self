/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.service.CoCountryYearService;
import com.thinkgem.jeesite.modules.co.service.CoMainService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.co.entity.CoInsuranceNameList;
import com.thinkgem.jeesite.modules.co.service.CoInsuranceNameListService;

import java.util.List;

/**
 * 医疗保险或商业保险情况名单Controller
 * @author wumx
 * @version 2017-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coInsuranceNameList")
public class CoInsuranceNameListController extends BaseCoController {

	@Autowired
	private CoInsuranceNameListService coInsuranceNameListService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoInsuranceNameList get(@RequestParam(required=false) String id) {
		CoInsuranceNameList entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coInsuranceNameListService.get(id);
		}
		if (entity == null){
			entity = new CoInsuranceNameList();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoInsuranceNameList coInsuranceNameList, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoInsuranceNameList> page = coInsuranceNameListService.findPage(new Page<CoInsuranceNameList>(request, response), coInsuranceNameList); 
		model.addAttribute("page", page);
		return "modules/co/coInsuranceNameListList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoInsuranceNameList coInsuranceNameList, Model model) {
//		model.addAttribute("coInsuranceNameList", coInsuranceNameList);
//		return "modules/co/coInsuranceNameListForm";
//	}
	public String form(CoInsuranceNameList coInsuranceNameList, Model model, String coId,String countryName,String countryId) {
		CoMain comain = new CoMain();
		if(countryName==null && coId !=null){
			CoCountryYear coCountryYear = coCountryYearService.get(coId);
			if (coCountryYear != null && coCountryYear.getArea() != null) {
				countryName = coCountryYear.getArea().getName();
				countryId = coCountryYear.getArea().getId();
			}
		}
		if(coId !=null){
			comain.setCoId(coId);
			comain.setType("9");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoInsuranceNameList> coInsuranceNameLists = coInsuranceNameListService.getByMainId(comain.getId());
				comain.setCoInsuranceNameLists(coInsuranceNameLists);
			}
		}
		model.addAttribute("coMain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coInsuranceNameList", coInsuranceNameList);
		return "modules/co/coInsuranceNameListForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoInsuranceNameList coInsuranceNameList, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coInsuranceNameList)){
//			return form(coInsuranceNameList, model);
//		}
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("9");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoInsuranceNameList> coInsuranceNameLists = comain.getCoInsuranceNameLists();
		List<CoInsuranceNameList> coInsuranceNameListsInSql = coInsuranceNameListService.getByMainId(comain.getId());
		if(coInsuranceNameLists==null){
			if(!coInsuranceNameListsInSql.isEmpty()){
				for(CoInsuranceNameList co : coInsuranceNameListsInSql){
					coInsuranceNameListService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coInsuranceNameList/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoInsuranceNameList officeSql : coInsuranceNameListsInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoInsuranceNameList office : coInsuranceNameLists) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coInsuranceNameListService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoInsuranceNameList office : coInsuranceNameLists) {
			office.setMainId(comain.getId());
			coInsuranceNameListService.save(office);
		}
//		coInsuranceNameListService.save(coInsuranceNameList);
		addMessage(redirectAttributes, "保存医疗保险或商业保险情况名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coInsuranceNameList/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoInsuranceNameList coInsuranceNameList, RedirectAttributes redirectAttributes) {
		coInsuranceNameListService.delete(coInsuranceNameList);
		addMessage(redirectAttributes, "删除医疗保险或商业保险情况名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coInsuranceNameList/?repage";
	}

}
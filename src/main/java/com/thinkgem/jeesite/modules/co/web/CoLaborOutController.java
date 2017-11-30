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
import com.thinkgem.jeesite.modules.co.entity.CoLaborOut;
import com.thinkgem.jeesite.modules.co.service.CoLaborOutService;

import java.util.List;

/**
 * 劳动力长期外出统计表Controller
 * @author wumx
 * @version 2017-11-06
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coLaborOut")
public class CoLaborOutController extends BaseCoController {

	@Autowired
	private CoLaborOutService coLaborOutService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoLaborOut get(@RequestParam(required=false) String id) {
		CoLaborOut entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coLaborOutService.get(id);
		}
		if (entity == null){
			entity = new CoLaborOut();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoLaborOut coLaborOut, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoLaborOut> page = coLaborOutService.findPage(new Page<CoLaborOut>(request, response), coLaborOut); 
		model.addAttribute("page", page);
		return "modules/co/coLaborOutList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoLaborOut coLaborOut, Model model, String coId, String countryName,String countryId) {
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
			comain.setType("3");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoLaborOut> coLaborOutList = coLaborOutService.getByMainId(comain.getId());
				comain.setCoLaborOutList(coLaborOutList);
			}
		}
		model.addAttribute("comain",comain);
		model.addAttribute("coLaborOut", coLaborOut);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		return "modules/co/coLaborOutForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoLaborOut coLaborOut, String id, RedirectAttributes redirectAttributes, CoMain comain,String coId) {
//		if (!beanValidator(model, coLaborOut)){
//			return form(coLaborOut, model);
//		}
//		coLaborOutService.save(coLaborOut);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("3");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoLaborOut> coLaborOuts = comain.getCoLaborOutList();
		List<CoLaborOut> coLaborOutsInSql = coLaborOutService.getByMainId(comain.getId());
		if(coLaborOuts==null){
			if(!coLaborOutsInSql.isEmpty()){
				for(CoLaborOut co : coLaborOutsInSql){
					coLaborOutService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coLaborOut/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoLaborOut officeSql : coLaborOutsInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoLaborOut office : coLaborOuts) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coLaborOutService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoLaborOut office : coLaborOuts) {
			office.setMainId(comain.getId());
			coLaborOutService.save(office);
		}
		addMessage(redirectAttributes, "保存劳动力长期外出统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coLaborOut/form?coId="+coId;

	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoLaborOut coLaborOut, RedirectAttributes redirectAttributes) {
		coLaborOutService.delete(coLaborOut);
		addMessage(redirectAttributes, "删除劳动力长期外出统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coLaborOut/?repage";
	}

}
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
import com.thinkgem.jeesite.modules.co.entity.CoDrinkSituation;
import com.thinkgem.jeesite.modules.co.service.CoDrinkSituationService;

import java.util.List;

/**
 * 未达到安全饮水户名单Controller
 * @author wumx
 * @version 2017-11-15
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coDrinkSituation")
public class CoDrinkSituationController extends BaseController {

	@Autowired
	private CoDrinkSituationService coDrinkSituationService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@Autowired
	private CoMainService coMainService;
	@ModelAttribute
	public CoDrinkSituation get(@RequestParam(required=false) String id) {
		CoDrinkSituation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coDrinkSituationService.get(id);
		}
		if (entity == null){
			entity = new CoDrinkSituation();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoDrinkSituation coDrinkSituation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoDrinkSituation> page = coDrinkSituationService.findPage(new Page<CoDrinkSituation>(request, response), coDrinkSituation); 
		model.addAttribute("page", page);
		return "modules/co/coDrinkSituationList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoDrinkSituation coDrinkSituation, Model model, String coId,String countryName,String countryId) {
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
			comain.setType("15");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoDrinkSituation> coDrinkSituationList = coDrinkSituationService.getByMainId(comain.getId());
				comain.setCoDrinkSituationList(coDrinkSituationList);
			}
		}
		model.addAttribute("comain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coDrinkSituation", coDrinkSituation);
		return "modules/co/coDrinkSituationForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoDrinkSituation coDrinkSituation, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coDrinkSituation)){
//			return form(coDrinkSituation, model);
//		}
//		coDrinkSituationService.save(coDrinkSituation);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("15");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoDrinkSituation> coDrinkSituations = comain.getCoDrinkSituationList();
		List<CoDrinkSituation> coDrinkSituationsInSql = coDrinkSituationService.getByMainId(comain.getId());
		if(coDrinkSituations==null){
			if(!coDrinkSituationsInSql.isEmpty()){
				for(CoDrinkSituation co : coDrinkSituationsInSql){
					coDrinkSituationService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coDrinkSituation/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoDrinkSituation officeSql : coDrinkSituationsInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoDrinkSituation office : coDrinkSituations) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coDrinkSituationService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoDrinkSituation office : coDrinkSituations) {
			office.setMainId(comain.getId());
			coDrinkSituationService.save(office);
		}
//		coLaborSituationService.save(coLaborSituation);
		addMessage(redirectAttributes, "保存未达到安全饮水户名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coDrinkSituation/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoDrinkSituation coDrinkSituation, RedirectAttributes redirectAttributes) {
		coDrinkSituationService.delete(coDrinkSituation);
		addMessage(redirectAttributes, "删除未达到安全饮水户名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coDrinkSituation/?repage";
	}

}
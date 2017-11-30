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
import com.thinkgem.jeesite.modules.co.entity.CoCultureSituation;
import com.thinkgem.jeesite.modules.co.service.CoCultureSituationService;

import java.util.List;

/**
 * 篮球场，文化室或戏台情况Controller
 * @author wumx
 * @version 2017-11-22
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coCultureSituation")
public class CoCultureSituationController extends BaseCoController {

	@Autowired
	private CoCultureSituationService coCultureSituationService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoCultureSituation get(@RequestParam(required=false) String id) {
		CoCultureSituation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coCultureSituationService.get(id);
		}
		if (entity == null){
			entity = new CoCultureSituation();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoCultureSituation coCultureSituation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoCultureSituation> page = coCultureSituationService.findPage(new Page<CoCultureSituation>(request, response), coCultureSituation); 
		model.addAttribute("page", page);
		return "modules/co/coCultureSituationList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoCultureSituation coCultureSituation, Model model) {
//		model.addAttribute("coCultureSituation", coCultureSituation);
//		return "modules/co/coCultureSituationForm";
//	}
	public String form(CoCultureSituation coCultureSituation, Model model, String coId,String countryName,String countryId) {
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
			comain.setType("20");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoCultureSituation> coCultureSituationList = coCultureSituationService.getByMainId(comain.getId());
				comain.setCoCultureSituationList(coCultureSituationList);
			}
		}
		model.addAttribute("comain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coCultureSituation", coCultureSituation);
		return "modules/co/coCultureSituationForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoCultureSituation coCultureSituation, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coCultureSituation)){
//			return form(coCultureSituation, model);
//		}
//		coCultureSituationService.save(coCultureSituation);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("20");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoCultureSituation> coCultureSituations = comain.getCoCultureSituationList();
		List<CoCultureSituation> coCultureSituationsInSql = coCultureSituationService.getByMainId(comain.getId());
		if(coCultureSituations==null){
			if(!coCultureSituationsInSql.isEmpty()){
				for(CoCultureSituation co : coCultureSituationsInSql){
					coCultureSituationService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coCultureSituation/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoCultureSituation officeSql : coCultureSituationsInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoCultureSituation office : coCultureSituations) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coCultureSituationService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoCultureSituation office : coCultureSituations) {
			office.setMainId(comain.getId());
			coCultureSituationService.save(office);
		}
		addMessage(redirectAttributes, "保存篮球场，文化室或戏台情况成功");
		return "redirect:"+Global.getAdminPath()+"/co/coCultureSituation/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoCultureSituation coCultureSituation, RedirectAttributes redirectAttributes) {
		coCultureSituationService.delete(coCultureSituation);
		addMessage(redirectAttributes, "删除篮球场，文化室或戏台情况成功");
		return "redirect:"+Global.getAdminPath()+"/co/coCultureSituation/?repage";
	}

}
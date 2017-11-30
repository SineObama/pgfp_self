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
import com.thinkgem.jeesite.modules.co.entity.CoLaborSituation;
import com.thinkgem.jeesite.modules.co.service.CoLaborSituationService;

import java.util.List;

/**
 * 贫困户劳动力情况表Controller
 * @author wumx
 * @version 2017-11-09
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coLaborSituation")
public class CoLaborSituationController extends BaseController {

	@Autowired
	private CoLaborSituationService coLaborSituationService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoLaborSituation get(@RequestParam(required=false) String id) {
		CoLaborSituation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coLaborSituationService.get(id);
		}
		if (entity == null){
			entity = new CoLaborSituation();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoLaborSituation coLaborSituation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoLaborSituation> page = coLaborSituationService.findPage(new Page<CoLaborSituation>(request, response), coLaborSituation); 
		model.addAttribute("page", page);
		return "modules/co/coLaborSituationList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoLaborSituation coLaborSituation, Model model, String coId,String countryName,String countryId) {
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
			comain.setType("4");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoLaborSituation> coLaborSituationList = coLaborSituationService.getByMainId(comain.getId());
				comain.setCoLaborSituationList(coLaborSituationList);
			}
		}
		model.addAttribute("comain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coLaborSituation", coLaborSituation);
		return "modules/co/coLaborSituationForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoLaborSituation coLaborSituation, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coLaborSituation)){
//			return form(coLaborSituation, model);
//		}
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("4");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoLaborSituation> coLaborOuts = comain.getCoLaborSituationList();
		List<CoLaborSituation> coLaborOutsInSql = coLaborSituationService.getByMainId(comain.getId());
		if(coLaborOuts==null){
			if(!coLaborOutsInSql.isEmpty()){
				for(CoLaborSituation co : coLaborOutsInSql){
					coLaborSituationService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coLaborSituation/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoLaborSituation officeSql : coLaborOutsInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoLaborSituation office : coLaborOuts) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coLaborSituationService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoLaborSituation office : coLaborOuts) {
			office.setMainId(comain.getId());
			coLaborSituationService.save(office);
		}
//		coLaborSituationService.save(coLaborSituation);
		addMessage(redirectAttributes, "保存贫困户劳动力情况表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coLaborSituation/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoLaborSituation coLaborSituation, RedirectAttributes redirectAttributes) {
		coLaborSituationService.delete(coLaborSituation);
		addMessage(redirectAttributes, "删除贫困户劳动力情况表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coLaborSituation/?repage";
	}

}
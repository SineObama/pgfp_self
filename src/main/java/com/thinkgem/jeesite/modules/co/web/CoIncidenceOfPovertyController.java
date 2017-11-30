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
import com.thinkgem.jeesite.modules.co.entity.CoIncidenceOfPoverty;
import com.thinkgem.jeesite.modules.co.service.CoIncidenceOfPovertyService;

import java.util.List;

/**
 * 贫困发生率统计表Controller
 * @author wumx
 * @version 2017-11-29
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coIncidenceOfPoverty")
public class CoIncidenceOfPovertyController extends BaseController {

	@Autowired
	private CoIncidenceOfPovertyService coIncidenceOfPovertyService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoIncidenceOfPoverty get(@RequestParam(required=false) String id) {
		CoIncidenceOfPoverty entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coIncidenceOfPovertyService.get(id);
		}
		if (entity == null){
			entity = new CoIncidenceOfPoverty();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoIncidenceOfPoverty coIncidenceOfPoverty, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoIncidenceOfPoverty> page = coIncidenceOfPovertyService.findPage(new Page<CoIncidenceOfPoverty>(request, response), coIncidenceOfPoverty); 
		model.addAttribute("page", page);
		return "modules/co/coIncidenceOfPovertyList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoIncidenceOfPoverty coIncidenceOfPoverty, Model model) {
//		model.addAttribute("coIncidenceOfPoverty", coIncidenceOfPoverty);
//		return "modules/co/coIncidenceOfPovertyForm";
//	}
	public String form(CoIncidenceOfPoverty coIncidenceOfPoverty, Model model, String coId,String countryName,String countryId) {
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
			comain.setType("27");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoIncidenceOfPoverty> coIncidenceOfPovertyList = coIncidenceOfPovertyService.getByMainId(comain.getId());
				comain.setCoIncidenceOfPovertyList(coIncidenceOfPovertyList);
			}
		}
		model.addAttribute("comain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coIncidenceOfPoverty", coIncidenceOfPoverty);
		return "modules/co/coIncidenceOfPovertyForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoIncidenceOfPoverty coIncidenceOfPoverty, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coIncidenceOfPoverty)){
//			return form(coIncidenceOfPoverty, model);
//		}
//		coIncidenceOfPovertyService.save(coIncidenceOfPoverty);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("27");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoIncidenceOfPoverty> coIncidenceOfPovertys = comain.getCoIncidenceOfPovertyList();
		List<CoIncidenceOfPoverty> coIncidenceOfPovertysInSql = coIncidenceOfPovertyService.getByMainId(comain.getId());
		if(coIncidenceOfPovertys==null){
			if(!coIncidenceOfPovertysInSql.isEmpty()){
				for(CoIncidenceOfPoverty co : coIncidenceOfPovertysInSql){
					coIncidenceOfPovertyService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coIncidenceOfPoverty/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoIncidenceOfPoverty officeSql : coIncidenceOfPovertysInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoIncidenceOfPoverty office : coIncidenceOfPovertys) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coIncidenceOfPovertyService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoIncidenceOfPoverty office : coIncidenceOfPovertys) {
			office.setMainId(comain.getId());
			coIncidenceOfPovertyService.save(office);
		}
		addMessage(redirectAttributes, "保存贫困发生率统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coIncidenceOfPoverty/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoIncidenceOfPoverty coIncidenceOfPoverty, RedirectAttributes redirectAttributes) {
		coIncidenceOfPovertyService.delete(coIncidenceOfPoverty);
		addMessage(redirectAttributes, "删除贫困发生率统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coIncidenceOfPoverty/?repage";
	}

}
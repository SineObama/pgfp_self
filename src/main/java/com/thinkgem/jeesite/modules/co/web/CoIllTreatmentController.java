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
import com.thinkgem.jeesite.modules.co.entity.CoIllTreatment;
import com.thinkgem.jeesite.modules.co.service.CoIllTreatmentService;

import java.util.List;

/**
 * 患病救治和补助报销情况统计Controller
 * @author wumx
 * @version 2017-11-14
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coIllTreatment")
public class CoIllTreatmentController extends BaseController {

	@Autowired
	private CoIllTreatmentService coIllTreatmentService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@Autowired
	private CoMainService coMainService;
	@ModelAttribute
	public CoIllTreatment get(@RequestParam(required=false) String id) {
		CoIllTreatment entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coIllTreatmentService.get(id);
		}
		if (entity == null){
			entity = new CoIllTreatment();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoIllTreatment coIllTreatment, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoIllTreatment> page = coIllTreatmentService.findPage(new Page<CoIllTreatment>(request, response), coIllTreatment); 
		model.addAttribute("page", page);
		return "modules/co/coIllTreatmentList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoIllTreatment coIllTreatment, Model model) {
//		model.addAttribute("coIllTreatment", coIllTreatment);
//		return "modules/co/coIllTreatmentForm";
//	}
	public String form(CoIllTreatment coIllTreatment, Model model, String coId,String countryName,String countryId) {
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
			comain.setType("10");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoIllTreatment> coIllTreatmentList = coIllTreatmentService.getByMainId(comain.getId());
				comain.setCoIllTreatmentList(coIllTreatmentList);
			}
		}
		model.addAttribute("coMain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coIllTreatment", coIllTreatment);
		return "modules/co/coIllTreatmentForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoIllTreatment coIllTreatment, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coIllTreatment)){
//			return form(coIllTreatment, model);
//		}
//		coIllTreatmentService.save(coIllTreatment);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("10");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoIllTreatment> coIllTreatments = comain.getCoIllTreatmentList();
		List<CoIllTreatment> coIllTreatmentsInSql = coIllTreatmentService.getByMainId(comain.getId());
		if(coIllTreatments==null){
			if(!coIllTreatmentsInSql.isEmpty()){
				for(CoIllTreatment co : coIllTreatmentsInSql){
					coIllTreatmentService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coIllTreatment/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoIllTreatment officeSql : coIllTreatmentsInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoIllTreatment office : coIllTreatments) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coIllTreatmentService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoIllTreatment office : coIllTreatments) {
			office.setMainId(comain.getId());
			coIllTreatmentService.save(office);
		}
//		coLaborSituationService.save(coLaborSituation);
		addMessage(redirectAttributes, "保存患病救治和补助报销情况统计成功");
		return "redirect:"+Global.getAdminPath()+"/co/coIllTreatment/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoIllTreatment coIllTreatment, RedirectAttributes redirectAttributes) {
		coIllTreatmentService.delete(coIllTreatment);
		addMessage(redirectAttributes, "删除患病救治和补助报销情况统计成功");
		return "redirect:"+Global.getAdminPath()+"/co/coIllTreatment/?repage";
	}

}
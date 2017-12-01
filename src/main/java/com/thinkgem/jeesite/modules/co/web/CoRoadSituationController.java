/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.entity.CoSafeDrink;
import com.thinkgem.jeesite.modules.co.service.CoCountryYearService;
import com.thinkgem.jeesite.modules.co.service.CoMainService;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
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
import com.thinkgem.jeesite.modules.co.entity.CoRoadSituation;
import com.thinkgem.jeesite.modules.co.service.CoRoadSituationService;

import java.util.List;

/**
 * 通硬化路情况Controller
 * @author wumx
 * @version 2017-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coRoadSituation")
public class CoRoadSituationController extends BaseCoController {

	@Autowired
	private CoRoadSituationService coRoadSituationService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@Autowired
	private AreaService areaService;
	@ModelAttribute
	public CoRoadSituation get(@RequestParam(required=false) String id) {
		CoRoadSituation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coRoadSituationService.get(id);
		}
		if (entity == null){
			entity = new CoRoadSituation();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoRoadSituation coRoadSituation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoRoadSituation> page = coRoadSituationService.findPage(new Page<CoRoadSituation>(request, response), coRoadSituation); 
		model.addAttribute("page", page);
		return "modules/co/coRoadSituationList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoRoadSituation coRoadSituation, Model model) {
//		model.addAttribute("coRoadSituation", coRoadSituation);
//		return "modules/co/coRoadSituationForm";
//	}
	public String form(CoRoadSituation coRoadSituation, Model model, String coId,String countryName,String countryId) {
		CoMain comain = new CoMain();
		String countyName = "";
		if(countryName==null && coId !=null){
			CoCountryYear coCountryYear = coCountryYearService.get(coId);
			if (coCountryYear != null && coCountryYear.getArea() != null) {
				countryName = coCountryYear.getArea().getName();
				countryId = coCountryYear.getArea().getId();
				if(countryId !=null){
					Area area  = areaService.get(countryId);
					if(area != null){
						if(StringUtils.isNoneBlank(area.getParentId())){
							Area areaTemp = areaService.get(area.getParentId());
							if(areaTemp !=null && areaTemp.getName()!=null){
								countyName = areaTemp.getName();
							}
						}
					}
				}
			}
		}
		if(coId !=null){
			comain.setCoId(coId);
			comain.setType("16");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoRoadSituation> coRoadSituationList = coRoadSituationService.getByMainId(comain.getId());
				comain.setCoRoadSituationList(coRoadSituationList);
			}
		}
		model.addAttribute("coMain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countyName",countyName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coRoadSituation", coRoadSituation);
		return "modules/co/coRoadSituationForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoRoadSituation coRoadSituation, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coRoadSituation)){
//			return form(coRoadSituation, model);
//		}
//		coRoadSituationService.save(coRoadSituation);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("16");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoRoadSituation> coRoadSituations = comain.getCoRoadSituationList();
		List<CoRoadSituation> coRoadSituationInSql = coRoadSituationService.getByMainId(comain.getId());
		if(coRoadSituations==null){
			if(!coRoadSituationInSql.isEmpty()){
				for(CoRoadSituation co : coRoadSituationInSql){
					coRoadSituationService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coRoadSituation/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoRoadSituation officeSql : coRoadSituationInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoRoadSituation office : coRoadSituations) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coRoadSituationService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoRoadSituation office : coRoadSituations) {
			office.setMainId(comain.getId());
			coRoadSituationService.save(office);
		}
//		coLaborSituationService.save(coLaborSituation);
		addMessage(redirectAttributes, "保存安全饮水达标情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coRoadSituation/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoRoadSituation coRoadSituation, RedirectAttributes redirectAttributes) {
		coRoadSituationService.delete(coRoadSituation);
		addMessage(redirectAttributes, "删除通硬化路情况成功");
		return "redirect:"+Global.getAdminPath()+"/co/coRoadSituation/?repage";
	}

}
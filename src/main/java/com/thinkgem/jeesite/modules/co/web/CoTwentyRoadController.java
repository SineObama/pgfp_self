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
import com.thinkgem.jeesite.modules.co.entity.CoTwentyRoad;
import com.thinkgem.jeesite.modules.co.service.CoTwentyRoadService;

import java.util.List;

/**
 * 20户以上自然村屯通路情况Controller
 * @author wumx
 * @version 2017-11-20
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coTwentyRoad")
public class CoTwentyRoadController extends BaseCoController {

	@Autowired
	private CoTwentyRoadService coTwentyRoadService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoTwentyRoad get(@RequestParam(required=false) String id) {
		CoTwentyRoad entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coTwentyRoadService.get(id);
		}
		if (entity == null){
			entity = new CoTwentyRoad();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoTwentyRoad coTwentyRoad, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoTwentyRoad> page = coTwentyRoadService.findPage(new Page<CoTwentyRoad>(request, response), coTwentyRoad); 
		model.addAttribute("page", page);
		return "modules/co/coTwentyRoadList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoTwentyRoad coTwentyRoad, Model model) {
//		model.addAttribute("coTwentyRoad", coTwentyRoad);
//		return "modules/co/coTwentyRoadForm";
//	}
	public String form(CoTwentyRoad coTwentyRoad, Model model, String coId,String countryName,String countryId) {
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
			comain.setType("17");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoTwentyRoad> coTwentyRoadList = coTwentyRoadService.getByMainId(comain.getId());
				comain.setCoTwentyRoadList(coTwentyRoadList);
			}
		}
		model.addAttribute("coMain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coTwentyRoad", coTwentyRoad);
		return "modules/co/coTwentyRoadForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoTwentyRoad coTwentyRoad, Model model,RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coTwentyRoad)){
//			return form(coTwentyRoad, model);
//		}
//		coTwentyRoadService.save(coTwentyRoad);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("17");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoTwentyRoad> coTwentyRoads = comain.getCoTwentyRoadList();
		List<CoTwentyRoad> coTwentyRoadsInSql = coTwentyRoadService.getByMainId(comain.getId());
		if(coTwentyRoads==null){
			if(!coTwentyRoadsInSql.isEmpty()){
				for(CoTwentyRoad co : coTwentyRoadsInSql){
					coTwentyRoadService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coTwentyRoad/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoTwentyRoad officeSql : coTwentyRoadsInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoTwentyRoad office : coTwentyRoads) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coTwentyRoadService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoTwentyRoad office : coTwentyRoads) {
			office.setMainId(comain.getId());
			coTwentyRoadService.save(office);
		}
		addMessage(redirectAttributes, "保存20户以上自然村屯通路情况成功");
		return "redirect:"+Global.getAdminPath()+"/co/coTwentyRoad/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoTwentyRoad coTwentyRoad, RedirectAttributes redirectAttributes) {
		coTwentyRoadService.delete(coTwentyRoad);
		addMessage(redirectAttributes, "删除20户以上自然村屯通路情况成功");
		return "redirect:"+Global.getAdminPath()+"/co/coTwentyRoad/?repage";
	}

}
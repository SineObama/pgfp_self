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
import com.thinkgem.jeesite.modules.co.entity.CoSafeDrink;
import com.thinkgem.jeesite.modules.co.service.CoSafeDrinkService;

import java.util.List;

/**
 * 安全饮水达标情况统计表Controller
 * @author wumx
 * @version 2017-11-15
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coSafeDrink")
public class CoSafeDrinkController extends BaseController {

	@Autowired
	private CoSafeDrinkService coSafeDrinkService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoSafeDrink get(@RequestParam(required=false) String id) {
		CoSafeDrink entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coSafeDrinkService.get(id);
		}
		if (entity == null){
			entity = new CoSafeDrink();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoSafeDrink coSafeDrink, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoSafeDrink> page = coSafeDrinkService.findPage(new Page<CoSafeDrink>(request, response), coSafeDrink); 
		model.addAttribute("page", page);
		return "modules/co/coSafeDrinkList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoSafeDrink coSafeDrink, Model model) {
//		model.addAttribute("coSafeDrink", coSafeDrink);
//		return "modules/co/coSafeDrinkForm";
//	}
	public String form(CoSafeDrink coSafeDrink, Model model, String coId,String countryName,String countryId) {
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
			comain.setType("14");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoSafeDrink> coSafeDrinkList = coSafeDrinkService.getByMainId(comain.getId());
				comain.setCoSafeDrinkList(coSafeDrinkList);
			}
		}
		model.addAttribute("comain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coSafeDrink", coSafeDrink);
		return "modules/co/coSafeDrinkForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoSafeDrink coSafeDrink, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coSafeDrink)){
//			return form(coSafeDrink, model);
//		}
//		coSafeDrinkService.save(coSafeDrink);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("14");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoSafeDrink> coSafeDrinks = comain.getCoSafeDrinkList();
		List<CoSafeDrink> coSafeDrinkInSql = coSafeDrinkService.getByMainId(comain.getId());
		if(coSafeDrinks==null){
			if(!coSafeDrinkInSql.isEmpty()){
				for(CoSafeDrink co : coSafeDrinkInSql){
					coSafeDrinkService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coSafeDrink/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoSafeDrink officeSql : coSafeDrinkInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoSafeDrink office : coSafeDrinks) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coSafeDrinkService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoSafeDrink office : coSafeDrinks) {
			office.setMainId(comain.getId());
			coSafeDrinkService.save(office);
		}
//		coLaborSituationService.save(coLaborSituation);
		addMessage(redirectAttributes, "保存安全饮水达标情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coSafeDrink/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoSafeDrink coSafeDrink, RedirectAttributes redirectAttributes) {
		coSafeDrinkService.delete(coSafeDrink);
		addMessage(redirectAttributes, "删除安全饮水达标情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coSafeDrink/?repage";
	}

}
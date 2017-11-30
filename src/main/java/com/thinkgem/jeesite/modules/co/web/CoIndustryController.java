/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.co.entity.CoIndustry;
import com.thinkgem.jeesite.modules.co.service.CoIndustryService;

/**
 * 1-3个特色产业Controller
 * @author zhaojf
 * @version 2017-11-06
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coIndustry")
public class CoIndustryController extends BaseController {

	@Autowired
	private CoIndustryService coIndustryService;
	
	@ModelAttribute
	public CoIndustry get(@RequestParam(required=false) String id) {
		CoIndustry entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coIndustryService.get(id);
		}
		if (entity == null){
			entity = new CoIndustry();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coIndustry:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoIndustry coIndustry, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoIndustry> page = coIndustryService.findPage(new Page<CoIndustry>(request, response), coIndustry); 
		model.addAttribute("page", page);
		return "modules/co/coIndustryList";
	}

	@RequiresPermissions("co:coIndustry:view")
	@RequestMapping(value = "form")
	public String form(CoIndustry coIndustry, Model model) {
		model.addAttribute("coIndustry", coIndustry);
		return "modules/co/coIndustryForm";
	}

	@RequiresPermissions("co:coIndustry:edit")
	@RequestMapping(value = "save")
	public String save(CoIndustry coIndustry, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coIndustry)){
			return form(coIndustry, model);
		}
		coIndustryService.save(coIndustry);
		addMessage(redirectAttributes, "保存1-3个特色产业成功");
		return "redirect:"+Global.getAdminPath()+"/co/coIndustry/?repage";
	}
	
	@RequiresPermissions("co:coIndustry:edit")
	@RequestMapping(value = "delete")
	public String delete(CoIndustry coIndustry, RedirectAttributes redirectAttributes) {
		coIndustryService.delete(coIndustry);
		addMessage(redirectAttributes, "删除1-3个特色产业成功");
		return "redirect:"+Global.getAdminPath()+"/co/coIndustry/?repage";
	}

}
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
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.service.CoMainService;

/**
 * 行政村档案主表Controller
 * @author wumx
 * @version 2017-11-06
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coMain")
public class CoMainController extends BaseCoController {

	@Autowired
	private CoMainService coMainService;
	
	@ModelAttribute
	public CoMain get(@RequestParam(required=false) String id) {
		CoMain entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coMainService.get(id);
		}
		if (entity == null){
			entity = new CoMain();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coMain:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoMain coMain, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoMain> page = coMainService.findPage(new Page<CoMain>(request, response), coMain); 
		model.addAttribute("page", page);
		return "modules/co/coMainList";
	}

	@RequiresPermissions("co:coMain:view")
	@RequestMapping(value = "form")
	public String form(CoMain coMain, Model model) {
		model.addAttribute("coMain", coMain);
		return "modules/co/coMainForm";
	}

	@RequiresPermissions("co:coMain:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coMain)){
			return form(coMain, model);
		}
		coMainService.save(coMain);
		addMessage(redirectAttributes, "保存行政村档案主表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coMain/?repage";
	}
	
	@RequiresPermissions("co:coMain:edit")
	@RequestMapping(value = "delete")
	public String delete(CoMain coMain, RedirectAttributes redirectAttributes) {
		coMainService.delete(coMain);
		addMessage(redirectAttributes, "删除行政村档案主表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coMain/?repage";
	}

}
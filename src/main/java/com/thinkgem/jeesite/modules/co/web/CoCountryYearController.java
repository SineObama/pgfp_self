/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.service.CoCountryYearService;

import java.util.List;

/**
 * 村和年表Controller
 * @author zhaojf
 * @version 2017-11-06
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coCountryYear")
public class CoCountryYearController extends BaseCoController {

	@Autowired
	private CoCountryYearService coCountryYearService;
	@Autowired
	private AreaService areaService;
	@ModelAttribute
	public CoCountryYear get(@RequestParam(required=false) String id) {
		CoCountryYear entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coCountryYearService.get(id);
		}
		if (entity == null){
			entity = new CoCountryYear();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoCountryYear coCountryYear, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoCountryYear> page = coCountryYearService.findPage(new Page<CoCountryYear>(request, response), coCountryYear); 
		model.addAttribute("page", page);
		return "modules/co/coCountryYearList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoCountryYear coCountryYear, Model model) {
		String id = coCountryYear.getId();
		if (id != null && id.length() > 0) {
			coCountryYear = coCountryYearService.get(id);
			String yearDate = coCountryYear.getYears();
			if (StringUtils.isNoneBlank(yearDate)) {
				coCountryYear.setYearDate(StringUtils.stringToDate(yearDate));
			}
		}
		model.addAttribute("coCountryYear", coCountryYear);
		return "modules/co/coCountryYearForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoCountryYear coCountryYear, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coCountryYear)){
			return form(coCountryYear, model);
		}
		coCountryYearService.save(coCountryYear);
		addMessage(redirectAttributes, "保存村和年表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coCountryYear/?repage";
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoCountryYear coCountryYear, RedirectAttributes redirectAttributes) {
		coCountryYearService.delete(coCountryYear);
		addMessage(redirectAttributes, "删除村和年表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coCountryYear/?repage";
	}

	@RequestMapping(value = "countryChoose")
	public String countryChoose(Area area, HttpServletRequest request , HttpServletResponse response,Model model) {
		String countryId = request.getParameter("countryId");
		Page<Area> page = new Page<Area>(request, response);
		if (area.getName()!=null && !"".equals(area.getName().trim())) {//查询的时候走这个方法
			List<Area> areaList = areaService.getByParentIdAndName(area);
			area.setPage(page);
			page.setList(areaList);
		}else {//非查询，或者用空字段进行查询的时候，走这里
			Area areaTemp = new Area();
			if (countryId != null) {
				areaTemp.setId(countryId);
			} else {
				areaTemp.setId(area.getParent().getId());
			}
			area.setParent(areaTemp);
			page = areaService.findPage(page, area);
		}
		model.addAttribute("page", page);
		model.addAttribute("area", area);
		model.addAttribute("countryId", countryId);
		return "modules/utils/countryChoose";
	}
}
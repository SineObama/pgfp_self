/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.entity.CoNoEducation;
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
import com.thinkgem.jeesite.modules.co.entity.CoPoorStudentPolicy;
import com.thinkgem.jeesite.modules.co.service.CoPoorStudentPolicyService;

import java.util.List;

/**
 * 贫困家庭学生享受教育精准扶贫政策情况统计表Controller
 * @author zhaojf
 * @version 2017-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coPoorStudentPolicy")
public class CoPoorStudentPolicyController extends BaseCoController {

	@Autowired
	private CoPoorStudentPolicyService coPoorStudentPolicyService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	
	@ModelAttribute
	public CoPoorStudentPolicy get(@RequestParam(required=false) String id) {
		CoPoorStudentPolicy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coPoorStudentPolicyService.get(id);
		}
		if (entity == null){
			entity = new CoPoorStudentPolicy();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoPoorStudentPolicy coPoorStudentPolicy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoPoorStudentPolicy> page = coPoorStudentPolicyService.findPage(new Page<CoPoorStudentPolicy>(request, response), coPoorStudentPolicy); 
		model.addAttribute("page", page);
		return "modules/co/coPoorStudentPolicyList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoPoorStudentPolicy coPoorStudentPolicy, Model model) {

		CoMain coMain = new CoMain();
		if(coPoorStudentPolicy!=null){
			coMain = coPoorStudentPolicy.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
					model.addAttribute("coPoorStudentPolicy", coPoorStudentPolicy);
					return "modules/co/coPoorStudentPolicyForm";
				}
				String coMainId = coMain.getId();
				if(coMainId == null){
					String coId = coMain.getCoId();
					String type = coMain.getType();
					if(coId != null && type != null){
						coMain = coMainService.getByCoIdAndType(coMain);
						if(coMain == null){
							CoCountryYear countryYear = coCountryYearService.get(coId);
							coMain = new CoMain();
							coMain.setCoId(coId);
							coMain.setType(type);
//							coMain.setCountryId(countryYear.getArea().getId());
							coMainService.save(coMain);
						}
					}
				}
				CoCountryYear countryYear = coCountryYearService.get(coMain.getCoId());
				model.addAttribute("countryYear", countryYear);
				CoPoorStudentPolicy coPoorStudentPolicy1 = coPoorStudentPolicyService.getByMainId(coMain.getId());
				if(coPoorStudentPolicy1 != null){
					coMain.setCoPoorStudentPolicy(coPoorStudentPolicy1);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}


		model.addAttribute("coPoorStudentPolicy", coPoorStudentPolicy);
		return "modules/co/coPoorStudentPolicyForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoPoorStudentPolicy coPoorStudentPolicy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coPoorStudentPolicy)){
			return form(coPoorStudentPolicy, model);
		}

		CoPoorStudentPolicy policy = coMain.getCoPoorStudentPolicy();
		if(coMain != null){
			coMainService.save(coMain);
		}
		policy.setMainId(coMain.getId());
		coPoorStudentPolicyService.save(policy);
		addMessage(redirectAttributes, "保存贫困家庭学生享受教育精准扶贫政策情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coPoorStudentPolicy/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoPoorStudentPolicy coPoorStudentPolicy, RedirectAttributes redirectAttributes) {
		coPoorStudentPolicyService.delete(coPoorStudentPolicy);
		addMessage(redirectAttributes, "删除贫困家庭学生享受教育精准扶贫政策情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coPoorStudentPolicy/?repage";
	}

}
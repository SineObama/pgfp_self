/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.*;
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
import com.thinkgem.jeesite.modules.co.service.CoNoEducationService;

import java.util.List;

/**
 * 村适龄儿童少年应接受义务教育未接受名单Controller
 * @author zhaojf
 * @version 2017-11-16
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coNoEducation")
public class CoNoEducationController extends BaseController {

	@Autowired
	private CoNoEducationService coNoEducationService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	
	@ModelAttribute
	public CoNoEducation get(@RequestParam(required=false) String id) {
		CoNoEducation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coNoEducationService.get(id);
		}
		if (entity == null){
			entity = new CoNoEducation();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoNoEducation coNoEducation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoNoEducation> page = coNoEducationService.findPage(new Page<CoNoEducation>(request, response), coNoEducation); 
		model.addAttribute("page", page);
		return "modules/co/coNoEducationList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoNoEducation coNoEducation, Model model) {

		CoMain coMain = new CoMain();
		if(coNoEducation!=null){
			coMain = coNoEducation.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
					model.addAttribute("coNoEducation", coNoEducation);
					return "modules/co/coNoEducationForm";
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
				model.addAttribute("countryId", countryYear.getArea().getId());
				model.addAttribute("countryYear", countryYear);
				List<CoNoEducation> noEducations = coNoEducationService.getByMainId(coMain.getId());
				if(noEducations != null){
					coMain.setNoEducations(noEducations);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}


		model.addAttribute("coNoEducation", coNoEducation);
		return "modules/co/coNoEducationForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoNoEducation coNoEducation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coNoEducation)){
			return form(coNoEducation, model);
		}

		List<CoNoEducation> noEducations = coMain.getNoEducations();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoNoEducation> noEducationsInSql = coNoEducationService.getByMainId(mainId);


		if(noEducationsInSql==null || noEducationsInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoNoEducation noEducation : noEducations){
				noEducation.setMainId(mainId);
				coNoEducationService.save(noEducation);
			}
		} else {
			if(noEducations == null || noEducations.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoNoEducation noEducation: noEducationsInSql){
					coNoEducationService.delete(noEducation);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoNoEducation noEducationSql : noEducationsInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoNoEducation noEducation : noEducations) { //前台传来的member
						if (StringUtils.isNoneBlank(noEducation.getId())) {//如果前台传来的这个member中不是空的话
							isDel = noEducation.getId().equals(noEducationSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coNoEducationService.delete(noEducationSql);
					}
				}

				//保存数据
				for(CoNoEducation noEducation: noEducations){
					noEducation.setMainId(mainId);
					coNoEducationService.save(noEducation);
				}
			}
		}

//		coNoEducationService.save(coNoEducation);
		addMessage(redirectAttributes, "保存村适龄儿童少年应接受义务教育未接受名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNoEducation/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoNoEducation coNoEducation, RedirectAttributes redirectAttributes) {
		coNoEducationService.delete(coNoEducation);
		addMessage(redirectAttributes, "删除村适龄儿童少年应接受义务教育未接受名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNoEducation/?repage";
	}

}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoIndustry;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.service.CoCountryYearService;
import com.thinkgem.jeesite.modules.co.service.CoIndustryService;
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
import com.thinkgem.jeesite.modules.co.entity.CoCharacterIndustry;
import com.thinkgem.jeesite.modules.co.service.CoCharacterIndustryService;

import java.util.ArrayList;
import java.util.List;

/**
 * 村特色产业情况统计表Controller
 * @author zhaojf
 * @version 2017-11-06
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coCharacterIndustry")
public class CoCharacterIndustryController extends BaseController {

	@Autowired
	private CoCountryYearService coCountryYearService;
	@Autowired
	private CoCharacterIndustryService coCharacterIndustryService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoIndustryService coIndustryService;

	@ModelAttribute
	public CoCharacterIndustry get(@RequestParam(required=false) String id) {
		CoCharacterIndustry entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coCharacterIndustryService.get(id);
		}
		if (entity == null){
			entity = new CoCharacterIndustry();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoCharacterIndustry coCharacterIndustry, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoCharacterIndustry> page = coCharacterIndustryService.findPage(new Page<CoCharacterIndustry>(request, response), coCharacterIndustry); 
		model.addAttribute("page", page);
		return "modules/co/coCharacterIndustryList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoCharacterIndustry coCharacterIndustry, Model model) {
		CoMain coMain = new CoMain();
		if(coCharacterIndustry!=null){
			coMain = coCharacterIndustry.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
					model.addAttribute("coCharacterIndustry", coCharacterIndustry);
					return "modules/co/coCharacterIndustryForm";
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
				List<CoCharacterIndustry> industries = coCharacterIndustryService.getByMainId(coMain.getId());
				if(industries != null){
					coMain.setIndustries(industries);
				}
				CoIndustry coIndustry = coIndustryService.getByMainId(coMain.getId());
				if(coIndustry != null){
					coMain.setCoIndustry(coIndustry);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}
		model.addAttribute("coCharacterIndustry", coCharacterIndustry);
		return "modules/co/coCharacterIndustryForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoCharacterIndustry coCharacterIndustry, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coCharacterIndustry)){
			return form(coCharacterIndustry, model);
		}

		List<CoCharacterIndustry> industries = coMain.getIndustries();

		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}

		CoIndustry coIndustry = coMain.getCoIndustry();
		if(coIndustry != null){
			CoIndustry coIndustryTemp = coIndustryService.getByMainId(mainId);
			if(coIndustryTemp != null){
				coIndustry.setId(coIndustryTemp.getId());
			}
			coIndustry.setMainId(mainId);
			coIndustryService.save(coIndustry);
		}

		List<CoCharacterIndustry> industriesInSql = coCharacterIndustryService.getByMainId(mainId);


		if(industriesInSql==null || industriesInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoCharacterIndustry industry : industries){
				industry.setMainId(mainId);
				coCharacterIndustryService.save(industry);
			}
		} else {
			if(industries == null || industries.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoCharacterIndustry industry : industriesInSql){
					coCharacterIndustryService.delete(industry);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoCharacterIndustry industrySql : industriesInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoCharacterIndustry industry : industries) { //前台传来的member
						if (StringUtils.isNoneBlank(industry.getId())) {//如果前台传来的这个member中不是空的话
							isDel = industry.getId().equals(industrySql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coCharacterIndustryService.delete(industrySql);
					}
				}

				//保存数据
				for(CoCharacterIndustry industry : industries){
					industry.setMainId(mainId);
					coCharacterIndustryService.save(industry);
				}
			}
		}



		addMessage(redirectAttributes, "保存村特色产业情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coCharacterIndustry/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoCharacterIndustry coCharacterIndustry, RedirectAttributes redirectAttributes) {
		coCharacterIndustryService.delete(coCharacterIndustry);
		addMessage(redirectAttributes, "删除村特色产业情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coCharacterIndustry/?repage";
	}

}
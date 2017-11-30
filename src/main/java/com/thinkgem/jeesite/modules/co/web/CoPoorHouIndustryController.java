/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.*;
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
import com.thinkgem.jeesite.modules.co.service.CoPoorHouIndustryService;

import java.util.List;

/**
 * 村贫困户产业登记表Controller
 * @author zhaojf
 * @version 2017-11-09
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coPoorHouIndustry")
public class CoPoorHouIndustryController extends BaseController {

	@Autowired
	private CoPoorHouIndustryService coPoorHouIndustryService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@Autowired
	private CoIndustryService coIndustryService;
	
	@ModelAttribute
	public CoPoorHouIndustry get(@RequestParam(required=false) String id) {
		CoPoorHouIndustry entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coPoorHouIndustryService.get(id);
		}
		if (entity == null){
			entity = new CoPoorHouIndustry();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoPoorHouIndustry coPoorHouIndustry, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoPoorHouIndustry> page = coPoorHouIndustryService.findPage(new Page<CoPoorHouIndustry>(request, response), coPoorHouIndustry); 
		model.addAttribute("page", page);
		return "modules/co/coPoorHouIndustryList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoPoorHouIndustry coPoorHouIndustry, Model model) {
		CoMain coMain = new CoMain();
		if(coPoorHouIndustry!=null){
			coMain = coPoorHouIndustry.getCoMain();
			if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
				model.addAttribute("coPoorHouIndustry", coPoorHouIndustry);
				return "modules/co/coPoorHouIndustryForm";
			}
			if(coMain != null){
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
							//coMain.setCountryId(countryYear.getArea().getId());
							coMainService.save(coMain);
						}
					}
				}
				CoCountryYear countryYear = coCountryYearService.get(coMain.getCoId());
				model.addAttribute("countryId", countryYear.getArea().getId());
				model.addAttribute("countryYear", countryYear);
				List<CoPoorHouIndustry> industries = coPoorHouIndustryService.getByMainId(coMain.getId());
				if(industries != null){
					coMain.setCoPoorHouIndustries(industries);
				}
				CoIndustry coIndustry = coIndustryService.getByMainId(coMain.getId());
				if(coIndustry != null){
					coMain.setCoIndustry(coIndustry);
				}
//				model.addAttribute("countryId",countryYear);
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}
		model.addAttribute("coPoorHouIndustry", coPoorHouIndustry);
		return "modules/co/coPoorHouIndustryForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoPoorHouIndustry coPoorHouIndustry, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coPoorHouIndustry)){
			return form(coPoorHouIndustry, model);
		}

		List<CoPoorHouIndustry> industries = coMain.getCoPoorHouIndustries();

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

		List<CoPoorHouIndustry> industriesInSql = coPoorHouIndustryService.getByMainId(mainId);


		if(industriesInSql==null || industriesInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoPoorHouIndustry industry : industries){
				industry.setMainId(mainId);
				coPoorHouIndustryService.save(industry);
			}
		} else {
			if(industries == null || industries.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoPoorHouIndustry industry : industriesInSql){
					coPoorHouIndustryService.delete(industry);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoPoorHouIndustry industrySql : industriesInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoPoorHouIndustry industry : industries) { //前台传来的member
						if (StringUtils.isNoneBlank(industry.getId())) {//如果前台传来的这个member中不是空的话
							isDel = industry.getId().equals(industrySql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coPoorHouIndustryService.delete(industrySql);
					}
				}

				//保存数据
				for(CoPoorHouIndustry industry : industries){
					industry.setMainId(mainId);
					coPoorHouIndustryService.save(industry);
				}
			}
		}
		addMessage(redirectAttributes, "保存村贫困户产业登记表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coPoorHouIndustry/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoPoorHouIndustry coPoorHouIndustry, RedirectAttributes redirectAttributes) {
		coPoorHouIndustryService.delete(coPoorHouIndustry);
		addMessage(redirectAttributes, "删除村贫困户产业登记表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coPoorHouIndustry/?repage";
	}

}
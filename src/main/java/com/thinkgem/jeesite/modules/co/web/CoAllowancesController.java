/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.entity.CoNoEndowmentInsured;
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
import com.thinkgem.jeesite.modules.co.entity.CoAllowances;
import com.thinkgem.jeesite.modules.co.service.CoAllowancesService;

import java.util.List;

/**
 * 村贫困户纳入农村低保情况统计表Controller
 * @author zhaojf
 * @version 2017-11-27
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coAllowances")
public class CoAllowancesController extends BaseCoController {

	@Autowired
	private CoAllowancesService coAllowancesService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	
	@ModelAttribute
	public CoAllowances get(@RequestParam(required=false) String id) {
		CoAllowances entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coAllowancesService.get(id);
		}
		if (entity == null){
			entity = new CoAllowances();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoAllowances coAllowances, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoAllowances> page = coAllowancesService.findPage(new Page<CoAllowances>(request, response), coAllowances); 
		model.addAttribute("page", page);
		return "modules/co/coAllowancesList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoAllowances coAllowances, Model model) {

		CoMain coMain = new CoMain();
		if(coAllowances!=null){
			coMain = coAllowances.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null||"".equals(coMain.getCoId())){
					model.addAttribute("coAllowances", coAllowances);
					return "modules/co/coAllowancesForm";
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
							coMainService.save(coMain);
						}
					}
				}
				CoCountryYear countryYear = coCountryYearService.get(coMain.getCoId());
				model.addAttribute("countryId", countryYear.getArea().getId());
				model.addAttribute("countryYear", countryYear);
				List<CoAllowances> allowances = coAllowancesService.getByMainId(coMain.getId());
				if(allowances != null){
					coMain.setAllowances(allowances);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}

		model.addAttribute("coAllowances", coAllowances);
		return "modules/co/coAllowancesForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoAllowances coAllowances, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coAllowances)){
			return form(coAllowances, model);
		}

		List<CoAllowances> allowances = coMain.getAllowances();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoAllowances> allowancesInSql = coAllowancesService.getByMainId(mainId);


		if(allowancesInSql==null || allowancesInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoAllowances allowance : allowances){
				allowance.setMainId(mainId);
				coAllowancesService.save(allowance);
			}
		} else {
			if(allowances == null || allowances.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoAllowances allowanceInSql : allowancesInSql){
					coAllowancesService.delete(allowanceInSql);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoAllowances allowanceInSql: allowancesInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoAllowances allowance : allowances) { //前台传来的member
						if (StringUtils.isNoneBlank(allowance.getId())) {//如果前台传来的这个member中不是空的话
							isDel = allowance.getId().equals(allowanceInSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coAllowancesService.delete(allowanceInSql);
					}
				}

				//保存数据
				for(CoAllowances allowance: allowances){
					allowance.setMainId(mainId);
					coAllowancesService.save(allowance);
				}
			}
		}

//		coAllowancesService.save(coAllowances);
		addMessage(redirectAttributes, "保存村贫困户纳入农村低保情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coAllowances/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoAllowances coAllowances, RedirectAttributes redirectAttributes) {
		coAllowancesService.delete(coAllowances);
		addMessage(redirectAttributes, "删除村贫困户纳入农村低保情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coAllowances/?repage";
	}

}
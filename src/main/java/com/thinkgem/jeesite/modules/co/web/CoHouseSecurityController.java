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
import com.thinkgem.jeesite.modules.co.service.CoHouseSecurityService;

import java.util.List;

/**
 * 村住房保障达标情况统计表Controller
 * @author zhaojf
 * @version 2017-11-13
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coHouseSecurity")
public class CoHouseSecurityController extends BaseCoController {

	@Autowired
	private CoHouseSecurityService coHouseSecurityService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	
	@ModelAttribute
	public CoHouseSecurity get(@RequestParam(required=false) String id) {
		CoHouseSecurity entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coHouseSecurityService.get(id);
		}
		if (entity == null){
			entity = new CoHouseSecurity();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoHouseSecurity coHouseSecurity, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoHouseSecurity> page = coHouseSecurityService.findPage(new Page<CoHouseSecurity>(request, response), coHouseSecurity); 
		model.addAttribute("page", page);
		return "modules/co/coHouseSecurityList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoHouseSecurity coHouseSecurity, Model model) {

		CoMain coMain = new CoMain();
		if(coHouseSecurity!=null){
			coMain = coHouseSecurity.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null||"".equals(coMain.getCoId())){
					model.addAttribute("coHouseSecurity", coHouseSecurity);
					return "modules/co/coHouseSecurityForm";
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
				List<CoHouseSecurity> coHouseSecurities = coHouseSecurityService.getByMainId(coMain.getId());
				if(coHouseSecurities != null){
					coMain.setCoHouseSecurities(coHouseSecurities);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}


		model.addAttribute("coHouseSecurity", coHouseSecurity);
		return "modules/co/coHouseSecurityForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoHouseSecurity coHouseSecurity, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coHouseSecurity)){
			return form(coHouseSecurity, model);
		}
		List<CoHouseSecurity> coHouseSecurities = coMain.getCoHouseSecurities();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoHouseSecurity> coHouseSecuritiesInSql = coHouseSecurityService.getByMainId(mainId);


		if(coHouseSecuritiesInSql==null || coHouseSecuritiesInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoHouseSecurity house : coHouseSecurities){
				house.setMainId(mainId);
				coHouseSecurityService.save(house);
			}
		} else {
			if(coHouseSecurities == null || coHouseSecurities.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoHouseSecurity house : coHouseSecuritiesInSql){
					coHouseSecurityService.delete(house);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoHouseSecurity houseSql : coHouseSecuritiesInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoHouseSecurity house : coHouseSecurities) { //前台传来的member
						if (StringUtils.isNoneBlank(house.getId())) {//如果前台传来的这个member中不是空的话
							isDel = house.getId().equals(houseSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coHouseSecurityService.delete(houseSql);
					}
				}

				//保存数据
				for(CoHouseSecurity house: coHouseSecurities){
					house.setMainId(mainId);
					coHouseSecurityService.save(house);
				}
			}
		}

		addMessage(redirectAttributes, "保存村住房保障达标情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coHouseSecurity/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoHouseSecurity coHouseSecurity, RedirectAttributes redirectAttributes) {
		coHouseSecurityService.delete(coHouseSecurity);
		addMessage(redirectAttributes, "删除村住房保障达标情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coHouseSecurity/?repage";
	}

}
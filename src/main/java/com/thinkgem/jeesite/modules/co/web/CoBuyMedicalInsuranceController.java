/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.entity.CoPovertyRelocation;
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
import com.thinkgem.jeesite.modules.co.entity.CoBuyMedicalInsurance;
import com.thinkgem.jeesite.modules.co.service.CoBuyMedicalInsuranceService;

import java.util.List;

/**
 * 村居民购买医疗保险或商业保险情况统计表Controller
 * @author zhaojf
 * @version 2017-11-14
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coBuyMedicalInsurance")
public class CoBuyMedicalInsuranceController extends BaseCoController {

	@Autowired
	private CoBuyMedicalInsuranceService coBuyMedicalInsuranceService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	
	@ModelAttribute
	public CoBuyMedicalInsurance get(@RequestParam(required=false) String id) {
		CoBuyMedicalInsurance entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coBuyMedicalInsuranceService.get(id);
		}
		if (entity == null){
			entity = new CoBuyMedicalInsurance();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoBuyMedicalInsurance coBuyMedicalInsurance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoBuyMedicalInsurance> page = coBuyMedicalInsuranceService.findPage(new Page<CoBuyMedicalInsurance>(request, response), coBuyMedicalInsurance); 
		model.addAttribute("page", page);
		return "modules/co/coBuyMedicalInsuranceList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoBuyMedicalInsurance coBuyMedicalInsurance, Model model) {

		CoMain coMain = new CoMain();
		if(coBuyMedicalInsurance!=null){
			coMain = coBuyMedicalInsurance.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
					model.addAttribute("coBuyMedicalInsurance", coBuyMedicalInsurance);
					return "modules/co/coBuyMedicalInsuranceForm";
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
				List<CoBuyMedicalInsurance> insurances = coBuyMedicalInsuranceService.getByMainId(coMain.getId());
				if(insurances != null){
					coMain.setInsurances(insurances);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}

		model.addAttribute("coBuyMedicalInsurance", coBuyMedicalInsurance);
		return "modules/co/coBuyMedicalInsuranceForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoBuyMedicalInsurance coBuyMedicalInsurance, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coBuyMedicalInsurance)){
			return form(coBuyMedicalInsurance, model);
		}

		List<CoBuyMedicalInsurance> insurances = coMain.getInsurances();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoBuyMedicalInsurance> insurancesInSql = coBuyMedicalInsuranceService.getByMainId(mainId);


		if(insurancesInSql==null || insurancesInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoBuyMedicalInsurance insurance : insurances){
				insurance.setMainId(mainId);
				coBuyMedicalInsuranceService.save(insurance);
			}
		} else {
			if(insurances == null || insurances.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoBuyMedicalInsurance insurance : insurancesInSql){
					coBuyMedicalInsuranceService.delete(insurance);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoBuyMedicalInsurance insuranceSql : insurancesInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoBuyMedicalInsurance insurance : insurances) { //前台传来的member
						if (StringUtils.isNoneBlank(insurance.getId())) {//如果前台传来的这个member中不是空的话
							isDel = insurance.getId().equals(insuranceSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coBuyMedicalInsuranceService.delete(insuranceSql);
					}
				}

				//保存数据
				for(CoBuyMedicalInsurance insurance: insurances){
					insurance.setMainId(mainId);
					coBuyMedicalInsuranceService.save(insurance);
				}
			}
		}

		addMessage(redirectAttributes, "保存村居民购买医疗保险或商业保险情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coBuyMedicalInsurance/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoBuyMedicalInsurance coBuyMedicalInsurance, RedirectAttributes redirectAttributes) {
		coBuyMedicalInsuranceService.delete(coBuyMedicalInsurance);
		addMessage(redirectAttributes, "删除村居民购买医疗保险或商业保险情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coBuyMedicalInsurance/?repage";
	}

}
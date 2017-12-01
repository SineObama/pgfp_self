/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoEndowmentInsured;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
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
import com.thinkgem.jeesite.modules.co.entity.CoNoEndowmentInsured;
import com.thinkgem.jeesite.modules.co.service.CoNoEndowmentInsuredService;

import java.util.List;

/**
 * 村城乡居民养老保险未参保人员名单Controller
 * @author zhaojf
 * @version 2017-11-27
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coNoEndowmentInsured")
public class CoNoEndowmentInsuredController extends BaseController {

	@Autowired
	private CoNoEndowmentInsuredService coNoEndowmentInsuredService;

	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	
	@ModelAttribute
	public CoNoEndowmentInsured get(@RequestParam(required=false) String id) {
		CoNoEndowmentInsured entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coNoEndowmentInsuredService.get(id);
		}
		if (entity == null){
			entity = new CoNoEndowmentInsured();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoNoEndowmentInsured coNoEndowmentInsured, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoNoEndowmentInsured> page = coNoEndowmentInsuredService.findPage(new Page<CoNoEndowmentInsured>(request, response), coNoEndowmentInsured); 
		model.addAttribute("page", page);
		return "modules/co/coNoEndowmentInsuredList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoNoEndowmentInsured coNoEndowmentInsured, Model model) {

		CoMain coMain = new CoMain();
		if(coNoEndowmentInsured!=null){
			coMain = coNoEndowmentInsured.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null||"".equals(coMain.getCoId())){
					model.addAttribute("coNoEndowmentInsured", coNoEndowmentInsured);
					return "modules/co/coNoEndowmentInsuredForm";
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
				List<CoNoEndowmentInsured> noInsureds = coNoEndowmentInsuredService.getByMainId(coMain.getId());
				if(noInsureds != null){
					coMain.setNoInsureds(noInsureds);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}

		model.addAttribute("coNoEndowmentInsured", coNoEndowmentInsured);
		return "modules/co/coNoEndowmentInsuredForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoNoEndowmentInsured coNoEndowmentInsured, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coNoEndowmentInsured)){
			return form(coNoEndowmentInsured, model);
		}

		List<CoNoEndowmentInsured> noInsureds = coMain.getNoInsureds();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoNoEndowmentInsured> noInsuredsInSql = coNoEndowmentInsuredService.getByMainId(mainId);


		if(noInsuredsInSql==null || noInsuredsInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoNoEndowmentInsured insured : noInsureds){
				insured.setMainId(mainId);
				coNoEndowmentInsuredService.save(insured);
			}
		} else {
			if(noInsureds == null || noInsureds.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoNoEndowmentInsured insuredInSql : noInsuredsInSql){
					coNoEndowmentInsuredService.delete(insuredInSql);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoNoEndowmentInsured insuredInSql: noInsuredsInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoNoEndowmentInsured insured : noInsureds) { //前台传来的member
						if (StringUtils.isNoneBlank(insured.getId())) {//如果前台传来的这个member中不是空的话
							isDel = insured.getId().equals(insuredInSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coNoEndowmentInsuredService.delete(insuredInSql);
					}
				}

				//保存数据
				for(CoNoEndowmentInsured insured: noInsureds){
					insured.setMainId(mainId);
					coNoEndowmentInsuredService.save(insured);
				}
			}
		}

//		coNoEndowmentInsuredService.save(coNoEndowmentInsured);
		addMessage(redirectAttributes, "保存村城乡居民养老保险未参保人员名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNoEndowmentInsured/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoNoEndowmentInsured coNoEndowmentInsured, RedirectAttributes redirectAttributes) {
		coNoEndowmentInsuredService.delete(coNoEndowmentInsured);
		addMessage(redirectAttributes, "删除村城乡居民养老保险未参保人员名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNoEndowmentInsured/?repage";
	}

}
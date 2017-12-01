/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoHouseSecurity;
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
import com.thinkgem.jeesite.modules.co.entity.CoEndowmentInsured;
import com.thinkgem.jeesite.modules.co.service.CoEndowmentInsuredService;

import java.util.List;

/**
 * 村城乡居民养老保险参保情况统计表Controller
 * @author zhaojf
 * @version 2017-11-24
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coEndowmentInsured")
public class CoEndowmentInsuredController extends BaseController {

	@Autowired
	private CoEndowmentInsuredService coEndowmentInsuredService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;

	
	@ModelAttribute
	public CoEndowmentInsured get(@RequestParam(required=false) String id) {
		CoEndowmentInsured entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coEndowmentInsuredService.get(id);
		}
		if (entity == null){
			entity = new CoEndowmentInsured();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoEndowmentInsured coEndowmentInsured, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoEndowmentInsured> page = coEndowmentInsuredService.findPage(new Page<CoEndowmentInsured>(request, response), coEndowmentInsured); 
		model.addAttribute("page", page);
		return "modules/co/coEndowmentInsuredList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoEndowmentInsured coEndowmentInsured, Model model) {

		CoMain coMain = new CoMain();
		if(coEndowmentInsured!=null){
			coMain = coEndowmentInsured.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null||"".equals(coMain.getCoId())){
					model.addAttribute("coEndowmentInsured", coEndowmentInsured);
					return "modules/co/coEndowmentInsuredForm";
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
				List<CoEndowmentInsured> insureds = coEndowmentInsuredService.getByMainId(coMain.getId());
				if(insureds != null){
					coMain.setInsureds(insureds);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}
		model.addAttribute("coEndowmentInsured", coEndowmentInsured);
		return "modules/co/coEndowmentInsuredForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoEndowmentInsured coEndowmentInsured, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coEndowmentInsured)){
			return form(coEndowmentInsured, model);
		}

		List<CoEndowmentInsured> insureds = coMain.getInsureds();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoEndowmentInsured> insuredsInSql = coEndowmentInsuredService.getByMainId(mainId);


		if(insuredsInSql==null || insuredsInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoEndowmentInsured insured : insureds){
				insured.setMainId(mainId);
				coEndowmentInsuredService.save(insured);
			}
		} else {
			if(insureds == null || insureds.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoEndowmentInsured insuredInSql : insuredsInSql){
					coEndowmentInsuredService.delete(insuredInSql);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoEndowmentInsured insuredInSql: insuredsInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoEndowmentInsured insured : insureds) { //前台传来的member
						if (StringUtils.isNoneBlank(insured.getId())) {//如果前台传来的这个member中不是空的话
							isDel = insured.getId().equals(insuredInSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coEndowmentInsuredService.delete(insuredInSql);
					}
				}

				//保存数据
				for(CoEndowmentInsured insured: insureds){
					insured.setMainId(mainId);
					coEndowmentInsuredService.save(insured);
				}
			}
		}
		addMessage(redirectAttributes, "保存村城乡居民养老保险参保情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coEndowmentInsured/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoEndowmentInsured coEndowmentInsured, RedirectAttributes redirectAttributes) {
		coEndowmentInsuredService.delete(coEndowmentInsured);
		addMessage(redirectAttributes, "删除村城乡居民养老保险参保情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coEndowmentInsured/?repage";
	}

}
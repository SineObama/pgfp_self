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
import com.thinkgem.jeesite.modules.co.entity.CoPovertyRelocation;
import com.thinkgem.jeesite.modules.co.service.CoPovertyRelocationService;

import java.util.List;

/**
 * 村易地扶贫搬迁户住房保障情况表Controller
 * @author zhaojf
 * @version 2017-11-14
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coPovertyRelocation")
public class CoPovertyRelocationController extends BaseCoController {

	@Autowired
	private CoPovertyRelocationService coPovertyRelocationService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;

	@ModelAttribute
	public CoPovertyRelocation get(@RequestParam(required=false) String id) {
		CoPovertyRelocation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coPovertyRelocationService.get(id);
		}
		if (entity == null){
			entity = new CoPovertyRelocation();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoPovertyRelocation coPovertyRelocation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoPovertyRelocation> page = coPovertyRelocationService.findPage(new Page<CoPovertyRelocation>(request, response), coPovertyRelocation); 
		model.addAttribute("page", page);
		return "modules/co/coPovertyRelocationList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoPovertyRelocation coPovertyRelocation, Model model) {

		CoMain coMain = new CoMain();
		if(coPovertyRelocation!=null){
			coMain = coPovertyRelocation.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
					model.addAttribute("coPovertyRelocation", coPovertyRelocation);
					return "modules/co/coPovertyRelocationForm";
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
				List<CoPovertyRelocation> relocations = coPovertyRelocationService.getByMainId(coMain.getId());
				if(relocations != null){
					coMain.setRelocations(relocations);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}

		model.addAttribute("coPovertyRelocation", coPovertyRelocation);
		return "modules/co/coPovertyRelocationForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoPovertyRelocation coPovertyRelocation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coPovertyRelocation)){
			return form(coPovertyRelocation, model);
		}

		List<CoPovertyRelocation> relocations = coMain.getRelocations();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoPovertyRelocation> relocationssInSql = coPovertyRelocationService.getByMainId(mainId);


		if(relocationssInSql==null || relocationssInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoPovertyRelocation relocation : relocations){
				relocation.setMainId(mainId);
				coPovertyRelocationService.save(relocation);
			}
		} else {
			if(relocations == null || relocations.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoPovertyRelocation relocation : relocationssInSql){
					coPovertyRelocationService.delete(relocation);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoPovertyRelocation relocationSql : relocationssInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoPovertyRelocation relocation : relocations) { //前台传来的member
						if (StringUtils.isNoneBlank(relocation.getId())) {//如果前台传来的这个member中不是空的话
							isDel = relocation.getId().equals(relocationSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coPovertyRelocationService.delete(relocationSql);
					}
				}

				//保存数据
				for(CoPovertyRelocation relocation: relocations){
					relocation.setMainId(mainId);
					coPovertyRelocationService.save(relocation);
				}
			}
		}


		addMessage(redirectAttributes, "保存村易地扶贫搬迁户住房保障情况表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coPovertyRelocation/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoPovertyRelocation coPovertyRelocation, RedirectAttributes redirectAttributes) {
		coPovertyRelocationService.delete(coPovertyRelocation);
		addMessage(redirectAttributes, "删除村易地扶贫搬迁户住房保障情况表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coPovertyRelocation/?repage";
	}

}
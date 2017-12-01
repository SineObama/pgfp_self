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
import com.thinkgem.jeesite.modules.co.entity.CoHaveElectric;
import com.thinkgem.jeesite.modules.co.service.CoHaveElectricService;

import java.util.List;

/**
 * 村有电用达标情况统计表Controller
 * @author zhaojf
 * @version 2017-11-22
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coHaveElectric")
public class CoHaveElectricController extends BaseController {

	@Autowired
	private CoHaveElectricService coHaveElectricService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	
	@ModelAttribute
	public CoHaveElectric get(@RequestParam(required=false) String id) {
		CoHaveElectric entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coHaveElectricService.get(id);
		}
		if (entity == null){
			entity = new CoHaveElectric();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoHaveElectric coHaveElectric, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoHaveElectric> page = coHaveElectricService.findPage(new Page<CoHaveElectric>(request, response), coHaveElectric); 
		model.addAttribute("page", page);
		return "modules/co/coHaveElectricList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoHaveElectric coHaveElectric, Model model) {

		CoMain coMain = new CoMain();
		if(coHaveElectric!=null){
			coMain = coHaveElectric.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null||"".equals(coMain.getCoId())){
					model.addAttribute("coHaveElectric", coHaveElectric);
					return "modules/co/coHaveElectricForm";
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
				List<CoHaveElectric> electrics = coHaveElectricService.getByMainId(coMain.getId());
				if(electrics != null){
					coMain.setElectrics(electrics);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}

		model.addAttribute("coHaveElectric", coHaveElectric);
		return "modules/co/coHaveElectricForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoHaveElectric coHaveElectric, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coHaveElectric)){
			return form(coHaveElectric, model);
		}

		List<CoHaveElectric> electrics = coMain.getElectrics();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoHaveElectric> coHaveElectricInSql = coHaveElectricService.getByMainId(mainId);


		if(coHaveElectricInSql==null || coHaveElectricInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoHaveElectric electric : electrics){
				electric.setMainId(mainId);
				coHaveElectricService.save(electric);
			}
		} else {
			if(electrics == null || electrics.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoHaveElectric electric : coHaveElectricInSql){
					coHaveElectricService.delete(electric);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoHaveElectric electricSql : coHaveElectricInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoHaveElectric electric : electrics) { //前台传来的member
						if (StringUtils.isNoneBlank(electric.getId())) {//如果前台传来的这个member中不是空的话
							isDel = electric.getId().equals(electricSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coHaveElectricService.delete(electricSql);
					}
				}

				//保存数据
				for(CoHaveElectric electric: electrics){
					electric.setMainId(mainId);
					coHaveElectricService.save(electric);
				}
			}
		}

		addMessage(redirectAttributes, "保存村有电用达标情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coHaveElectric/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoHaveElectric coHaveElectric, RedirectAttributes redirectAttributes) {
		coHaveElectricService.delete(coHaveElectric);
		addMessage(redirectAttributes, "删除村有电用达标情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coHaveElectric/?repage";
	}

}
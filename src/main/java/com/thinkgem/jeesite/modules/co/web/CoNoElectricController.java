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
import com.thinkgem.jeesite.modules.co.entity.CoNoElectric;
import com.thinkgem.jeesite.modules.co.service.CoNoElectricService;

import java.util.List;

/**
 * 全村未接通生活用电户名单Controller
 * @author zhaojf
 * @version 2017-11-23
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coNoElectric")
public class CoNoElectricController extends BaseCoController {

	@Autowired
	private CoNoElectricService coNoElectricService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;

	@ModelAttribute
	public CoNoElectric get(@RequestParam(required=false) String id) {
		CoNoElectric entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coNoElectricService.get(id);
		}
		if (entity == null){
			entity = new CoNoElectric();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoNoElectric coNoElectric, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoNoElectric> page = coNoElectricService.findPage(new Page<CoNoElectric>(request, response), coNoElectric); 
		model.addAttribute("page", page);
		return "modules/co/coNoElectricList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoNoElectric coNoElectric, Model model) {

		CoMain coMain = new CoMain();
		if(coNoElectric!=null){
			coMain = coNoElectric.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null||"".equals(coMain.getCoId())){
					model.addAttribute("coNoElectric", coNoElectric);
					return "modules/co/coNoElectricForm";
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
				List<CoNoElectric> noElectrics = coNoElectricService.getByMainId(coMain.getId());
				if(noElectrics != null){
					coMain.setNoElectrics(noElectrics);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}

		model.addAttribute("coNoElectric", coNoElectric);
		return "modules/co/coNoElectricForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoNoElectric coNoElectric, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coNoElectric)){
			return form(coNoElectric, model);
		}

		List<CoNoElectric> noElectrics = coMain.getNoElectrics();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoNoElectric> noElectricsInSql = coNoElectricService.getByMainId(mainId);


		if(noElectricsInSql==null || noElectricsInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoNoElectric electric: noElectrics){
				electric.setMainId(mainId);
				coNoElectricService.save(electric);
			}
		} else {
			if(noElectrics == null || noElectrics.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoNoElectric noElectric : noElectricsInSql){
					coNoElectricService.delete(noElectric);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoNoElectric noElectricSql: noElectricsInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoNoElectric electric: noElectrics) { //前台传来的member
						if (StringUtils.isNoneBlank(electric.getId())) {//如果前台传来的这个member中不是空的话
							isDel = electric.getId().equals(noElectricSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coNoElectricService.delete(noElectricSql);
					}
				}

				//保存数据
				for(CoNoElectric noElectric: noElectrics){
					noElectric.setMainId(mainId);
					coNoElectricService.save(noElectric);
				}
			}
		}

		addMessage(redirectAttributes, "保存全村未接通生活用电户名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNoElectric/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoNoElectric coNoElectric, RedirectAttributes redirectAttributes) {
		coNoElectricService.delete(coNoElectric);
		addMessage(redirectAttributes, "删除全村未接通生活用电户名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNoElectric/?repage";
	}

}
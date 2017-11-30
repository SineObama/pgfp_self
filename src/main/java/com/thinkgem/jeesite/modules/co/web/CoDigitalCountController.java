/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
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
import com.thinkgem.jeesite.modules.co.entity.CoDigitalCount;
import com.thinkgem.jeesite.modules.co.service.CoDigitalCountService;

import java.util.List;

/**
 * 未有数码设备用户名单Controller
 * @author wumx
 * @version 2017-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coDigitalCount")
public class CoDigitalCountController extends BaseController {

	@Autowired
	private CoDigitalCountService coDigitalCountService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@ModelAttribute
	public CoDigitalCount get(@RequestParam(required=false) String id) {
		CoDigitalCount entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coDigitalCountService.get(id);
		}
		if (entity == null){
			entity = new CoDigitalCount();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoDigitalCount coDigitalCount, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoDigitalCount> page = coDigitalCountService.findPage(new Page<CoDigitalCount>(request, response), coDigitalCount); 
		model.addAttribute("page", page);
		return "modules/co/coDigitalCountList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoDigitalCount coDigitalCount, Model model,String coId,String countryName,String countryId) {
//		model.addAttribute("coDigitalCount", coDigitalCount);
//		return "modules/co/coDigitalCountForm";
//	}
			CoMain comain = new CoMain();
	if(countryName==null && coId !=null){
		CoCountryYear coCountryYear = coCountryYearService.get(coId);
		if (coCountryYear != null && coCountryYear.getArea() != null) {
			countryName = coCountryYear.getArea().getName();
			countryId = coCountryYear.getArea().getId();
		}
	}
	if(coId !=null){
		comain.setCoId(coId);
		comain.setType("26");
		CoMain comainTemp = coMainService.getByCoIdAndType(comain);
		if(comainTemp !=null){
			comain = comainTemp;
			List<CoDigitalCount> coDigitalCountList = coDigitalCountService.getByMainId(comain.getId());
			comain.setCoDigitalCountList(coDigitalCountList);
		}
	}
	model.addAttribute("comain",comain);
	model.addAttribute("countryName",countryName);
	model.addAttribute("countryId",countryId);
	model.addAttribute("coDigitalCount", coDigitalCount);
	return "modules/co/coDigitalCountForm";
}


	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoDigitalCount coDigitalCount, Model model, RedirectAttributes redirectAttributes,CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coDigitalCount)){
//			return form(coDigitalCount, model);
//		}
//		coDigitalCountService.save(coDigitalCount);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("26");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoDigitalCount> coDigitalCountList = comain.getCoDigitalCountList();
		List<CoDigitalCount> coDigitalCountListInSql = coDigitalCountService.getByMainId(comain.getId());
		if(coDigitalCountList==null){
			if(!coDigitalCountListInSql.isEmpty()){
				for(CoDigitalCount co : coDigitalCountListInSql){
					coDigitalCountService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coInsuranceNameList/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoDigitalCount officeSql : coDigitalCountListInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoDigitalCount office : coDigitalCountList) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coDigitalCountService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoDigitalCount office : coDigitalCountList) {
			office.setMainId(comain.getId());
			coDigitalCountService.save(office);
		}
//		coInsuranceNameListService.save(coInsuranceNameList);
		addMessage(redirectAttributes, "保存未有数码设备用户名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coDigitalCount/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoDigitalCount coDigitalCount, RedirectAttributes redirectAttributes) {
		coDigitalCountService.delete(coDigitalCount);
		addMessage(redirectAttributes, "删除未有数码设备用户名单成功");
		return "redirect:"+Global.getAdminPath()+"/co/coDigitalCount/?repage";
	}

}
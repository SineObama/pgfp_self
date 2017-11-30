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
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
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
import com.thinkgem.jeesite.modules.co.entity.CoNetwork;
import com.thinkgem.jeesite.modules.co.service.CoNetworkService;

import java.util.List;

/**
 * 通网络宽带情况Controller
 * @author wumx
 * @version 2017-11-23
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coNetwork")
public class CoNetworkController extends BaseCoController {

	@Autowired
	private CoNetworkService coNetworkService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;
	@Autowired
	private AreaService areaService;
	@ModelAttribute
	public CoNetwork get(@RequestParam(required=false) String id) {
		CoNetwork entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coNetworkService.get(id);
		}
		if (entity == null){
			entity = new CoNetwork();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoNetwork coNetwork, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoNetwork> page = coNetworkService.findPage(new Page<CoNetwork>(request, response), coNetwork); 
		model.addAttribute("page", page);
		return "modules/co/coNetworkList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
//	public String form(CoNetwork coNetwork, Model model) {
//		model.addAttribute("coNetwork", coNetwork);
//		return "modules/co/coNetworkForm";
//	}
	public String form(CoNetwork coNetwork, Model model, String coId,String countryName,String countryId) {
		CoMain comain = new CoMain();
		String countyName = "";
		if(countryName==null && coId !=null){
			CoCountryYear coCountryYear = coCountryYearService.get(coId);
			if (coCountryYear != null && coCountryYear.getArea() != null) {
				countryName = coCountryYear.getArea().getName();
				countryId = coCountryYear.getArea().getId();
				if(countryId !=null){
					Area area  = areaService.get(countryId);
					if(area != null){
						if(StringUtils.isNoneBlank(area.getParentId())){
							Area areaTemp = areaService.get(area.getParentId());
							if(areaTemp !=null && areaTemp.getName()!=null){
								countyName = areaTemp.getName();
							}
						}
					}
				}
			}
		}
		if(coId !=null){
			comain.setCoId(coId);
			comain.setType("21");
			CoMain comainTemp = coMainService.getByCoIdAndType(comain);
			if(comainTemp !=null){
				comain = comainTemp;
				List<CoNetwork> coNetworkList = coNetworkService.getByMainId(comain.getId());
				comain.setCoNetworkList(coNetworkList);
			}
		}
		model.addAttribute("coMain",comain);
		model.addAttribute("countryName",countryName);
		model.addAttribute("countyName",countyName);
		model.addAttribute("countryId",countryId);
		model.addAttribute("coNetwork", coNetwork);
		return "modules/co/coNetworkForm";
	}
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoNetwork coNetwork, Model model, RedirectAttributes redirectAttributes, CoMain comain,String coId,String id) {
//		if (!beanValidator(model, coNetwork)){
//			return form(coNetwork, model);
//		}
//		coNetworkService.save(coNetwork);
		if(id!=null){
			comain.setId(id);
		}
		comain.setCoId(coId);
		comain.setType("21");
		coMainService.save(comain);
		//获取户中的单位列表获取出来
		List<CoNetwork> coNetworks = comain.getCoNetworkList();
		List<CoNetwork> coNetworkInSql = coNetworkService.getByMainId(comain.getId());
		if(coNetworks==null){
			if(!coNetworkInSql.isEmpty()){
				for(CoNetwork co : coNetworkInSql){
					coNetworkService.delete(co);
				}
			}
			return "redirect:"+Global.getAdminPath()+"/co/coNetwork/form?coId="+coId;
		}
		//找出前台没有而数据库中有的数据(即被删除的数据)，并删除了
		for (CoNetwork officeSql : coNetworkInSql) {//获取数据库中的一条数据
			boolean isDel = false;//true是已被删除
			for (CoNetwork office : coNetworks) { //前台传来的 info
				if (StringUtils.isNoneBlank(office.getId())) {//如果前台传来的这个 info 中不是空的话
					isDel = office.getId().equals(officeSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
					if (!isDel) {//如果是false(没被删)则跳了
						break;
					}
				}
			}
			if (isDel) {//如果上一个循环出来后还是true，则证明被删了
				coNetworkService.delete(officeSql);
			}
		}
		//逐个把前台传来的成员保存更新入数据库中
		for (CoNetwork office : coNetworks) {
			office.setMainId(comain.getId());
			coNetworkService.save(office);
		}
//		coLaborSituationService.save(coLaborSituation);
		addMessage(redirectAttributes, "保存通网络宽带情况成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNetwork/form?coId="+coId;
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoNetwork coNetwork, RedirectAttributes redirectAttributes) {
		coNetworkService.delete(coNetwork);
		addMessage(redirectAttributes, "删除通网络宽带情况成功");
		return "redirect:"+Global.getAdminPath()+"/co/coNetwork/?repage";
	}

}
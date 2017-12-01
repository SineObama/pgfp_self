/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.entity.CoBuyMedicalInsurance;
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
import com.thinkgem.jeesite.modules.co.entity.CoChildHaveEducation;
import com.thinkgem.jeesite.modules.co.service.CoChildHaveEducationService;

import java.util.List;

/**
 * 村适龄儿童少年接受义务教育情况统计表Controller
 * @author zhaojf
 * @version 2017-11-15
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coChildHaveEducation")
public class CoChildHaveEducationController extends BaseController {

	@Autowired
	private CoChildHaveEducationService coChildHaveEducationService;
	@Autowired
	private CoMainService coMainService;
	@Autowired
	private CoCountryYearService coCountryYearService;

	@ModelAttribute
	public CoChildHaveEducation get(@RequestParam(required=false) String id) {
		CoChildHaveEducation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = coChildHaveEducationService.get(id);
		}
		if (entity == null){
			entity = new CoChildHaveEducation();
		}
		return entity;
	}
	
	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = {"list", ""})
	public String list(CoChildHaveEducation coChildHaveEducation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CoChildHaveEducation> page = coChildHaveEducationService.findPage(new Page<CoChildHaveEducation>(request, response), coChildHaveEducation); 
		model.addAttribute("page", page);
		return "modules/co/coChildHaveEducationList";
	}

	@RequiresPermissions("co:coCountryYear:view")
	@RequestMapping(value = "form")
	public String form(CoChildHaveEducation coChildHaveEducation, Model model) {

		CoMain coMain = new CoMain();
		if(coChildHaveEducation!=null){
			coMain = coChildHaveEducation.getCoMain();
			if(coMain != null){
				if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
					model.addAttribute("coChildHaveEducation", coChildHaveEducation);
					return "modules/co/coChildHaveEducationForm";
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
				List<CoChildHaveEducation> educations = coChildHaveEducationService.getByMainId(coMain.getId());
				if(educations != null){
					coMain.setEducations(educations);
				}
				model.addAttribute("coMain", coMain);
			}else{
				model.addAttribute("coMain", new CoMain());
			}
		}

		model.addAttribute("coChildHaveEducation", coChildHaveEducation);
		return "modules/co/coChildHaveEducationForm";
	}

	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "save")
	public String save(CoMain coMain, CoChildHaveEducation coChildHaveEducation, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, coChildHaveEducation)){
			return form(coChildHaveEducation, model);
		}

		List<CoChildHaveEducation> educations = coMain.getEducations();
		String mainId = "";
		if(coMain != null){
			coMainService.save(coMain);
			mainId = coMain.getId();
		}
		List<CoChildHaveEducation> educationsInSql = coChildHaveEducationService.getByMainId(mainId);


		if(educationsInSql==null || educationsInSql.isEmpty()){
			//如果数据库中没有初始数据，则直接插入就好了。
			for(CoChildHaveEducation education : educations){
				education.setMainId(mainId);
				coChildHaveEducationService.save(education);
			}
		} else {
			if(educations == null || educations.isEmpty()){
				//如果数据库中有数据，而传入的没有数据，则表示都给删除了。
				for(CoChildHaveEducation education : educationsInSql){
					coChildHaveEducationService.delete(education);
				}
			} else {
				//如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
				for (CoChildHaveEducation educationSql : educationsInSql) {//获取数据库中的一条数据
					boolean isDel = false;//true是已被删除
					for (CoChildHaveEducation education : educations) { //前台传来的member
						if (StringUtils.isNoneBlank(education.getId())) {//如果前台传来的这个member中不是空的话
							isDel = education.getId().equals(educationSql.getId()) ? false : true;//如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
							if (!isDel) {//如果是false(没被删)则跳了
								break;
							}
						}
					}
					if (isDel) {//如果上一个循环出来后还是true，则证明被删了
						coChildHaveEducationService.delete(educationSql);
					}
				}

				//保存数据
				for(CoChildHaveEducation education: educations){
					education.setMainId(mainId);
					coChildHaveEducationService.save(education);
				}
			}
		}

		addMessage(redirectAttributes, "保存村适龄儿童少年接受义务教育情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coChildHaveEducation/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
	}
	
	@RequiresPermissions("co:coCountryYear:edit")
	@RequestMapping(value = "delete")
	public String delete(CoChildHaveEducation coChildHaveEducation, RedirectAttributes redirectAttributes) {
		coChildHaveEducationService.delete(coChildHaveEducation);
		addMessage(redirectAttributes, "删除村适龄儿童少年接受义务教育情况统计表成功");
		return "redirect:"+Global.getAdminPath()+"/co/coChildHaveEducation/?repage";
	}

}
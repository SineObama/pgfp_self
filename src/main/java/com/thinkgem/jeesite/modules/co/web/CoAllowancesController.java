/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.co.dao.CoAllowancesDao;
import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.entity.CoNoEndowmentInsured;
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
import com.thinkgem.jeesite.modules.co.entity.CoAllowances;
import com.thinkgem.jeesite.modules.co.service.CoAllowancesService;

import java.util.List;

/**
 * 村贫困户纳入农村低保情况统计表Controller
 * @author zhaojf
 * @version 2017-11-27
 */
@Controller
@RequestMapping(value = "${adminPath}/co/coAllowances")
public class CoAllowancesController extends BaseCoController<CoAllowancesService, CoAllowancesDao, CoAllowances> {

	@Override
	protected CoAllowances newE() {
		return new CoAllowances();
	}

	@Override
	protected String getName() {
		return "coAllowances";
	}

	@Override
	protected String getCName() {
		return "村贫困户纳入农村低保情况统计表";
	}

	@Override
	protected void setData(CoMain coMain, List<CoAllowances> allowances) {
		coMain.setAllowances(allowances);
	}

	@Override
	protected List<CoAllowances> getData(CoMain coMain) {
		return coMain.getAllowances();
	}

}
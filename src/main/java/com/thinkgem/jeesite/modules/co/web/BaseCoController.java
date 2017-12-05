package com.thinkgem.jeesite.modules.co.web;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.co.dao.BaseCoDao;
import com.thinkgem.jeesite.modules.co.entity.BaseCoEntity;
import com.thinkgem.jeesite.modules.co.entity.CoBuyMedicalInsurance;
import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.service.BaseCoService;
import com.thinkgem.jeesite.modules.co.service.CoCountryYearService;
import com.thinkgem.jeesite.modules.co.service.CoMainService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public abstract class BaseCoController<S extends BaseCoService<D, E>, D extends BaseCoDao<E>, E extends BaseCoEntity<E>> extends BaseController {

    @Autowired
    protected S service;
    @Autowired
    protected CoMainService coMainService;
    @Autowired
    protected CoCountryYearService coCountryYearService;

    protected abstract E newE();
    protected abstract String getName();

    @ModelAttribute
    public E get(@RequestParam(required=false) String id) {
        E entity = null;
        if (StringUtils.isNotBlank(id)){
            entity = service.get(id);
        }
        if (entity == null){
            entity = newE();
        }
        return entity;
    }

    @RequiresPermissions("co:coCountryYear:view")
    @RequestMapping(value = {"list", ""})
    public String list(E e, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<E> page = service.findPage(new Page<E>(request, response), e);
        model.addAttribute("page", page);
        return "modules/co/" + getName();
    }

    @RequiresPermissions("co:coCountryYear:view")
    @RequestMapping(value = "form")
    public String form(E e, Model model) {

        CoMain coMain = new CoMain();
        if(e !=null){
            coMain = e.getCoMain();
            if(coMain != null){
                if(coMain.getCoId()==null || "".equals(coMain.getCoId())){
                    model.addAttribute("coBuyMedicalInsurance", e);
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
                List<E> insurances = service.getByMainId(coMain.getId());
                if(insurances != null){
                    coMain.setInsurances(insurances);
                }
                model.addAttribute("coMain", coMain);
            }else{
                model.addAttribute("coMain", new CoMain());
            }
        }

        model.addAttribute("coBuyMedicalInsurance", e);
        return "modules/co/coBuyMedicalInsuranceForm";
    }
}

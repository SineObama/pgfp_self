package com.thinkgem.jeesite.modules.co.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.co.dao.BaseCoDao;
import com.thinkgem.jeesite.modules.co.entity.BaseCoEntity;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 为了提取co模块各表逻辑而建。
 *
 * @param <S> Service
 * @param <D> Dao
 * @param <E> Entity
 * @author zhengx
 */
public abstract class BaseCoController<S extends BaseCoService<D, E>, D extends BaseCoDao<E>, E extends BaseCoEntity<E>> extends BaseController {

    @Autowired
    protected S service;
    @Autowired
    protected CoMainService coMainService;
    @Autowired
    protected CoCountryYearService coCountryYearService;

    protected abstract E newE();

    protected abstract String getName();

    protected abstract String getCName();

    protected abstract void setData(CoMain coMain, List<E> list);

    protected abstract List<E> getData(CoMain coMain);

    @ModelAttribute
    public E get(@RequestParam(required = false) String id) {
        E entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = service.get(id);
        }
        if (entity == null) {
            entity = newE();
        }
        return entity;
    }

    @RequiresPermissions("co:coCountryYear:view")
    @RequestMapping(value = {"list", ""})
    public String list(E e, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<E> page = service.findPage(new Page<E>(request, response), e);
        model.addAttribute("page", page);
        return "modules/co/" + getName() + "List";
    }

    @RequiresPermissions("co:coCountryYear:view")
    @RequestMapping(value = "form")
    public String form(E e, Model model) {
        if (e != null) {
            CoMain coMain = e.getCoMain();
            if (coMain != null) {
                if (StringUtils.isBlank(coMain.getCoId())) {
                    model.addAttribute(getName(), e);
                    return "modules/co/" + getName() + "Form";
                }
                if (coMain.getId() == null) {
                    String coId = coMain.getCoId();
                    String type = coMain.getType();
                    if (coId != null && type != null) {
                        coMain = coMainService.getByCoIdAndType(coMain);
                        if (coMain == null) {
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
                List<E> allowances = service.getByMainId(coMain.getId());
                if (allowances != null) {
                    setData(coMain, allowances);
                }
                model.addAttribute("coMain", coMain);
            } else {
                model.addAttribute("coMain", new CoMain());
            }
        }
        model.addAttribute(getName(), e);
        return "modules/co/" + getName() + "Form";
    }

    @RequiresPermissions("co:coCountryYear:edit")
    @RequestMapping(value = "save")
    public String save(CoMain coMain, E coAllowances, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, coAllowances)) {
            return form(coAllowances, model);
        }

        List<E> list = getData(coMain);
        String mainId = "";
        if (coMain != null) {
            coMainService.save(coMain);
            mainId = coMain.getId();
        }
        List<E> allowancesInSql = service.getByMainId(mainId);

        if (allowancesInSql == null || allowancesInSql.isEmpty()) {
            //如果数据库中没有初始数据，则直接插入就好了。
            for (E e : list) {
                e.setMainId(mainId);
                service.save(e);
            }
        } else {
            if (list == null || list.isEmpty()) {
                //如果数据库中有数据，而传入的没有数据，则表示都给删除了。
                for (E allowanceInSql : allowancesInSql) {
                    service.delete(allowanceInSql);
                }
            } else {
                //如果都有数据，则需要对比先删除数据库中已经被删除的数据，然后再插入
                for (E allowanceInSql : allowancesInSql) {//获取数据库中的一条数据
                    boolean del = true;//应该被删除
                    for (E e : list) { //前台传来的member
                        if (StringUtils.isNoneBlank(e.getId())) {//如果前台传来的这个member中不是空的话
                            //如果前台传来的这个id等于数据库来的这个id证明没被删(false)，否则就被删了(true)
                            if (e.getId().equals(allowanceInSql.getId())) {
                                del = false;
                                break;
                            }
                        }
                    }
                    if (del) {
                        service.delete(allowanceInSql);
                    }
                }

                //保存数据
                for (E e : list) {
                    e.setMainId(mainId);
                    service.save(e);
                }
            }
        }

        addMessage(redirectAttributes, "保存" + getCName() + "成功");
        return "redirect:" + Global.getAdminPath() + "/co/" + getName() + "/form?coMain.coId=" + coMain.getCoId() + "&coMain.type=" + coMain.getType();
    }

    @RequiresPermissions("co:coCountryYear:edit")
    @RequestMapping(value = "delete")
    public String delete(E e, RedirectAttributes redirectAttributes) {
        service.delete(e);
        addMessage(redirectAttributes, "删除" + getCName() + "成功");
        return "redirect:" + Global.getAdminPath() + "/co/" + getName() + "/?repage";
    }
}

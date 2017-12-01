package com.thinkgem.jeesite.modules.co.web;

import com.thinkgem.jeesite.common.web.BaseController;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

public abstract class BaseCoController extends BaseController {
    @ModelAttribute
    public void getTableName(Model model) {
        String name = this.getClass().getName();
        name = name.replaceFirst("^.*\\.web\\.Co(.*)Controller$", "co$1");
        model.addAttribute("tableName", name);
    }
}

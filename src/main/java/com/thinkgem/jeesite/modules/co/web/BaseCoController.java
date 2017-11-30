package com.thinkgem.jeesite.modules.co.web;

import com.thinkgem.jeesite.common.web.BaseController;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

public abstract class BaseCoController extends BaseController {
    @ModelAttribute
    public void tableName(Model model) {
        String name = this.getClass().getName();
        model.addAttribute("tableName", "co" + name.split(".web.Co")[1].split("Controller")[0]);
    }
}

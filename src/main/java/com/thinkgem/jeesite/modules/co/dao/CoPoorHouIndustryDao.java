/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoPoorHouIndustry;

import java.util.List;

/**
 * 村贫困户产业登记表DAO接口
 * @author zhaojf
 * @version 2017-11-09
 */
@MyBatisDao
public interface CoPoorHouIndustryDao extends CrudDao<CoPoorHouIndustry> {

    public List<CoPoorHouIndustry> getByMainId(String mainId);

}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoIndustry;

/**
 * 1-3个特色产业DAO接口
 * @author zhaojf
 * @version 2017-11-06
 */
@MyBatisDao
public interface CoIndustryDao extends CrudDao<CoIndustry> {
	public CoIndustry getByMainId(String mainId);
}
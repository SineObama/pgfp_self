/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoNoElectric;

import java.util.List;

/**
 * 全村未接通生活用电户名单DAO接口
 * @author zhaojf
 * @version 2017-11-23
 */
@MyBatisDao
public interface CoNoElectricDao extends CrudDao<CoNoElectric> {
	public List<CoNoElectric> getByMainId(String mainId);
}
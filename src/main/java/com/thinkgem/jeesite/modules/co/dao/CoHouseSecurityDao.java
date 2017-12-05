/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoHouseSecurity;

import java.util.List;

/**
 * 村住房保障达标情况统计表DAO接口
 * @author zhaojf
 * @version 2017-11-13
 */
@MyBatisDao
public interface CoHouseSecurityDao extends CrudDao<CoHouseSecurity> {
	public List<CoHouseSecurity> getByMainId(String mainId);
}
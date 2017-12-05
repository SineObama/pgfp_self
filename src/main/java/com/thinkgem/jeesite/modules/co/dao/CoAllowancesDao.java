/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoAllowances;

import java.util.List;

/**
 * 村贫困户纳入农村低保情况统计表DAO接口
 * @author zhaojf
 * @version 2017-11-27
 */
@MyBatisDao
public interface CoAllowancesDao extends BaseCoDao<CoAllowances> {
}
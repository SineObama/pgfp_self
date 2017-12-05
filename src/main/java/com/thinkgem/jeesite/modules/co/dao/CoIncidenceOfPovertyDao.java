/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoIncidenceOfPoverty;

import java.util.List;

/**
 * 贫困发生率统计表DAO接口
 * @author wumx
 * @version 2017-11-29
 */
@MyBatisDao
public interface CoIncidenceOfPovertyDao extends CrudDao<CoIncidenceOfPoverty> {
    public List<CoIncidenceOfPoverty> getByMainId(String mainId);
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoDrinkSituation;

import java.util.List;

/**
 * 未达到安全饮水户名单DAO接口
 * @author wumx
 * @version 2017-11-15
 */
@MyBatisDao
public interface CoDrinkSituationDao extends CrudDao<CoDrinkSituation> {
    public List<CoDrinkSituation> getByMainId(String mainId);
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoCultureSituation;

import java.util.List;

/**
 * 篮球场，文化室或戏台情况DAO接口
 * @author wumx
 * @version 2017-11-22
 */
@MyBatisDao
public interface CoCultureSituationDao extends CrudDao<CoCultureSituation> {
    public List<CoCultureSituation> getByMainId(String mainId);
}
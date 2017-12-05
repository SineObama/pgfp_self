/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoHouseSituation;

import java.util.List;

/**
 * 住房保障未达标户名单情况表DAO接口
 * @author wumx
 * @version 2017-11-09
 */
@MyBatisDao
public interface CoHouseSituationDao extends CrudDao<CoHouseSituation> {
    public List<CoHouseSituation> getByMainId(String mainId);
}
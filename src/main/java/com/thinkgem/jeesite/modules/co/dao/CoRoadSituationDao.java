/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoRoadSituation;

import java.util.List;

/**
 * 通硬化路情况DAO接口
 * @author wumx
 * @version 2017-11-17
 */
@MyBatisDao
public interface CoRoadSituationDao extends CrudDao<CoRoadSituation> {
    public List<CoRoadSituation> getByMainId(String mainId);
}
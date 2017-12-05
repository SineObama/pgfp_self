/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoLaborSituation;

import java.util.List;

/**
 * 贫困户劳动力情况表DAO接口
 * @author wumx
 * @version 2017-11-09
 */
@MyBatisDao
public interface CoLaborSituationDao extends CrudDao<CoLaborSituation> {
    public List<CoLaborSituation> getByMainId(String mainId);
}
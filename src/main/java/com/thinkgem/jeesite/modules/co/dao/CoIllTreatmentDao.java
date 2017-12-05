/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoIllTreatment;

import java.util.List;

/**
 * 患病救治和补助报销情况统计DAO接口
 * @author wumx
 * @version 2017-11-14
 */
@MyBatisDao
public interface CoIllTreatmentDao extends CrudDao<CoIllTreatment> {
    public List<CoIllTreatment> getByMainId(String mainId);
}
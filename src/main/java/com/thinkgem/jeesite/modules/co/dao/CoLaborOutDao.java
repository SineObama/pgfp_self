/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoLaborOut;

import java.util.List;

/**
 * 劳动力长期外出统计表DAO接口
 * @author wumx
 * @version 2017-11-06
 */
@MyBatisDao
public interface CoLaborOutDao extends CrudDao<CoLaborOut> {
    public List<CoLaborOut> getByMainId(String mainId);
}
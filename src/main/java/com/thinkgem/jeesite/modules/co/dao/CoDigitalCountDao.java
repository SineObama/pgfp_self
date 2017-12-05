/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoDigitalCount;

import java.util.List;

/**
 * 未有数码设备用户名单DAO接口
 * @author wumx
 * @version 2017-11-28
 */
@MyBatisDao
public interface CoDigitalCountDao extends CrudDao<CoDigitalCount> {
    public List<CoDigitalCount> getByMainId(String mainId);

}
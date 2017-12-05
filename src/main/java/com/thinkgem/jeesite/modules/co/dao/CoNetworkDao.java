/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoNetwork;

import java.util.List;

/**
 * 通网络宽带情况DAO接口
 * @author wumx
 * @version 2017-11-23
 */
@MyBatisDao
public interface CoNetworkDao extends CrudDao<CoNetwork> {
    public List<CoNetwork> getByMainId(String mainId);
}
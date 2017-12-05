/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoPovertyRelocation;

import java.util.List;

/**
 * 村易地扶贫搬迁户住房保障情况表DAO接口
 * @author zhaojf
 * @version 2017-11-14
 */
@MyBatisDao
public interface CoPovertyRelocationDao extends CrudDao<CoPovertyRelocation> {
	public List<CoPovertyRelocation> getByMainId(String mainId);
}
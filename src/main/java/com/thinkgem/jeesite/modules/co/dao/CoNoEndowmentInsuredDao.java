/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoNoEndowmentInsured;

import java.util.List;

/**
 * 村城乡居民养老保险未参保人员名单DAO接口
 * @author zhaojf
 * @version 2017-11-27
 */
@MyBatisDao
public interface CoNoEndowmentInsuredDao extends CrudDao<CoNoEndowmentInsured> {
	public List<CoNoEndowmentInsured> getByMainId(String mainId);
}
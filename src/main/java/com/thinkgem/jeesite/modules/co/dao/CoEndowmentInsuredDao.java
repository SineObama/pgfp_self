/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoEndowmentInsured;

import java.util.List;

/**
 * 村城乡居民养老保险参保情况统计表DAO接口
 * @author zhaojf
 * @version 2017-11-24
 */
@MyBatisDao
public interface CoEndowmentInsuredDao extends CrudDao<CoEndowmentInsured> {

    public List<CoEndowmentInsured> getByMainId(String mainId);

}
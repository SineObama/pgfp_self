/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoTvOnline;

import java.util.List;

/**
 * 农户能看电视或上网情况统计表DAO接口
 * @author wumx
 * @version 2017-11-24
 */
@MyBatisDao
public interface CoTvOnlineDao extends CrudDao<CoTvOnline> {
    public List<CoTvOnline> getByMainId(String mainId);
}
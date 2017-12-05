/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoMain;

/**
 * 行政村档案主表DAO接口
 * @author wumx
 * @version 2017-11-06
 */
@MyBatisDao
public interface CoMainDao extends CrudDao<CoMain> {
    public CoMain getByCoIdAndType(CoMain coMain);
}
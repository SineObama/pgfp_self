/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoSafeDrink;

import java.util.List;

/**
 * 安全饮水达标情况统计表DAO接口
 * @author wumx
 * @version 2017-11-15
 */
@MyBatisDao
public interface CoSafeDrinkDao extends CrudDao<CoSafeDrink> {
    public List<CoSafeDrink> getByMainId(String mainId);
}
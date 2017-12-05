/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoInsuranceNameList;

import java.util.List;

/**
 * 医疗保险或商业保险情况名单DAO接口
 * @author wumx
 * @version 2017-11-13
 */
@MyBatisDao
public interface CoInsuranceNameListDao extends CrudDao<CoInsuranceNameList> {
    public List<CoInsuranceNameList> getByMainId(String mainId);
}
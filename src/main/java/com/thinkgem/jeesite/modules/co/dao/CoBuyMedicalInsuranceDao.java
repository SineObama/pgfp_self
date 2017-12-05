/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoBuyMedicalInsurance;

import java.util.List;

/**
 * 村居民购买医疗保险或商业保险情况统计表DAO接口
 * @author zhaojf
 * @version 2017-11-14
 */
@MyBatisDao
public interface CoBuyMedicalInsuranceDao extends CrudDao<CoBuyMedicalInsurance> {

    public List<CoBuyMedicalInsurance> getByMainId(String mainId);

}
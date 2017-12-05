/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoChildHaveEducation;

import java.util.List;

/**
 * 村适龄儿童少年接受义务教育情况统计表DAO接口
 * @author zhaojf
 * @version 2017-11-15
 */
@MyBatisDao
public interface CoChildHaveEducationDao extends CrudDao<CoChildHaveEducation> {
	public List<CoChildHaveEducation> getByMainId(String mainId);
}
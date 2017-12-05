/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoNoEducation;

import java.util.List;

/**
 * 村适龄儿童少年应接受义务教育未接受名单DAO接口
 * @author zhaojf
 * @version 2017-11-16
 */
@MyBatisDao
public interface CoNoEducationDao extends CrudDao<CoNoEducation> {
	public List<CoNoEducation> getByMainId(String mainId);
}
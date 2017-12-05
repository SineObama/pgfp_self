/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoPoorStudentPolicy;

/**
 * 贫困家庭学生享受教育精准扶贫政策情况统计表DAO接口
 * @author zhaojf
 * @version 2017-11-17
 */
@MyBatisDao
public interface CoPoorStudentPolicyDao extends CrudDao<CoPoorStudentPolicy> {
	public CoPoorStudentPolicy getByMainId(String mainId);
}
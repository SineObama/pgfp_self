/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoPoorStudentPolicy;
import com.thinkgem.jeesite.modules.co.dao.CoPoorStudentPolicyDao;

/**
 * 贫困家庭学生享受教育精准扶贫政策情况统计表Service
 * @author zhaojf
 * @version 2017-11-17
 */
@Service
@Transactional(readOnly = true)
public class CoPoorStudentPolicyService extends CrudService<CoPoorStudentPolicyDao, CoPoorStudentPolicy> {

	public CoPoorStudentPolicy get(String id) {
		return super.get(id);
	}
	
	public List<CoPoorStudentPolicy> findList(CoPoorStudentPolicy coPoorStudentPolicy) {
		return super.findList(coPoorStudentPolicy);
	}
	
	public Page<CoPoorStudentPolicy> findPage(Page<CoPoorStudentPolicy> page, CoPoorStudentPolicy coPoorStudentPolicy) {
		return super.findPage(page, coPoorStudentPolicy);
	}
	
	@Transactional(readOnly = false)
	public void save(CoPoorStudentPolicy coPoorStudentPolicy) {
		super.save(coPoorStudentPolicy);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoPoorStudentPolicy coPoorStudentPolicy) {
		super.delete(coPoorStudentPolicy);
	}

	public CoPoorStudentPolicy getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
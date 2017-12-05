/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoIllTreatment;
import com.thinkgem.jeesite.modules.co.dao.CoIllTreatmentDao;

/**
 * 患病救治和补助报销情况统计Service
 * @author wumx
 * @version 2017-11-14
 */
@Service
@Transactional(readOnly = true)
public class CoIllTreatmentService extends CrudService<CoIllTreatmentDao, CoIllTreatment> {

	public CoIllTreatment get(String id) {
		return super.get(id);
	}
	
	public List<CoIllTreatment> findList(CoIllTreatment coIllTreatment) {
		return super.findList(coIllTreatment);
	}
	
	public Page<CoIllTreatment> findPage(Page<CoIllTreatment> page, CoIllTreatment coIllTreatment) {
		return super.findPage(page, coIllTreatment);
	}
	
	@Transactional(readOnly = false)
	public void save(CoIllTreatment coIllTreatment) {
		super.save(coIllTreatment);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoIllTreatment coIllTreatment) {
		super.delete(coIllTreatment);
	}

	public List<CoIllTreatment> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
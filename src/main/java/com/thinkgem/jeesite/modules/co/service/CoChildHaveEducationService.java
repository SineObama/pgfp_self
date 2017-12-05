/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoChildHaveEducation;
import com.thinkgem.jeesite.modules.co.dao.CoChildHaveEducationDao;

/**
 * 村适龄儿童少年接受义务教育情况统计表Service
 * @author zhaojf
 * @version 2017-11-15
 */
@Service
@Transactional(readOnly = true)
public class CoChildHaveEducationService extends CrudService<CoChildHaveEducationDao, CoChildHaveEducation> {

	public CoChildHaveEducation get(String id) {
		return super.get(id);
	}
	
	public List<CoChildHaveEducation> findList(CoChildHaveEducation coChildHaveEducation) {
		return super.findList(coChildHaveEducation);
	}
	
	public Page<CoChildHaveEducation> findPage(Page<CoChildHaveEducation> page, CoChildHaveEducation coChildHaveEducation) {
		return super.findPage(page, coChildHaveEducation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoChildHaveEducation coChildHaveEducation) {
		super.save(coChildHaveEducation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoChildHaveEducation coChildHaveEducation) {
		super.delete(coChildHaveEducation);
	}

	public List<CoChildHaveEducation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
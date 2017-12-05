/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoNoEducation;
import com.thinkgem.jeesite.modules.co.dao.CoNoEducationDao;

/**
 * 村适龄儿童少年应接受义务教育未接受名单Service
 * @author zhaojf
 * @version 2017-11-16
 */
@Service
@Transactional(readOnly = true)
public class CoNoEducationService extends CrudService<CoNoEducationDao, CoNoEducation> {

	public CoNoEducation get(String id) {
		return super.get(id);
	}
	
	public List<CoNoEducation> findList(CoNoEducation coNoEducation) {
		return super.findList(coNoEducation);
	}
	
	public Page<CoNoEducation> findPage(Page<CoNoEducation> page, CoNoEducation coNoEducation) {
		return super.findPage(page, coNoEducation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoNoEducation coNoEducation) {
		super.save(coNoEducation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoNoEducation coNoEducation) {
		super.delete(coNoEducation);
	}

	public List<CoNoEducation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
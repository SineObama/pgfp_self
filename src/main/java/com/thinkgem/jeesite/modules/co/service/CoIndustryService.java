/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoIndustry;
import com.thinkgem.jeesite.modules.co.dao.CoIndustryDao;

/**
 * 1-3个特色产业Service
 * @author zhaojf
 * @version 2017-11-06
 */
@Service
@Transactional(readOnly = true)
public class CoIndustryService extends CrudService<CoIndustryDao, CoIndustry> {

	public CoIndustry get(String id) {
		return super.get(id);
	}
	
	public List<CoIndustry> findList(CoIndustry coIndustry) {
		return super.findList(coIndustry);
	}
	
	public Page<CoIndustry> findPage(Page<CoIndustry> page, CoIndustry coIndustry) {
		return super.findPage(page, coIndustry);
	}
	
	@Transactional(readOnly = false)
	public void save(CoIndustry coIndustry) {
		super.save(coIndustry);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoIndustry coIndustry) {
		super.delete(coIndustry);
	}

	public CoIndustry getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoCharacterIndustry;
import com.thinkgem.jeesite.modules.co.dao.CoCharacterIndustryDao;

/**
 * 村特色产业情况统计表Service
 * @author zhaojf
 * @version 2017-11-06
 */
@Service
@Transactional(readOnly = true)
public class CoCharacterIndustryService extends CrudService<CoCharacterIndustryDao, CoCharacterIndustry> {

	public CoCharacterIndustry get(String id) {
		return super.get(id);
	}
	
	public List<CoCharacterIndustry> findList(CoCharacterIndustry coCharacterIndustry) {
		return super.findList(coCharacterIndustry);
	}
	
	public Page<CoCharacterIndustry> findPage(Page<CoCharacterIndustry> page, CoCharacterIndustry coCharacterIndustry) {
		return super.findPage(page, coCharacterIndustry);
	}
	
	@Transactional(readOnly = false)
	public void save(CoCharacterIndustry coCharacterIndustry) {
		super.save(coCharacterIndustry);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoCharacterIndustry coCharacterIndustry) {
		super.delete(coCharacterIndustry);
	}

	public List<CoCharacterIndustry> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
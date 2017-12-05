/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoPoorHouIndustry;
import com.thinkgem.jeesite.modules.co.dao.CoPoorHouIndustryDao;

/**
 * 村贫困户产业登记表Service
 * @author zhaojf
 * @version 2017-11-09
 */
@Service
@Transactional(readOnly = true)
public class CoPoorHouIndustryService extends CrudService<CoPoorHouIndustryDao, CoPoorHouIndustry> {

	public CoPoorHouIndustry get(String id) {
		return super.get(id);
	}
	
	public List<CoPoorHouIndustry> findList(CoPoorHouIndustry coPoorHouIndustry) {
		return super.findList(coPoorHouIndustry);
	}
	
	public Page<CoPoorHouIndustry> findPage(Page<CoPoorHouIndustry> page, CoPoorHouIndustry coPoorHouIndustry) {
		return super.findPage(page, coPoorHouIndustry);
	}
	
	@Transactional(readOnly = false)
	public void save(CoPoorHouIndustry coPoorHouIndustry) {
		super.save(coPoorHouIndustry);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoPoorHouIndustry coPoorHouIndustry) {
		super.delete(coPoorHouIndustry);
	}

	public List<CoPoorHouIndustry> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
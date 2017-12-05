/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoHaveElectric;
import com.thinkgem.jeesite.modules.co.dao.CoHaveElectricDao;

/**
 * 村有电用达标情况统计表Service
 * @author zhaojf
 * @version 2017-11-22
 */
@Service
@Transactional(readOnly = true)
public class CoHaveElectricService extends CrudService<CoHaveElectricDao, CoHaveElectric> {

	public CoHaveElectric get(String id) {
		return super.get(id);
	}
	
	public List<CoHaveElectric> findList(CoHaveElectric coHaveElectric) {
		return super.findList(coHaveElectric);
	}
	
	public Page<CoHaveElectric> findPage(Page<CoHaveElectric> page, CoHaveElectric coHaveElectric) {
		return super.findPage(page, coHaveElectric);
	}
	
	@Transactional(readOnly = false)
	public void save(CoHaveElectric coHaveElectric) {
		super.save(coHaveElectric);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoHaveElectric coHaveElectric) {
		super.delete(coHaveElectric);
	}

	public List<CoHaveElectric> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
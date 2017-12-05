/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoNoElectric;
import com.thinkgem.jeesite.modules.co.dao.CoNoElectricDao;

/**
 * 全村未接通生活用电户名单Service
 * @author zhaojf
 * @version 2017-11-23
 */
@Service
@Transactional(readOnly = true)
public class CoNoElectricService extends CrudService<CoNoElectricDao, CoNoElectric> {

	public CoNoElectric get(String id) {
		return super.get(id);
	}
	
	public List<CoNoElectric> findList(CoNoElectric coNoElectric) {
		return super.findList(coNoElectric);
	}
	
	public Page<CoNoElectric> findPage(Page<CoNoElectric> page, CoNoElectric coNoElectric) {
		return super.findPage(page, coNoElectric);
	}
	
	@Transactional(readOnly = false)
	public void save(CoNoElectric coNoElectric) {
		super.save(coNoElectric);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoNoElectric coNoElectric) {
		super.delete(coNoElectric);
	}

	public List<CoNoElectric> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoIncidenceOfPoverty;
import com.thinkgem.jeesite.modules.co.dao.CoIncidenceOfPovertyDao;

/**
 * 贫困发生率统计表Service
 * @author wumx
 * @version 2017-11-29
 */
@Service
@Transactional(readOnly = true)
public class CoIncidenceOfPovertyService extends CrudService<CoIncidenceOfPovertyDao, CoIncidenceOfPoverty> {

	public CoIncidenceOfPoverty get(String id) {
		return super.get(id);
	}
	
	public List<CoIncidenceOfPoverty> findList(CoIncidenceOfPoverty coIncidenceOfPoverty) {
		return super.findList(coIncidenceOfPoverty);
	}
	
	public Page<CoIncidenceOfPoverty> findPage(Page<CoIncidenceOfPoverty> page, CoIncidenceOfPoverty coIncidenceOfPoverty) {
		return super.findPage(page, coIncidenceOfPoverty);
	}
	
	@Transactional(readOnly = false)
	public void save(CoIncidenceOfPoverty coIncidenceOfPoverty) {
		super.save(coIncidenceOfPoverty);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoIncidenceOfPoverty coIncidenceOfPoverty) {
		super.delete(coIncidenceOfPoverty);
	}

	public List<CoIncidenceOfPoverty> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoLaborOut;
import com.thinkgem.jeesite.modules.co.dao.CoLaborOutDao;

/**
 * 劳动力长期外出统计表Service
 * @author wumx
 * @version 2017-11-06
 */
@Service
@Transactional(readOnly = true)
public class CoLaborOutService extends CrudService<CoLaborOutDao, CoLaborOut> {

	public CoLaborOut get(String id) {
		return super.get(id);
	}
	
	public List<CoLaborOut> findList(CoLaborOut coLaborOut) {
		return super.findList(coLaborOut);
	}
	
	public Page<CoLaborOut> findPage(Page<CoLaborOut> page, CoLaborOut coLaborOut) {
		return super.findPage(page, coLaborOut);
	}
	
	@Transactional(readOnly = false)
	public void save(CoLaborOut coLaborOut) {
		super.save(coLaborOut);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoLaborOut coLaborOut) {
		super.delete(coLaborOut);
	}

	public List<CoLaborOut> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
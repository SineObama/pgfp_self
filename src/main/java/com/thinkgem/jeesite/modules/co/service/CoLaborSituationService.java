/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoLaborSituation;
import com.thinkgem.jeesite.modules.co.dao.CoLaborSituationDao;

/**
 * 贫困户劳动力情况表Service
 * @author wumx
 * @version 2017-11-09
 */
@Service
@Transactional(readOnly = true)
public class CoLaborSituationService extends CrudService<CoLaborSituationDao, CoLaborSituation> {

	public CoLaborSituation get(String id) {
		return super.get(id);
	}
	
	public List<CoLaborSituation> findList(CoLaborSituation coLaborSituation) {
		return super.findList(coLaborSituation);
	}
	
	public Page<CoLaborSituation> findPage(Page<CoLaborSituation> page, CoLaborSituation coLaborSituation) {
		return super.findPage(page, coLaborSituation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoLaborSituation coLaborSituation) {
		super.save(coLaborSituation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoLaborSituation coLaborSituation) {
		super.delete(coLaborSituation);
	}

	public List<CoLaborSituation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
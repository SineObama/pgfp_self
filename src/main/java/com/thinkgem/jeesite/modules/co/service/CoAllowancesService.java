/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoAllowances;
import com.thinkgem.jeesite.modules.co.dao.CoAllowancesDao;

/**
 * 村贫困户纳入农村低保情况统计表Service
 * @author zhaojf
 * @version 2017-11-27
 */
@Service
@Transactional(readOnly = true)
public class CoAllowancesService extends CrudService<CoAllowancesDao, CoAllowances> {

	public CoAllowances get(String id) {
		return super.get(id);
	}
	
	public List<CoAllowances> findList(CoAllowances coAllowances) {
		return super.findList(coAllowances);
	}
	
	public Page<CoAllowances> findPage(Page<CoAllowances> page, CoAllowances coAllowances) {
		return super.findPage(page, coAllowances);
	}
	
	@Transactional(readOnly = false)
	public void save(CoAllowances coAllowances) {
		super.save(coAllowances);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoAllowances coAllowances) {
		super.delete(coAllowances);
	}

	public List<CoAllowances> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
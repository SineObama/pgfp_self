/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoMain;
import com.thinkgem.jeesite.modules.co.dao.CoMainDao;

/**
 * 行政村档案主表Service
 * @author wumx
 * @version 2017-11-06
 */
@Service
@Transactional(readOnly = true)
public class CoMainService extends CrudService<CoMainDao, CoMain> {

	public CoMain get(String id) {
		return super.get(id);
	}
	
	public List<CoMain> findList(CoMain coMain) {
		return super.findList(coMain);
	}
	
	public Page<CoMain> findPage(Page<CoMain> page, CoMain coMain) {
		return super.findPage(page, coMain);
	}
	
	@Transactional(readOnly = false)
	public void save(CoMain coMain) {
		super.save(coMain);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoMain coMain) {
		super.delete(coMain);
	}

	public CoMain getByCoIdAndType(CoMain coMain){
		return dao.getByCoIdAndType(coMain);
	}
}
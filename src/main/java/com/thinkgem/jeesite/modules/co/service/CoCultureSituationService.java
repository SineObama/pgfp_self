/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoCultureSituation;
import com.thinkgem.jeesite.modules.co.dao.CoCultureSituationDao;

/**
 * 篮球场，文化室或戏台情况Service
 * @author wumx
 * @version 2017-11-22
 */
@Service
@Transactional(readOnly = true)
public class CoCultureSituationService extends CrudService<CoCultureSituationDao, CoCultureSituation> {

	public CoCultureSituation get(String id) {
		return super.get(id);
	}
	
	public List<CoCultureSituation> findList(CoCultureSituation coCultureSituation) {
		return super.findList(coCultureSituation);
	}
	
	public Page<CoCultureSituation> findPage(Page<CoCultureSituation> page, CoCultureSituation coCultureSituation) {
		return super.findPage(page, coCultureSituation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoCultureSituation coCultureSituation) {
		super.save(coCultureSituation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoCultureSituation coCultureSituation) {
		super.delete(coCultureSituation);
	}

	public List<CoCultureSituation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
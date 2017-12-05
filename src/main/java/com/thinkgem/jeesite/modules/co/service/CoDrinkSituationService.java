/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoDrinkSituation;
import com.thinkgem.jeesite.modules.co.dao.CoDrinkSituationDao;

/**
 * 未达到安全饮水户名单Service
 * @author wumx
 * @version 2017-11-15
 */
@Service
@Transactional(readOnly = true)
public class CoDrinkSituationService extends CrudService<CoDrinkSituationDao, CoDrinkSituation> {

	public CoDrinkSituation get(String id) {
		return super.get(id);
	}
	
	public List<CoDrinkSituation> findList(CoDrinkSituation coDrinkSituation) {
		return super.findList(coDrinkSituation);
	}
	
	public Page<CoDrinkSituation> findPage(Page<CoDrinkSituation> page, CoDrinkSituation coDrinkSituation) {
		return super.findPage(page, coDrinkSituation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoDrinkSituation coDrinkSituation) {
		super.save(coDrinkSituation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoDrinkSituation coDrinkSituation) {
		super.delete(coDrinkSituation);
	}

	public List<CoDrinkSituation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
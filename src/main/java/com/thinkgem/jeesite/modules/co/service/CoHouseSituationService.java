/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoHouseSituation;
import com.thinkgem.jeesite.modules.co.dao.CoHouseSituationDao;

/**
 * 住房保障未达标户名单情况表Service
 * @author wumx
 * @version 2017-11-09
 */
@Service
@Transactional(readOnly = true)
public class CoHouseSituationService extends CrudService<CoHouseSituationDao, CoHouseSituation> {

	public CoHouseSituation get(String id) {
		return super.get(id);
	}
	
	public List<CoHouseSituation> findList(CoHouseSituation coHouseSituation) {
		return super.findList(coHouseSituation);
	}
	
	public Page<CoHouseSituation> findPage(Page<CoHouseSituation> page, CoHouseSituation coHouseSituation) {
		return super.findPage(page, coHouseSituation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoHouseSituation coHouseSituation) {
		super.save(coHouseSituation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoHouseSituation coHouseSituation) {
		super.delete(coHouseSituation);
	}

	public List<CoHouseSituation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
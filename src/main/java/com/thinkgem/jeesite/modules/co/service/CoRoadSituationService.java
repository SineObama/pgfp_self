/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoRoadSituation;
import com.thinkgem.jeesite.modules.co.dao.CoRoadSituationDao;

/**
 * 通硬化路情况Service
 * @author wumx
 * @version 2017-11-17
 */
@Service
@Transactional(readOnly = true)
public class CoRoadSituationService extends CrudService<CoRoadSituationDao, CoRoadSituation> {

	public CoRoadSituation get(String id) {
		return super.get(id);
	}
	
	public List<CoRoadSituation> findList(CoRoadSituation coRoadSituation) {
		return super.findList(coRoadSituation);
	}
	
	public Page<CoRoadSituation> findPage(Page<CoRoadSituation> page, CoRoadSituation coRoadSituation) {
		return super.findPage(page, coRoadSituation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoRoadSituation coRoadSituation) {
		super.save(coRoadSituation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoRoadSituation coRoadSituation) {
		super.delete(coRoadSituation);
	}

	public List<CoRoadSituation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
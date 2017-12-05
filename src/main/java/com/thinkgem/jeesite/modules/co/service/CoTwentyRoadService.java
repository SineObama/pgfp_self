/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoTwentyRoad;
import com.thinkgem.jeesite.modules.co.dao.CoTwentyRoadDao;

/**
 * 20户以上自然村屯通路情况Service
 * @author wumx
 * @version 2017-11-20
 */
@Service
@Transactional(readOnly = true)
public class CoTwentyRoadService extends CrudService<CoTwentyRoadDao, CoTwentyRoad> {

	public CoTwentyRoad get(String id) {
		return super.get(id);
	}
	
	public List<CoTwentyRoad> findList(CoTwentyRoad coTwentyRoad) {
		return super.findList(coTwentyRoad);
	}
	
	public Page<CoTwentyRoad> findPage(Page<CoTwentyRoad> page, CoTwentyRoad coTwentyRoad) {
		return super.findPage(page, coTwentyRoad);
	}
	
	@Transactional(readOnly = false)
	public void save(CoTwentyRoad coTwentyRoad) {
		super.save(coTwentyRoad);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoTwentyRoad coTwentyRoad) {
		super.delete(coTwentyRoad);
	}

	public List<CoTwentyRoad> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
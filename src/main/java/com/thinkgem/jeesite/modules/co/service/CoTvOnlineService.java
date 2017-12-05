/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoTvOnline;
import com.thinkgem.jeesite.modules.co.dao.CoTvOnlineDao;

/**
 * 农户能看电视或上网情况统计表Service
 * @author wumx
 * @version 2017-11-24
 */
@Service
@Transactional(readOnly = true)
public class CoTvOnlineService extends CrudService<CoTvOnlineDao, CoTvOnline> {

	public CoTvOnline get(String id) {
		return super.get(id);
	}
	
	public List<CoTvOnline> findList(CoTvOnline coTvOnline) {
		return super.findList(coTvOnline);
	}
	
	public Page<CoTvOnline> findPage(Page<CoTvOnline> page, CoTvOnline coTvOnline) {
		return super.findPage(page, coTvOnline);
	}
	
	@Transactional(readOnly = false)
	public void save(CoTvOnline coTvOnline) {
		super.save(coTvOnline);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoTvOnline coTvOnline) {
		super.delete(coTvOnline);
	}

	public List<CoTvOnline> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
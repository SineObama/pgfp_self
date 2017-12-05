/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoPovertyRelocation;
import com.thinkgem.jeesite.modules.co.dao.CoPovertyRelocationDao;

/**
 * 村易地扶贫搬迁户住房保障情况表Service
 * @author zhaojf
 * @version 2017-11-14
 */
@Service
@Transactional(readOnly = true)
public class CoPovertyRelocationService extends CrudService<CoPovertyRelocationDao, CoPovertyRelocation> {

	public CoPovertyRelocation get(String id) {
		return super.get(id);
	}
	
	public List<CoPovertyRelocation> findList(CoPovertyRelocation coPovertyRelocation) {
		return super.findList(coPovertyRelocation);
	}
	
	public Page<CoPovertyRelocation> findPage(Page<CoPovertyRelocation> page, CoPovertyRelocation coPovertyRelocation) {
		return super.findPage(page, coPovertyRelocation);
	}
	
	@Transactional(readOnly = false)
	public void save(CoPovertyRelocation coPovertyRelocation) {
		super.save(coPovertyRelocation);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoPovertyRelocation coPovertyRelocation) {
		super.delete(coPovertyRelocation);
	}

	public List<CoPovertyRelocation> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}

}
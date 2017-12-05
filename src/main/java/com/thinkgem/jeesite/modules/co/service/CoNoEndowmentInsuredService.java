/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoNoEndowmentInsured;
import com.thinkgem.jeesite.modules.co.dao.CoNoEndowmentInsuredDao;

/**
 * 村城乡居民养老保险未参保人员名单Service
 * @author zhaojf
 * @version 2017-11-27
 */
@Service
@Transactional(readOnly = true)
public class CoNoEndowmentInsuredService extends CrudService<CoNoEndowmentInsuredDao, CoNoEndowmentInsured> {

	public CoNoEndowmentInsured get(String id) {
		return super.get(id);
	}
	
	public List<CoNoEndowmentInsured> findList(CoNoEndowmentInsured coNoEndowmentInsured) {
		return super.findList(coNoEndowmentInsured);
	}
	
	public Page<CoNoEndowmentInsured> findPage(Page<CoNoEndowmentInsured> page, CoNoEndowmentInsured coNoEndowmentInsured) {
		return super.findPage(page, coNoEndowmentInsured);
	}
	
	@Transactional(readOnly = false)
	public void save(CoNoEndowmentInsured coNoEndowmentInsured) {
		super.save(coNoEndowmentInsured);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoNoEndowmentInsured coNoEndowmentInsured) {
		super.delete(coNoEndowmentInsured);
	}

	public List<CoNoEndowmentInsured> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoEndowmentInsured;
import com.thinkgem.jeesite.modules.co.dao.CoEndowmentInsuredDao;

/**
 * 村城乡居民养老保险参保情况统计表Service
 * @author zhaojf
 * @version 2017-11-24
 */
@Service
@Transactional(readOnly = true)
public class CoEndowmentInsuredService extends CrudService<CoEndowmentInsuredDao, CoEndowmentInsured> {

	public CoEndowmentInsured get(String id) {
		return super.get(id);
	}
	
	public List<CoEndowmentInsured> findList(CoEndowmentInsured coEndowmentInsured) {
		return super.findList(coEndowmentInsured);
	}
	
	public Page<CoEndowmentInsured> findPage(Page<CoEndowmentInsured> page, CoEndowmentInsured coEndowmentInsured) {
		return super.findPage(page, coEndowmentInsured);
	}
	
	@Transactional(readOnly = false)
	public void save(CoEndowmentInsured coEndowmentInsured) {
		super.save(coEndowmentInsured);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoEndowmentInsured coEndowmentInsured) {
		super.delete(coEndowmentInsured);
	}

	public List<CoEndowmentInsured> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
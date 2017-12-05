/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoDigitalCount;
import com.thinkgem.jeesite.modules.co.dao.CoDigitalCountDao;

/**
 * 未有数码设备用户名单Service
 * @author wumx
 * @version 2017-11-28
 */
@Service
@Transactional(readOnly = true)
public class CoDigitalCountService extends CrudService<CoDigitalCountDao, CoDigitalCount> {

	public CoDigitalCount get(String id) {
		return super.get(id);
	}
	
	public List<CoDigitalCount> findList(CoDigitalCount coDigitalCount) {
		return super.findList(coDigitalCount);
	}
	
	public Page<CoDigitalCount> findPage(Page<CoDigitalCount> page, CoDigitalCount coDigitalCount) {
		return super.findPage(page, coDigitalCount);
	}
	
	@Transactional(readOnly = false)
	public void save(CoDigitalCount coDigitalCount) {
		super.save(coDigitalCount);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoDigitalCount coDigitalCount) {
		super.delete(coDigitalCount);
	}

	public List<CoDigitalCount> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
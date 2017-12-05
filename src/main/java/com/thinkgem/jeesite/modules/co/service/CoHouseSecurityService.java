/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoHouseSecurity;
import com.thinkgem.jeesite.modules.co.dao.CoHouseSecurityDao;

/**
 * 村住房保障达标情况统计表Service
 * @author zhaojf
 * @version 2017-11-13
 */
@Service
@Transactional(readOnly = true)
public class CoHouseSecurityService extends CrudService<CoHouseSecurityDao, CoHouseSecurity> {

	public CoHouseSecurity get(String id) {
		return super.get(id);
	}
	
	public List<CoHouseSecurity> findList(CoHouseSecurity coHouseSecurity) {
		return super.findList(coHouseSecurity);
	}
	
	public Page<CoHouseSecurity> findPage(Page<CoHouseSecurity> page, CoHouseSecurity coHouseSecurity) {
		return super.findPage(page, coHouseSecurity);
	}
	
	@Transactional(readOnly = false)
	public void save(CoHouseSecurity coHouseSecurity) {
		super.save(coHouseSecurity);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoHouseSecurity coHouseSecurity) {
		super.delete(coHouseSecurity);
	}

	public List<CoHouseSecurity> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
	
}
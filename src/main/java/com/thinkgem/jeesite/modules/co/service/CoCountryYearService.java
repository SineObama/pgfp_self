/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoCountryYear;
import com.thinkgem.jeesite.modules.co.dao.CoCountryYearDao;

/**
 * 村和年表Service
 * @author zhaojf
 * @version 2017-11-06
 */
@Service
@Transactional(readOnly = true)
public class CoCountryYearService extends CrudService<CoCountryYearDao, CoCountryYear> {

	public CoCountryYear get(String id) {
		return super.get(id);
	}
	
	public List<CoCountryYear> findList(CoCountryYear coCountryYear) {
		return super.findList(coCountryYear);
	}
	
	public Page<CoCountryYear> findPage(Page<CoCountryYear> page, CoCountryYear coCountryYear) {
		return super.findPage(page, coCountryYear);
	}
	
	@Transactional(readOnly = false)
	public void save(CoCountryYear coCountryYear) {
		super.save(coCountryYear);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoCountryYear coCountryYear) {
		super.delete(coCountryYear);
	}

	public CoCountryYear getByCountryIdAndYear(CoCountryYear countryYear){
		return dao.getByCountryIdAndYear(countryYear);
	}
	
}
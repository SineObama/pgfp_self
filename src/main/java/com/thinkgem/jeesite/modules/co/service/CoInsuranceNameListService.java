/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoInsuranceNameList;
import com.thinkgem.jeesite.modules.co.dao.CoInsuranceNameListDao;

/**
 * 医疗保险或商业保险情况名单Service
 * @author wumx
 * @version 2017-11-13
 */
@Service
@Transactional(readOnly = true)
public class CoInsuranceNameListService extends CrudService<CoInsuranceNameListDao, CoInsuranceNameList> {

	public CoInsuranceNameList get(String id) {
		return super.get(id);
	}
	
	public List<CoInsuranceNameList> findList(CoInsuranceNameList coInsuranceNameList) {
		return super.findList(coInsuranceNameList);
	}
	
	public Page<CoInsuranceNameList> findPage(Page<CoInsuranceNameList> page, CoInsuranceNameList coInsuranceNameList) {
		return super.findPage(page, coInsuranceNameList);
	}
	
	@Transactional(readOnly = false)
	public void save(CoInsuranceNameList coInsuranceNameList) {
		super.save(coInsuranceNameList);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoInsuranceNameList coInsuranceNameList) {
		super.delete(coInsuranceNameList);
	}

	public List<CoInsuranceNameList> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
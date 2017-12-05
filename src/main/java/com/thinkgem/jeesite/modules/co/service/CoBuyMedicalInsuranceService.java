/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoBuyMedicalInsurance;
import com.thinkgem.jeesite.modules.co.dao.CoBuyMedicalInsuranceDao;

/**
 * 村居民购买医疗保险或商业保险情况统计表Service
 * @author zhaojf
 * @version 2017-11-14
 */
@Service
@Transactional(readOnly = true)
public class CoBuyMedicalInsuranceService extends CrudService<CoBuyMedicalInsuranceDao, CoBuyMedicalInsurance> {

	public CoBuyMedicalInsurance get(String id) {
		return super.get(id);
	}
	
	public List<CoBuyMedicalInsurance> findList(CoBuyMedicalInsurance coBuyMedicalInsurance) {
		return super.findList(coBuyMedicalInsurance);
	}
	
	public Page<CoBuyMedicalInsurance> findPage(Page<CoBuyMedicalInsurance> page, CoBuyMedicalInsurance coBuyMedicalInsurance) {
		return super.findPage(page, coBuyMedicalInsurance);
	}
	
	@Transactional(readOnly = false)
	public void save(CoBuyMedicalInsurance coBuyMedicalInsurance) {
		super.save(coBuyMedicalInsurance);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoBuyMedicalInsurance coBuyMedicalInsurance) {
		super.delete(coBuyMedicalInsurance);
	}

	public List<CoBuyMedicalInsurance> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
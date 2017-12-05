/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoSafeDrink;
import com.thinkgem.jeesite.modules.co.dao.CoSafeDrinkDao;

/**
 * 安全饮水达标情况统计表Service
 * @author wumx
 * @version 2017-11-15
 */
@Service
@Transactional(readOnly = true)
public class CoSafeDrinkService extends CrudService<CoSafeDrinkDao, CoSafeDrink> {

	public CoSafeDrink get(String id) {
		return super.get(id);
	}
	
	public List<CoSafeDrink> findList(CoSafeDrink coSafeDrink) {
		return super.findList(coSafeDrink);
	}
	
	public Page<CoSafeDrink> findPage(Page<CoSafeDrink> page, CoSafeDrink coSafeDrink) {
		return super.findPage(page, coSafeDrink);
	}
	
	@Transactional(readOnly = false)
	public void save(CoSafeDrink coSafeDrink) {
		super.save(coSafeDrink);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoSafeDrink coSafeDrink) {
		super.delete(coSafeDrink);
	}

	public List<CoSafeDrink> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}

}
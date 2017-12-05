/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.entity.CoNetwork;
import com.thinkgem.jeesite.modules.co.dao.CoNetworkDao;

/**
 * 通网络宽带情况Service
 * @author wumx
 * @version 2017-11-23
 */
@Service
@Transactional(readOnly = true)
public class CoNetworkService extends CrudService<CoNetworkDao, CoNetwork> {

	public CoNetwork get(String id) {
		return super.get(id);
	}
	
	public List<CoNetwork> findList(CoNetwork coNetwork) {
		return super.findList(coNetwork);
	}
	
	public Page<CoNetwork> findPage(Page<CoNetwork> page, CoNetwork coNetwork) {
		return super.findPage(page, coNetwork);
	}
	
	@Transactional(readOnly = false)
	public void save(CoNetwork coNetwork) {
		super.save(coNetwork);
	}
	
	@Transactional(readOnly = false)
	public void delete(CoNetwork coNetwork) {
		super.delete(coNetwork);
	}

	public List<CoNetwork> getByMainId(String mainId){
		return dao.getByMainId(mainId);
	}
}
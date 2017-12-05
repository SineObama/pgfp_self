/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村城乡居民养老保险未参保人员名单Entity
 * @author zhaojf
 * @version 2017-11-27
 */
public class CoNoEndowmentInsured extends DataEntity<CoNoEndowmentInsured> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private String name;		// 未参加居民养老保险人员姓名
	private String householderName;		// 未参加居民养老保险人员户主姓名
	private String reason;		// 未参保主要原因

	private CoMain coMain;


	public CoNoEndowmentInsured() {
		super();
	}

	public CoNoEndowmentInsured(String id){
		super(id);
	}

	@Length(min=0, max=64, message="main_id长度必须介于 0 和 64 之间")
	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}
	
	public Integer getIdx() {
		return idx;
	}

	public void setIdx(Integer idx) {
		this.idx = idx;
	}
	
	@Length(min=0, max=64, message="自然村（屯）长度必须介于 0 和 64 之间")
	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}
	
	@Length(min=0, max=64, message="未参加居民养老保险人员姓名长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=64, message="未参加居民养老保险人员户主姓名长度必须介于 0 和 64 之间")
	public String getHouseholderName() {
		return householderName;
	}

	public void setHouseholderName(String householderName) {
		this.householderName = householderName;
	}
	
	@Length(min=0, max=64, message="未参保主要原因长度必须介于 0 和 64 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
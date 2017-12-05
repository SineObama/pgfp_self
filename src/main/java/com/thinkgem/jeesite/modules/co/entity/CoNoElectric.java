/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 全村未接通生活用电户名单Entity
 * @author zhaojf
 * @version 2017-11-23
 */
public class CoNoElectric extends DataEntity<CoNoElectric> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private String name;		// 未接通生活用电户户主姓名
	private Integer number;		// 家庭人口数
	private String reason;		// 未接通原因

	private CoMain coMain;
	
	public CoNoElectric() {
		super();
	}

	public CoNoElectric(String id){
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
	
	@Length(min=0, max=64, message="未接通生活用电户户主姓名长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}
	
	@Length(min=0, max=64, message="未接通原因长度必须介于 0 和 64 之间")
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
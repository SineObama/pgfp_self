/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 通网络宽带情况Entity
 * @author wumx
 * @version 2017-11-23
 */
public class CoNetwork extends DataEntity<CoNetwork> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String countyId;		// 乡镇
	private String countryId;		// country_id
	private String networkWay;		// 是否通硬化路
	private String place;		// 地点
	
	public CoNetwork() {
		super();
	}

	public CoNetwork(String id){
		super(id);
	}

	@Length(min=0, max=64, message="main_id长度必须介于 0 和 64 之间")
	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}
	
	@Length(min=0, max=64, message="序号长度必须介于 0 和 64 之间")
	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}
	
	@Length(min=0, max=64, message="乡镇长度必须介于 0 和 64 之间")
	public String getCountyId() {
		return countyId;
	}

	public void setCountyId(String countyId) {
		this.countyId = countyId;
	}
	
	@Length(min=0, max=64, message="country_id长度必须介于 0 和 64 之间")
	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}
	
	@Length(min=0, max=64, message="是否通硬化路长度必须介于 0 和 64 之间")
	public String getNetworkWay() {
		return networkWay;
	}

	public void setNetworkWay(String networkWay) {
		this.networkWay = networkWay;
	}
	
	@Length(min=0, max=100, message="地点长度必须介于 0 和 100 之间")
	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
	
}
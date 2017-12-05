/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村有电用达标情况统计表Entity
 * @author zhaojf
 * @version 2017-11-22
 */
public class CoHaveElectric extends DataEntity<CoHaveElectric> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private Integer hous;		// 户数
	private Integer haveElectricHous;		// 接通生活用电户数
	private Integer noElectricHous;		// 未接通生活用电户数
	private Double haveElectricRate;		// 生活用电接通率

	private CoMain coMain;
	
	public CoHaveElectric() {
		super();
	}

	public CoHaveElectric(String id){
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
	
	public Integer getHous() {
		return hous;
	}

	public void setHous(Integer hous) {
		this.hous = hous;
	}
	
	public Integer getHaveElectricHous() {
		return haveElectricHous;
	}

	public void setHaveElectricHous(Integer haveElectricHous) {
		this.haveElectricHous = haveElectricHous;
	}
	
	public Integer getNoElectricHous() {
		return noElectricHous;
	}

	public void setNoElectricHous(Integer noElectricHous) {
		this.noElectricHous = noElectricHous;
	}
	
	public Double getHaveElectricRate() {
		return haveElectricRate;
	}

	public void setHaveElectricRate(Double haveElectricRate) {
		this.haveElectricRate = haveElectricRate;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
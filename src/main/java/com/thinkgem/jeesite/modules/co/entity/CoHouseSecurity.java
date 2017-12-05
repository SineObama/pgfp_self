/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村住房保障达标情况统计表Entity
 * @author zhaojf
 * @version 2017-11-13
 */
public class CoHouseSecurity extends DataEntity<CoHouseSecurity> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// 主表id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private Integer hous;		// 农户数
	private Integer houseSecurityHous;		// 有住房保障的达标户数（包括房屋稳固安全、人均面积达13平方米）
	private Integer noHouseSecurityHous;		// 住房保障未达标户数
	private Integer houseDangerHous;		// 房屋不稳固安全户数
	private Integer areaLess13Hous;		// 人均面积不足13平方米户数
	private Double standardRate;		// 达标率

	private CoMain coMain;
	
	public CoHouseSecurity() {
		super();
	}

	public CoHouseSecurity(String id){
		super(id);
	}

	@Length(min=0, max=64, message="主表id长度必须介于 0 和 64 之间")
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
	
	public Integer getHouseSecurityHous() {
		return houseSecurityHous;
	}

	public void setHouseSecurityHous(Integer houseSecurityHous) {
		this.houseSecurityHous = houseSecurityHous;
	}
	
	public Integer getNoHouseSecurityHous() {
		return noHouseSecurityHous;
	}

	public void setNoHouseSecurityHous(Integer noHouseSecurityHous) {
		this.noHouseSecurityHous = noHouseSecurityHous;
	}
	
	public Integer getHouseDangerHous() {
		return houseDangerHous;
	}

	public void setHouseDangerHous(Integer houseDangerHous) {
		this.houseDangerHous = houseDangerHous;
	}
	
	public Integer getAreaLess13Hous() {
		return areaLess13Hous;
	}

	public void setAreaLess13Hous(Integer areaLess13Hous) {
		this.areaLess13Hous = areaLess13Hous;
	}
	
	public Double getStandardRate() {
		return standardRate;
	}

	public void setStandardRate(Double standardRate) {
		this.standardRate = standardRate;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村贫困户产业登记表Entity
 * @author zhaojf
 * @version 2017-11-09
 */
public class CoPoorHouIndustry extends DataEntity<CoPoorHouIndustry> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// 主表id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private String householdName;		// 户主姓名
	private Integer memberNum;		// 家庭人口数
	private String isIndustry1;		// 是否有产业1
	private Double industry1Scale;		// 产业1规模
	private String isIndustry2;		// 是否有产业2
	private Double industry2Scale;		// 产业2规模
	private String isIndustry3;		// 是否有产业3
	private Double industry3Scale;		// 产业3规模

	private CoMain coMain;

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}

	public CoPoorHouIndustry() {
		super();
	}

	public CoPoorHouIndustry(String id){
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
	
	@Length(min=0, max=64, message="户主姓名长度必须介于 0 和 64 之间")
	public String getHouseholdName() {
		return householdName;
	}

	public void setHouseholdName(String householdName) {
		this.householdName = householdName;
	}
	
	public Integer getMemberNum() {
		return memberNum;
	}

	public void setMemberNum(Integer memberNum) {
		this.memberNum = memberNum;
	}
	
	@Length(min=0, max=1, message="是否有产业1长度必须介于 0 和 1 之间")
	public String getIsIndustry1() {
		return isIndustry1;
	}

	public void setIsIndustry1(String isIndustry1) {
		this.isIndustry1 = isIndustry1;
	}
	
	@Length(min=0, max=1, message="是否有产业2长度必须介于 0 和 1 之间")
	public String getIsIndustry2() {
		return isIndustry2;
	}

	public void setIsIndustry2(String isIndustry2) {
		this.isIndustry2 = isIndustry2;
	}
	
	@Length(min=0, max=1, message="是否有产业3长度必须介于 0 和 1 之间")
	public String getIsIndustry3() {
		return isIndustry3;
	}

	public void setIsIndustry3(String isIndustry3) {
		this.isIndustry3 = isIndustry3;
	}

	public Double getIndustry1Scale() {
		return industry1Scale;
	}

	public void setIndustry1Scale(Double industry1Scale) {
		this.industry1Scale = industry1Scale;
	}

	public Double getIndustry2Scale() {
		return industry2Scale;
	}

	public void setIndustry2Scale(Double industry2Scale) {
		this.industry2Scale = industry2Scale;
	}

	public Double getIndustry3Scale() {
		return industry3Scale;
	}

	public void setIndustry3Scale(Double industry3Scale) {
		this.industry3Scale = industry3Scale;
	}
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 贫困户劳动力情况表Entity
 * @author wumx
 * @version 2017-11-09
 */
public class CoLaborSituation extends DataEntity<CoLaborSituation> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 自然村屯id
	private String housename;		// 户主姓名
	private Integer familyNumber;		// 家庭人口数
	private String isNoLabor;		// 是否无劳动能力户
	private String isLaborOut;		// 是否劳动力外出
	private String workNumber;		// 务工人数
	private String workPlace;		// 务工地
	
	public CoLaborSituation() {
		super();
	}

	public CoLaborSituation(String id){
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
	
	@Length(min=0, max=64, message="自然村屯id长度必须介于 0 和 64 之间")
	public String getNatureId() {
		return natureId;
	}

	public void setNatureId(String natureId) {
		this.natureId = natureId;
	}
	
	@Length(min=0, max=30, message="户主姓名长度必须介于 0 和 30 之间")
	public String getHousename() {
		return housename;
	}

	public void setHousename(String housename) {
		this.housename = housename;
	}
	
	@Length(min=0, max=11, message="家庭人口数长度必须介于 0 和 11 之间")
	public Integer getFamilyNumber() {
		return familyNumber;
	}

	public void setFamilyNumber(Integer familyNumber) {
		this.familyNumber = familyNumber;
	}
	
	@Length(min=0, max=1, message="是否无劳动能力户长度必须介于 0 和 1 之间")
	public String getIsNoLabor() {
		return isNoLabor;
	}

	public void setIsNoLabor(String isNoLabor) {
		this.isNoLabor = isNoLabor;
	}
	
	@Length(min=0, max=1, message="是否劳动力外出长度必须介于 0 和 1 之间")
	public String getIsLaborOut() {
		return isLaborOut;
	}

	public void setIsLaborOut(String isLaborOut) {
		this.isLaborOut = isLaborOut;
	}
	
	@Length(min=0, max=11, message="务工人数长度必须介于 0 和 11 之间")
	public String getWorkNumber() {
		return workNumber;
	}

	public void setWorkNumber(String workNumber) {
		this.workNumber = workNumber;
	}
	
	@Length(min=0, max=500, message="务工地长度必须介于 0 和 500 之间")
	public String getWorkPlace() {
		return workPlace;
	}

	public void setWorkPlace(String workPlace) {
		this.workPlace = workPlace;
	}
	
}
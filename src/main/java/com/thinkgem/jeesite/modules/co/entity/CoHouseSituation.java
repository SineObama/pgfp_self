/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 住房保障未达标户名单情况表Entity
 * @author wumx
 * @version 2017-11-09
 */
public class CoHouseSituation extends DataEntity<CoHouseSituation> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 自然村屯id
	private String housename;		// 户主姓名
	private Integer familyNumber;		// 家庭人口数
	private String reason;		// 未达标原因
	private String solve;		// 解决措施
	
	public CoHouseSituation() {
		super();
	}

	public CoHouseSituation(String id){
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
	
	@Length(min=0, max=500, message="未达标原因长度必须介于 0 和 500 之间")
	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
	
	@Length(min=0, max=500, message="解决措施长度必须介于 0 和 500 之间")
	public String getSolve() {
		return solve;
	}

	public void setSolve(String solve) {
		this.solve = solve;
	}
	
}
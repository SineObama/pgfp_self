/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 患病救治和补助报销情况统计Entity
 * @author wumx
 * @version 2017-11-14
 */
public class CoIllTreatment extends DataEntity<CoIllTreatment> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 自然村屯id
	private Integer illHou;		// 患病贫困户数
	private Integer illPer;		// 患病人数
	private Integer treatPer;		// 得到有效救治人数
	private Integer reimbursePer;		// 得到补助报销人数
	
	public CoIllTreatment() {
		super();
	}

	public CoIllTreatment(String id){
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
	
	@Length(min=0, max=11, message="患病贫困户数长度必须介于 0 和 11 之间")
	public Integer getIllHou() {
		return illHou;
	}

	public void setIllHou(Integer illHou) {
		this.illHou = illHou;
	}
	
	@Length(min=0, max=11, message="患病人数长度必须介于 0 和 11 之间")
	public Integer getIllPer() {
		return illPer;
	}

	public void setIllPer(Integer illPer) {
		this.illPer = illPer;
	}
	
	@Length(min=0, max=11, message="得到有效救治人数长度必须介于 0 和 11 之间")
	public Integer getTreatPer() {
		return treatPer;
	}

	public void setTreatPer(Integer treatPer) {
		this.treatPer = treatPer;
	}
	
	@Length(min=0, max=11, message="得到补助报销人数长度必须介于 0 和 11 之间")
	public Integer getReimbursePer() {
		return reimbursePer;
	}

	public void setReimbursePer(Integer reimbursePer) {
		this.reimbursePer = reimbursePer;
	}
	
}
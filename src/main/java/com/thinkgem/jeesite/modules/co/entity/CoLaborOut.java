/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 劳动力长期外出统计表Entity
 * @author wumx
 * @version 2017-11-06
 */
public class CoLaborOut extends DataEntity<CoLaborOut> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 自然村屯id
	private Integer noOrOutHou;		// 无劳动力或主要劳动力外出户数
	private Integer noOrOutPer;		// 无劳动力或主要劳动力外出人数
	private Integer noWorkHou;		// 无劳动力户数
	private Integer noWorkPer;		// 无劳动力户数
	private Integer workOutHou;		// 外出务工户数
	private Integer workOutPer;		// 外出务工人数
	
	public CoLaborOut() {
		super();
	}

	public CoLaborOut(String id){
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
	
	@Length(min=0, max=11, message="无劳动力或主要劳动力外出户数长度必须介于 0 和 11 之间")
	public Integer getNoOrOutHou() {
		return noOrOutHou;
	}

	public void setNoOrOutHou(Integer noOrOutHou) {
		this.noOrOutHou = noOrOutHou;
	}
	
	@Length(min=0, max=11, message="无劳动力或主要劳动力外出人数长度必须介于 0 和 11 之间")
	public Integer getNoOrOutPer() {
		return noOrOutPer;
	}

	public void setNoOrOutPer(Integer noOrOutPer) {
		this.noOrOutPer = noOrOutPer;
	}
	
	@Length(min=0, max=11, message="无劳动力户数长度必须介于 0 和 11 之间")
	public Integer getNoWorkHou() {
		return noWorkHou;
	}

	public void setNoWorkHou(Integer noWorkHou) {
		this.noWorkHou = noWorkHou;
	}
	
	@Length(min=0, max=11, message="无劳动力户数长度必须介于 0 和 11 之间")
	public Integer getNoWorkPer() {
		return noWorkPer;
	}

	public void setNoWorkPer(Integer noWorkPer) {
		this.noWorkPer = noWorkPer;
	}
	
	@Length(min=0, max=11, message="外出务工户数长度必须介于 0 和 11 之间")
	public Integer getWorkOutHou() {
		return workOutHou;
	}

	public void setWorkOutHou(Integer workOutHou) {
		this.workOutHou = workOutHou;
	}
	
	@Length(min=0, max=11, message="外出务工人数长度必须介于 0 和 11 之间")
	public Integer getWorkOutPer() {
		return workOutPer;
	}

	public void setWorkOutPer(Integer workOutPer) {
		this.workOutPer = workOutPer;
	}
	
}
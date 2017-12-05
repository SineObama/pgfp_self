/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 1-3个特色产业Entity
 * @author zhaojf
 * @version 2017-11-06
 */
public class CoIndustry extends DataEntity<CoIndustry> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// 主表id
	private String industry1;		// 产业1
	private String industry2;		// 产业2
	private String industry3;		// 产业3

	private String industry1Unit;
	private String industry2Unit;
	private String industry3Unit;
	
	public CoIndustry() {
		super();
	}

	public CoIndustry(String id){
		super(id);
	}

	@Length(min=0, max=64, message="主表id长度必须介于 0 和 64 之间")
	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}
	
	@Length(min=0, max=64, message="产业1长度必须介于 0 和 64 之间")
	public String getIndustry1() {
		return industry1;
	}

	public void setIndustry1(String industry1) {
		this.industry1 = industry1;
	}
	
	@Length(min=0, max=64, message="产业2长度必须介于 0 和 64 之间")
	public String getIndustry2() {
		return industry2;
	}

	public void setIndustry2(String industry2) {
		this.industry2 = industry2;
	}
	
	@Length(min=0, max=64, message="产业3长度必须介于 0 和 64 之间")
	public String getIndustry3() {
		return industry3;
	}

	public void setIndustry3(String industry3) {
		this.industry3 = industry3;
	}

	public String getIndustry1Unit() {
		return industry1Unit;
	}

	public void setIndustry1Unit(String industry1Unit) {
		this.industry1Unit = industry1Unit;
	}

	public String getIndustry2Unit() {
		return industry2Unit;
	}

	public void setIndustry2Unit(String industry2Unit) {
		this.industry2Unit = industry2Unit;
	}

	public String getIndustry3Unit() {
		return industry3Unit;
	}

	public void setIndustry3Unit(String industry3Unit) {
		this.industry3Unit = industry3Unit;
	}
}
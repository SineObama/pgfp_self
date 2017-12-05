/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村贫困户纳入农村低保情况统计表Entity
 * @author zhaojf
 * @version 2017-11-27
 */
public class CoAllowances extends BaseCoEntity<CoAllowances> {
	
	private static final long serialVersionUID = 1L;
	private Integer poorHous;		// 贫困户数
	private Integer shouldBringIntoHous;		// 符合条件应纳入农村低保户数
	private Integer haveBringIntoHous;		// 已纳入农村低保户数
	private Double rate;		// 符合条件纳入率

	public CoAllowances() {
		super();
	}

	public CoAllowances(String id){
		super(id);
	}
	
	public Integer getPoorHous() {
		return poorHous;
	}

	public void setPoorHous(Integer poorHous) {
		this.poorHous = poorHous;
	}
	
	public Integer getShouldBringIntoHous() {
		return shouldBringIntoHous;
	}

	public void setShouldBringIntoHous(Integer shouldBringIntoHous) {
		this.shouldBringIntoHous = shouldBringIntoHous;
	}
	
	public Integer getHaveBringIntoHous() {
		return haveBringIntoHous;
	}

	public void setHaveBringIntoHous(Integer haveBringIntoHous) {
		this.haveBringIntoHous = haveBringIntoHous;
	}
	
	public Double getRate() {
		return rate;
	}

	public void setRate(Double rate) {
		this.rate = rate;
	}
}
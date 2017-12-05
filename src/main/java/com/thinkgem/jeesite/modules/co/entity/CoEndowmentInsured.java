/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村城乡居民养老保险参保情况统计表Entity
 * @author zhaojf
 * @version 2017-11-24
 */
public class CoEndowmentInsured extends DataEntity<CoEndowmentInsured> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private Integer shouldInsured;		// 应该参保人数
	private Integer actualInsured;		// 实际参保人数
	private Double insuredRate;		// 参保率
	private Integer actualFeeNum;		// 截止填报日期实际缴费人数
	private Integer insuredNum;		// 参保人数
	private Integer endowmentInsured;		// 领取养老保险待遇人数
	private Double receiveRate;		// 领取率

	private CoMain coMain;
	
	public CoEndowmentInsured() {
		super();
	}

	public CoEndowmentInsured(String id){
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
	
	public Integer getShouldInsured() {
		return shouldInsured;
	}

	public void setShouldInsured(Integer shouldInsured) {
		this.shouldInsured = shouldInsured;
	}
	
	public Integer getActualInsured() {
		return actualInsured;
	}

	public void setActualInsured(Integer actualInsured) {
		this.actualInsured = actualInsured;
	}
	
	public Double getInsuredRate() {
		return insuredRate;
	}

	public void setInsuredRate(Double insuredRate) {
		this.insuredRate = insuredRate;
	}
	
	public Integer getActualFeeNum() {
		return actualFeeNum;
	}

	public void setActualFeeNum(Integer actualFeeNum) {
		this.actualFeeNum = actualFeeNum;
	}
	
	public Integer getInsuredNum() {
		return insuredNum;
	}

	public void setInsuredNum(Integer insuredNum) {
		this.insuredNum = insuredNum;
	}
	
	public Integer getEndowmentInsured() {
		return endowmentInsured;
	}

	public void setEndowmentInsured(Integer endowmentInsured) {
		this.endowmentInsured = endowmentInsured;
	}
	
	public Double getReceiveRate() {
		return receiveRate;
	}

	public void setReceiveRate(Double receiveRate) {
		this.receiveRate = receiveRate;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
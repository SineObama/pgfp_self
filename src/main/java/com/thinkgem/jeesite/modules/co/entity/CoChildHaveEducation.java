/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村适龄儿童少年接受义务教育情况统计表Entity
 * @author zhaojf
 * @version 2017-11-15
 */
public class CoChildHaveEducation extends DataEntity<CoChildHaveEducation> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// 主表id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private Integer shouldEducation;		// 适龄儿童少年应接受义务教育人数
	private Integer haveEducation;		// 适龄儿童少年已接受义务教育人数
	private Integer haveEducationPolicy;		// 享受义务教育扶贫政策人数
	private Integer noHaveEducation;		// 未接受义务教育人数
	private Integer poorNoEducation;		// 因经济困难辍学人数
	private Double dropOutRate;		// 辍学率

	private CoMain coMain;

	public CoChildHaveEducation() {
		super();
	}

	public CoChildHaveEducation(String id){
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
	
	public Integer getShouldEducation() {
		return shouldEducation;
	}

	public void setShouldEducation(Integer shouldEducation) {
		this.shouldEducation = shouldEducation;
	}
	
	public Integer getHaveEducation() {
		return haveEducation;
	}

	public void setHaveEducation(Integer haveEducation) {
		this.haveEducation = haveEducation;
	}
	
	public Integer getHaveEducationPolicy() {
		return haveEducationPolicy;
	}

	public void setHaveEducationPolicy(Integer haveEducationPolicy) {
		this.haveEducationPolicy = haveEducationPolicy;
	}
	
	public Integer getNoHaveEducation() {
		return noHaveEducation;
	}

	public void setNoHaveEducation(Integer noHaveEducation) {
		this.noHaveEducation = noHaveEducation;
	}
	
	public Integer getPoorNoEducation() {
		return poorNoEducation;
	}

	public void setPoorNoEducation(Integer poorNoEducation) {
		this.poorNoEducation = poorNoEducation;
	}
	
	public Double getDropOutRate() {
		return dropOutRate;
	}

	public void setDropOutRate(Double dropOutRate) {
		this.dropOutRate = dropOutRate;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
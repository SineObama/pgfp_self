/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村居民购买医疗保险或商业保险情况统计表Entity
 * @author zhaojf
 * @version 2017-11-14
 */
public class CoBuyMedicalInsurance extends DataEntity<CoBuyMedicalInsurance> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// 主表id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private Integer hous;		// 农户数
	private Integer haveInsuranceHous;		// 参加城乡居民基本医疗保险（含大病保险）或商业保险户数
	private Double haveInsuranceRate;		// 参加城乡居民基本医疗保险（含大病保险）或商业保险购买率
	private Integer medicalInsuranceHous;		// 购买医疗保险户数
	private Double medicalInsuranceRate;		// 医疗保险购买率
	private Integer commercialInsuranceHous;		// 商业保险购买户数
	private Double commercialInsuranceRate;		// 商业保险购买率

	private CoMain coMain;

	public CoBuyMedicalInsurance() {
		super();
	}

	public CoBuyMedicalInsurance(String id){
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
	
	public Integer getHaveInsuranceHous() {
		return haveInsuranceHous;
	}

	public void setHaveInsuranceHous(Integer haveInsuranceHous) {
		this.haveInsuranceHous = haveInsuranceHous;
	}
	
	public Double getHaveInsuranceRate() {
		return haveInsuranceRate;
	}

	public void setHaveInsuranceRate(Double haveInsuranceRate) {
		this.haveInsuranceRate = haveInsuranceRate;
	}
	
	public Integer getMedicalInsuranceHous() {
		return medicalInsuranceHous;
	}

	public void setMedicalInsuranceHous(Integer medicalInsuranceHous) {
		this.medicalInsuranceHous = medicalInsuranceHous;
	}
	
	public Double getMedicalInsuranceRate() {
		return medicalInsuranceRate;
	}

	public void setMedicalInsuranceRate(Double medicalInsuranceRate) {
		this.medicalInsuranceRate = medicalInsuranceRate;
	}
	
	public Integer getCommercialInsuranceHous() {
		return commercialInsuranceHous;
	}

	public void setCommercialInsuranceHous(Integer commercialInsuranceHous) {
		this.commercialInsuranceHous = commercialInsuranceHous;
	}
	
	public Double getCommercialInsuranceRate() {
		return commercialInsuranceRate;
	}

	public void setCommercialInsuranceRate(Double commercialInsuranceRate) {
		this.commercialInsuranceRate = commercialInsuranceRate;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
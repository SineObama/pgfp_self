/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村特色产业情况统计表Entity
 * @author zhaojf
 * @version 2017-11-06
 */
public class CoCharacterIndustry extends DataEntity<CoCharacterIndustry> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// 主表id
	private CoMain coMain;
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）id
	private Integer poorHous;		// 贫困户数
	private Integer nolobHous;		// 无劳动能力或主要劳动力长期外出务工的贫困户数
	private Integer industry13Hous;		// 1-3个特色产业覆盖贫困户数
	private Double industry13Rate;		// 1-3个特色产业覆盖率
	private Integer industry1Hous;		// 产业1覆盖贫困户数
	private Double industry1Rate;		// 产业1覆盖率
	private Integer industry2Hous;		// 产业2覆盖贫困户数
	private Double industry2Rate;		// 产业2覆盖率
	private Integer industry3Hous;		// 产业3覆盖贫困户数
	private Double industry3Rate;		// 产业3覆盖率
	
	public CoCharacterIndustry() {
		super();
	}

	public CoCharacterIndustry(String id){
		super(id);
	}

	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}

	public Integer getIdx() {
		return idx;
	}

	public void setIdx(Integer idx) {
		this.idx = idx;
	}

	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}

	public Integer getPoorHous() {
		return poorHous;
	}

	public void setPoorHous(Integer poorHous) {
		this.poorHous = poorHous;
	}

	public Integer getNolobHous() {
		return nolobHous;
	}

	public void setNolobHous(Integer nolobHous) {
		this.nolobHous = nolobHous;
	}

	public Integer getIndustry13Hous() {
		return industry13Hous;
	}

	public void setIndustry13Hous(Integer industry13Hous) {
		this.industry13Hous = industry13Hous;
	}

	public Double getIndustry13Rate() {
		return industry13Rate;
	}

	public void setIndustry13Rate(Double industry13Rate) {
		this.industry13Rate = industry13Rate;
	}

	public Integer getIndustry1Hous() {
		return industry1Hous;
	}

	public void setIndustry1Hous(Integer industry1Hous) {
		this.industry1Hous = industry1Hous;
	}

	public Double getIndustry1Rate() {
		return industry1Rate;
	}

	public void setIndustry1Rate(Double industry1Rate) {
		this.industry1Rate = industry1Rate;
	}

	public Integer getIndustry2Hous() {
		return industry2Hous;
	}

	public void setIndustry2Hous(Integer industry2Hous) {
		this.industry2Hous = industry2Hous;
	}

	public Double getIndustry2Rate() {
		return industry2Rate;
	}

	public void setIndustry2Rate(Double industry2Rate) {
		this.industry2Rate = industry2Rate;
	}

	public Integer getIndustry3Hous() {
		return industry3Hous;
	}

	public void setIndustry3Hous(Integer industry3Hous) {
		this.industry3Hous = industry3Hous;
	}

	public Double getIndustry3Rate() {
		return industry3Rate;
	}

	public void setIndustry3Rate(Double industry3Rate) {
		this.industry3Rate = industry3Rate;
	}
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村适龄儿童少年应接受义务教育未接受名单Entity
 * @author zhaojf
 * @version 2017-11-16
 */
public class CoNoEducation extends DataEntity<CoNoEducation> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// 主表id
	private Integer idx;		// 序号
	private String countryId;		// 自然村（屯）
	private String name;		// 应接受义务教育未接受适龄儿童少年姓名
	private Date birth;		// 出生年月
	private String householdName;		// 户主姓名
	private String dropoutReason;		// 辍学原因
	private Integer rebackTime;		// 入户劝返次数

	private CoMain coMain;
	
	public CoNoEducation() {
		super();
	}

	public CoNoEducation(String id){
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
	
	@Length(min=0, max=64, message="应接受义务教育未接受适龄儿童少年姓名长度必须介于 0 和 64 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}
	
	@Length(min=0, max=64, message="户主姓名长度必须介于 0 和 64 之间")
	public String getHouseholdName() {
		return householdName;
	}

	public void setHouseholdName(String householdName) {
		this.householdName = householdName;
	}
	
	@Length(min=0, max=255, message="辍学原因长度必须介于 0 和 255 之间")
	public String getDropoutReason() {
		return dropoutReason;
	}

	public void setDropoutReason(String dropoutReason) {
		this.dropoutReason = dropoutReason;
	}
	
	public Integer getRebackTime() {
		return rebackTime;
	}

	public void setRebackTime(Integer rebackTime) {
		this.rebackTime = rebackTime;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
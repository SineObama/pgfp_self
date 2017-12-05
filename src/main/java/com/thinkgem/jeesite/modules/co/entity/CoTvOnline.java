/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 农户能看电视或上网情况统计表Entity
 * @author wumx
 * @version 2017-11-24
 */
public class CoTvOnline extends DataEntity<CoTvOnline> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 乡镇
	private Integer household;		// 农户数
	private Integer digitalHou;		// 有电视看或有电脑（只能手机）能上网户数
	private Integer tvHou;		// 电视机户数
	private Integer pcHou;		// 电脑户数
	private Integer phoneHou;		// 手机户数
	private Integer noDigitalHou;		// 未有电视机且未有电脑或者智能手机上网户数
	private Double percent;		// 能收看中央和广西电视频道或上网比例
	
	public CoTvOnline() {
		super();
	}

	public CoTvOnline(String id){
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
	
	@Length(min=0, max=64, message="乡镇长度必须介于 0 和 64 之间")
	public String getNatureId() {
		return natureId;
	}

	public void setNatureId(String natureId) {
		this.natureId = natureId;
	}
	
	@Length(min=0, max=11, message="农户数长度必须介于 0 和 11 之间")
	public Integer getHousehold() {
		return household;
	}

	public void setHousehold(Integer household) {
		this.household = household;
	}
	
	@Length(min=0, max=11, message="有电视看或有电脑（只能手机）能上网户数长度必须介于 0 和 11 之间")
	public Integer getDigitalHou() {
		return digitalHou;
	}

	public void setDigitalHou(Integer digitalHou) {
		this.digitalHou = digitalHou;
	}
	
	@Length(min=0, max=11, message="电视机户数长度必须介于 0 和 11 之间")
	public Integer getTvHou() {
		return tvHou;
	}

	public void setTvHou(Integer tvHou) {
		this.tvHou = tvHou;
	}
	
	@Length(min=0, max=11, message="电脑户数长度必须介于 0 和 11 之间")
	public Integer getPcHou() {
		return pcHou;
	}

	public void setPcHou(Integer pcHou) {
		this.pcHou = pcHou;
	}
	
	@Length(min=0, max=11, message="手机户数长度必须介于 0 和 11 之间")
	public Integer getPhoneHou() {
		return phoneHou;
	}

	public void setPhoneHou(Integer phoneHou) {
		this.phoneHou = phoneHou;
	}
	
	@Length(min=0, max=11, message="未有电视机且未有电脑或者智能手机上网户数长度必须介于 0 和 11 之间")
	public Integer getNoDigitalHou() {
		return noDigitalHou;
	}

	public void setNoDigitalHou(Integer noDigitalHou) {
		this.noDigitalHou = noDigitalHou;
	}
	
	public Double getPercent() {
		return percent;
	}

	public void setPercent(Double percent) {
		this.percent = percent;
	}
	
}
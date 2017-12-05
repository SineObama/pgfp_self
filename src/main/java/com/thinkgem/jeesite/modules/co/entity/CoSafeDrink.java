/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 安全饮水达标情况统计表Entity
 * @author wumx
 * @version 2017-11-15
 */
public class CoSafeDrink extends DataEntity<CoSafeDrink> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 自然村屯id
	private Integer household;		// 户数
	private Integer drinkHou;		// 有安全饮水户数
	private Integer wells;		// 打井户数
	private Integer tankHou;		// 水柜户数
	private Integer cellar;		// 水窖户数
	private Integer springWaterHou;		// 引用山泉水户数
	private Integer tapWater;		// 自来水用户
	private Integer unsafeDrinkHou;		// 未达到安全饮用水户数
	private Double percent;		// 安全饮水达标率
	
	public CoSafeDrink() {
		super();
	}

	public CoSafeDrink(String id){
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
	
	@Length(min=0, max=11, message="户主姓名长度必须介于 0 和 11 之间")
	public Integer getHousehold() {
		return household;
	}

	public void setHousehold(Integer household) {
		this.household = household;
	}
	
	@Length(min=0, max=11, message="有安全饮水户数长度必须介于 0 和 11 之间")
	public Integer getDrinkHou() {
		return drinkHou;
	}

	public void setDrinkHou(Integer drinkHou) {
		this.drinkHou = drinkHou;
	}
	
	@Length(min=0, max=11, message="打井户数长度必须介于 0 和 11 之间")
	public Integer getWells() {
		return wells;
	}

	public void setWells(Integer wells) {
		this.wells = wells;
	}
	
	@Length(min=0, max=11, message="水柜户数长度必须介于 0 和 11 之间")
	public Integer getTankHou() {
		return tankHou;
	}

	public void setTankHou(Integer tankHou) {
		this.tankHou = tankHou;
	}
	
	@Length(min=0, max=11, message="水窖户数长度必须介于 0 和 11 之间")
	public Integer getCellar() {
		return cellar;
	}

	public void setCellar(Integer cellar) {
		this.cellar = cellar;
	}
	
	@Length(min=0, max=11, message="引用山泉水户数长度必须介于 0 和 11 之间")
	public Integer getSpringWaterHou() {
		return springWaterHou;
	}

	public void setSpringWaterHou(Integer springWaterHou) {
		this.springWaterHou = springWaterHou;
	}
	
	@Length(min=0, max=11, message="自来水用户长度必须介于 0 和 11 之间")
	public Integer getTapWater() {
		return tapWater;
	}

	public void setTapWater(Integer tapWater) {
		this.tapWater = tapWater;
	}
	
	@Length(min=0, max=11, message="未达到安全饮用水户数长度必须介于 0 和 11 之间")
	public Integer getUnsafeDrinkHou() {
		return unsafeDrinkHou;
	}

	public void setUnsafeDrinkHou(Integer unsafeDrinkHou) {
		this.unsafeDrinkHou = unsafeDrinkHou;
	}
	
	public Double getPercent() {
		return percent;
	}

	public void setPercent(Double percent) {
		this.percent = percent;
	}
	
}
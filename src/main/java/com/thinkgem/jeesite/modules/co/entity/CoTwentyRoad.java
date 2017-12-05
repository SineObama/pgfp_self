/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 20户以上自然村屯通路情况Entity
 * @author wumx
 * @version 2017-11-20
 */
public class CoTwentyRoad extends DataEntity<CoTwentyRoad> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 乡镇
	private String isRoad;		// 是否通硬化路
	private String roadName;		// 砂石路或硬化路
	private Double subgrade;		// 路基宽（米）
	private Double mileage;		// 里程（公里）
	private Date openTime;		// 通车时间
	private String place;		// 地点
	private Double length;		// 长度
	
	public CoTwentyRoad() {
		super();
	}

	public CoTwentyRoad(String id){
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
	
	@Length(min=0, max=1, message="是否通硬化路长度必须介于 0 和 1 之间")
	public String getIsRoad() {
		return isRoad;
	}

	public void setIsRoad(String isRoad) {
		this.isRoad = isRoad;
	}
	
	@Length(min=0, max=64, message="砂石路或硬化路长度必须介于 0 和 64 之间")
	public String getRoadName() {
		return roadName;
	}

	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}
	
	public Double getSubgrade() {
		return subgrade;
	}

	public void setSubgrade(Double subgrade) {
		this.subgrade = subgrade;
	}
	
	public Double getMileage() {
		return mileage;
	}

	public void setMileage(Double mileage) {
		this.mileage = mileage;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getOpenTime() {
		return openTime;
	}

	public void setOpenTime(Date openTime) {
		this.openTime = openTime;
	}
	
	@Length(min=0, max=100, message="地点长度必须介于 0 和 100 之间")
	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
	
	public Double getLength() {
		return length;
	}

	public void setLength(Double length) {
		this.length = length;
	}
	
}
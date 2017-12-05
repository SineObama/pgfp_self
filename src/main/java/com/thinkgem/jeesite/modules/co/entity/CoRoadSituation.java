/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 通硬化路情况Entity
 * @author wumx
 * @version 2017-11-17
 */
public class CoRoadSituation extends DataEntity<CoRoadSituation> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String countyId;		// 乡镇
	private String countryId;		// country_id
	private String isRoad;		// 是否通硬化路
	private String roadName;		// 连接的上级路网或其他乡镇路网的道路名称
	private String villageLocation;		// 通达本村地点
	private Double subgrade;		// 路基宽（米）
	private Double pavement;		// 路面宽（米）
	private Double mileage;		// 里程（公里）
	private Date openTime;		// 通车时间
	private String place;		// 地点
	private Double length;		// 长度
	
	public CoRoadSituation() {
		super();
	}

	public CoRoadSituation(String id){
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
	public String getCountyId() {
		return countyId;
	}

	public void setCountyId(String countyId) {
		this.countyId = countyId;
	}
	
	@Length(min=0, max=64, message="country_id长度必须介于 0 和 64 之间")
	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}
	
	@Length(min=0, max=1, message="是否通硬化路长度必须介于 0 和 1 之间")
	public String getIsRoad() {
		return isRoad;
	}

	public void setIsRoad(String isRoad) {
		this.isRoad = isRoad;
	}
	
	@Length(min=0, max=64, message="连接的上级路网或其他乡镇路网的道路名称长度必须介于 0 和 64 之间")
	public String getRoadName() {
		return roadName;
	}

	public void setRoadName(String roadName) {
		this.roadName = roadName;
	}
	
	@Length(min=0, max=100, message="通达本村地点长度必须介于 0 和 100 之间")
	public String getVillageLocation() {
		return villageLocation;
	}

	public void setVillageLocation(String villageLocation) {
		this.villageLocation = villageLocation;
	}
	
	public Double getSubgrade() {
		return subgrade;
	}

	public void setSubgrade(Double subgrade) {
		this.subgrade = subgrade;
	}
	
	public Double getPavement() {
		return pavement;
	}

	public void setPavement(Double pavement) {
		this.pavement = pavement;
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
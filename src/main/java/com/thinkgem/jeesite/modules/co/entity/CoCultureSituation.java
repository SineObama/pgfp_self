/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 篮球场，文化室或戏台情况Entity
 * @author wumx
 * @version 2017-11-22
 */
public class CoCultureSituation extends DataEntity<CoCultureSituation> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 自然村屯id
	private Integer basketballNum;		// 有篮球场个数
	private Integer cultureroomNum;		// 有文化室个数
	private Integer houseNum;		// 有农家书屋个数
	private Integer stage;		// 有戏台个数
	
	public CoCultureSituation() {
		super();
	}

	public CoCultureSituation(String id){
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
	
	@Length(min=0, max=11, message="有篮球场个数长度必须介于 0 和 11 之间")
	public Integer getBasketballNum() {
		return basketballNum;
	}

	public void setBasketballNum(Integer basketballNum) {
		this.basketballNum = basketballNum;
	}
	
	@Length(min=0, max=11, message="有文化室个数长度必须介于 0 和 11 之间")
	public Integer getCultureroomNum() {
		return cultureroomNum;
	}

	public void setCultureroomNum(Integer cultureroomNum) {
		this.cultureroomNum = cultureroomNum;
	}
	
	@Length(min=0, max=11, message="有农家书屋个数长度必须介于 0 和 11 之间")
	public Integer getHouseNum() {
		return houseNum;
	}

	public void setHouseNum(Integer houseNum) {
		this.houseNum = houseNum;
	}
	
	@Length(min=0, max=11, message="有戏台个数长度必须介于 0 和 11 之间")
	public Integer getStage() {
		return stage;
	}

	public void setStage(Integer stage) {
		this.stage = stage;
	}
	
}
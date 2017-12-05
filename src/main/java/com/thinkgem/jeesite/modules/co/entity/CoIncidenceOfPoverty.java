/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 贫困发生率统计表Entity
 * @author wumx
 * @version 2017-11-29
 */
public class CoIncidenceOfPoverty extends DataEntity<CoIncidenceOfPoverty> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String idx;		// 序号
	private String natureId;		// 自然村屯id
	private String countryNum;		// 乡村人口数
	private String poorNum1;		// 2013年底贫困人口数
	private String poorNum2;		// 2014年脱贫人数
	private String poorNum3;		// 2015年脱贫人数
	private String poorNum4;		// 2016年脱贫人数
	private String insertPoorNum;		// 新增贫困人口数
	private String returnPoorNum;		// 返贫人口数
	private String checkPoorNum;		// 核验时贫困人口数
	private String percent;		// 贫困发生率
	
	public CoIncidenceOfPoverty() {
		super();
	}

	public CoIncidenceOfPoverty(String id){
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
	
	@Length(min=0, max=11, message="乡村人口数长度必须介于 0 和 11 之间")
	public String getCountryNum() {
		return countryNum;
	}

	public void setCountryNum(String countryNum) {
		this.countryNum = countryNum;
	}
	
	@Length(min=0, max=11, message="2013年底贫困人口数长度必须介于 0 和 11 之间")
	public String getPoorNum1() {
		return poorNum1;
	}

	public void setPoorNum1(String poorNum1) {
		this.poorNum1 = poorNum1;
	}
	
	@Length(min=0, max=11, message="2014年脱贫人数长度必须介于 0 和 11 之间")
	public String getPoorNum2() {
		return poorNum2;
	}

	public void setPoorNum2(String poorNum2) {
		this.poorNum2 = poorNum2;
	}
	
	@Length(min=0, max=11, message="2015年脱贫人数长度必须介于 0 和 11 之间")
	public String getPoorNum3() {
		return poorNum3;
	}

	public void setPoorNum3(String poorNum3) {
		this.poorNum3 = poorNum3;
	}
	
	@Length(min=0, max=11, message="2016年脱贫人数长度必须介于 0 和 11 之间")
	public String getPoorNum4() {
		return poorNum4;
	}

	public void setPoorNum4(String poorNum4) {
		this.poorNum4 = poorNum4;
	}
	
	@Length(min=0, max=11, message="新增贫困人口数长度必须介于 0 和 11 之间")
	public String getInsertPoorNum() {
		return insertPoorNum;
	}

	public void setInsertPoorNum(String insertPoorNum) {
		this.insertPoorNum = insertPoorNum;
	}
	
	@Length(min=0, max=11, message="返贫人口数长度必须介于 0 和 11 之间")
	public String getReturnPoorNum() {
		return returnPoorNum;
	}

	public void setReturnPoorNum(String returnPoorNum) {
		this.returnPoorNum = returnPoorNum;
	}
	
	@Length(min=0, max=11, message="核验时贫困人口数长度必须介于 0 和 11 之间")
	public String getCheckPoorNum() {
		return checkPoorNum;
	}

	public void setCheckPoorNum(String checkPoorNum) {
		this.checkPoorNum = checkPoorNum;
	}
	
	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}
	
}
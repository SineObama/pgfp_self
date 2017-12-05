/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 村易地扶贫搬迁户住房保障情况表Entity
 * @author zhaojf
 * @version 2017-11-14
 */
public class CoPovertyRelocation extends DataEntity<CoPovertyRelocation> {
	
	private static final long serialVersionUID = 1L;
	private Integer idx;		// 序号
	private String mainId;		// 主表id
	private String countryId;		// 自然村（屯）
	private String householdName;		// 户主姓名
	private Integer memberNum;		// 家庭人口数
	private Double houseArea;		// 安置住房面积
	private String immigration;		// 迁入地
	private String qualityOk;		// 集中安置户房屋质量是否达标
	private String checkOk;		// 集中安置户是否达到入住条件
	private String keyOk;		// 集中安置户是否交钥匙
	private String isCheck;		// 分散安置户是否入住

	private CoMain coMain;
	
	public CoPovertyRelocation() {
		super();
	}

	public CoPovertyRelocation(String id){
		super(id);
	}

	public Integer getIdx() {
		return idx;
	}

	public void setIdx(Integer idx) {
		this.idx = idx;
	}
	
	@Length(min=0, max=64, message="主表id长度必须介于 0 和 64 之间")
	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}
	
	@Length(min=0, max=64, message="自然村（屯）长度必须介于 0 和 64 之间")
	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}
	
	@Length(min=0, max=64, message="户主姓名长度必须介于 0 和 64 之间")
	public String getHouseholdName() {
		return householdName;
	}

	public void setHouseholdName(String householdName) {
		this.householdName = householdName;
	}
	
	public Integer getMemberNum() {
		return memberNum;
	}

	public void setMemberNum(Integer memberNum) {
		this.memberNum = memberNum;
	}
	
	public Double getHouseArea() {
		return houseArea;
	}

	public void setHouseArea(Double houseArea) {
		this.houseArea = houseArea;
	}
	
	@Length(min=0, max=64, message="迁入地长度必须介于 0 和 64 之间")
	public String getImmigration() {
		return immigration;
	}

	public void setImmigration(String immigration) {
		this.immigration = immigration;
	}
	
	@Length(min=0, max=1, message="集中安置户房屋质量是否达标长度必须介于 0 和 1 之间")
	public String getQualityOk() {
		return qualityOk;
	}

	public void setQualityOk(String qualityOk) {
		this.qualityOk = qualityOk;
	}
	
	@Length(min=0, max=1, message="集中安置户是否达到入住条件长度必须介于 0 和 1 之间")
	public String getCheckOk() {
		return checkOk;
	}

	public void setCheckOk(String checkOk) {
		this.checkOk = checkOk;
	}
	
	@Length(min=0, max=1, message="集中安置户是否交钥匙长度必须介于 0 和 1 之间")
	public String getKeyOk() {
		return keyOk;
	}

	public void setKeyOk(String keyOk) {
		this.keyOk = keyOk;
	}
	
	@Length(min=0, max=1, message="分散安置户是否入住长度必须介于 0 和 1 之间")
	public String getIsCheck() {
		return isCheck;
	}

	public void setIsCheck(String isCheck) {
		this.isCheck = isCheck;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
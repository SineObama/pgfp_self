/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 贫困家庭学生享受教育精准扶贫政策情况统计表Entity
 * @author zhaojf
 * @version 2017-11-17
 */
public class CoPoorStudentPolicy extends DataEntity<CoPoorStudentPolicy> {
	
	private static final long serialVersionUID = 1L;
	private String mainId;		// main_id
	private String countryId;		// 填报单位
	private Integer preschoolStus;		// 贫困家庭学前教育学生数
	private Integer compulsoryStus;		// 贫困家庭义务教育学生数
	private Integer seniorHighStus;		// 贫困家庭普通高中学生数
	private Integer secondaryVocationalStus;		// 贫困家庭中职教育学生数
	private Integer higherEducationStus;		// 贫困家庭高等教育学生数
	private Integer totalStus;		// 贫困家庭学生数合计
	private String stusRemark;		// 贫困家庭学生数备注
	private Integer preschoolHelpNum;		// 学前教育资助人数
	private Integer compulsoryHelpNum;		// 义务教育资助人数
	private Integer seniorHighHelpNum;		// 普通高中资助人数
	private Integer secondaryVocationalHelpNum;		// 中职教育资助人数
	private Integer higherEducationHelpNum;		// 高等教育资助人数
	private Integer totalHelpNum;		// 资助人数合计
	private String helpNumRemark;		// 资助人数备注
	private Double compulsoryMoney;		// 义务教育资助金额
	private Double seniorHighMoney;		// 普通高中资助金额
	private Double secondaryVocationalMoney;		// 中职教育资助金额
	private Double higherEducationMoney;		// higher_education_money
	private Double totalMoney;		// 合计资助金额
	private String moneyRemark;		// 资助金额备注

	private CoMain coMain;

	public CoPoorStudentPolicy() {
		super();
	}

	public CoPoorStudentPolicy(String id){
		super(id);
	}

	@Length(min=0, max=64, message="main_id长度必须介于 0 和 64 之间")
	public String getMainId() {
		return mainId;
	}

	public void setMainId(String mainId) {
		this.mainId = mainId;
	}
	
	@Length(min=0, max=64, message="填报单位长度必须介于 0 和 64 之间")
	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}
	
	public Integer getPreschoolStus() {
		return preschoolStus;
	}

	public void setPreschoolStus(Integer preschoolStus) {
		this.preschoolStus = preschoolStus;
	}
	
	public Integer getCompulsoryStus() {
		return compulsoryStus;
	}

	public void setCompulsoryStus(Integer compulsoryStus) {
		this.compulsoryStus = compulsoryStus;
	}
	
	public Integer getSeniorHighStus() {
		return seniorHighStus;
	}

	public void setSeniorHighStus(Integer seniorHighStus) {
		this.seniorHighStus = seniorHighStus;
	}
	
	public Integer getSecondaryVocationalStus() {
		return secondaryVocationalStus;
	}

	public void setSecondaryVocationalStus(Integer secondaryVocationalStus) {
		this.secondaryVocationalStus = secondaryVocationalStus;
	}
	
	public Integer getHigherEducationStus() {
		return higherEducationStus;
	}

	public void setHigherEducationStus(Integer higherEducationStus) {
		this.higherEducationStus = higherEducationStus;
	}
	
	public Integer getTotalStus() {
		return totalStus;
	}

	public void setTotalStus(Integer totalStus) {
		this.totalStus = totalStus;
	}
	
	@Length(min=0, max=64, message="贫困家庭学生数备注长度必须介于 0 和 64 之间")
	public String getStusRemark() {
		return stusRemark;
	}

	public void setStusRemark(String stusRemark) {
		this.stusRemark = stusRemark;
	}
	
	public Integer getPreschoolHelpNum() {
		return preschoolHelpNum;
	}

	public void setPreschoolHelpNum(Integer preschoolHelpNum) {
		this.preschoolHelpNum = preschoolHelpNum;
	}
	
	public Integer getCompulsoryHelpNum() {
		return compulsoryHelpNum;
	}

	public void setCompulsoryHelpNum(Integer compulsoryHelpNum) {
		this.compulsoryHelpNum = compulsoryHelpNum;
	}
	
	public Integer getSeniorHighHelpNum() {
		return seniorHighHelpNum;
	}

	public void setSeniorHighHelpNum(Integer seniorHighHelpNum) {
		this.seniorHighHelpNum = seniorHighHelpNum;
	}
	
	public Integer getSecondaryVocationalHelpNum() {
		return secondaryVocationalHelpNum;
	}

	public void setSecondaryVocationalHelpNum(Integer secondaryVocationalHelpNum) {
		this.secondaryVocationalHelpNum = secondaryVocationalHelpNum;
	}
	
	public Integer getHigherEducationHelpNum() {
		return higherEducationHelpNum;
	}

	public void setHigherEducationHelpNum(Integer higherEducationHelpNum) {
		this.higherEducationHelpNum = higherEducationHelpNum;
	}
	
	public Integer getTotalHelpNum() {
		return totalHelpNum;
	}

	public void setTotalHelpNum(Integer totalHelpNum) {
		this.totalHelpNum = totalHelpNum;
	}
	
	@Length(min=0, max=64, message="资助人数备注长度必须介于 0 和 64 之间")
	public String getHelpNumRemark() {
		return helpNumRemark;
	}

	public void setHelpNumRemark(String helpNumRemark) {
		this.helpNumRemark = helpNumRemark;
	}
	
	public Double getCompulsoryMoney() {
		return compulsoryMoney;
	}

	public void setCompulsoryMoney(Double compulsoryMoney) {
		this.compulsoryMoney = compulsoryMoney;
	}
	
	public Double getSeniorHighMoney() {
		return seniorHighMoney;
	}

	public void setSeniorHighMoney(Double seniorHighMoney) {
		this.seniorHighMoney = seniorHighMoney;
	}
	
	public Double getSecondaryVocationalMoney() {
		return secondaryVocationalMoney;
	}

	public void setSecondaryVocationalMoney(Double secondaryVocationalMoney) {
		this.secondaryVocationalMoney = secondaryVocationalMoney;
	}
	
	public Double getHigherEducationMoney() {
		return higherEducationMoney;
	}

	public void setHigherEducationMoney(Double higherEducationMoney) {
		this.higherEducationMoney = higherEducationMoney;
	}
	
	public Double getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(Double totalMoney) {
		this.totalMoney = totalMoney;
	}
	
	@Length(min=0, max=64, message="资助金额备注长度必须介于 0 和 64 之间")
	public String getMoneyRemark() {
		return moneyRemark;
	}

	public void setMoneyRemark(String moneyRemark) {
		this.moneyRemark = moneyRemark;
	}

	public CoMain getCoMain() {
		return coMain;
	}

	public void setCoMain(CoMain coMain) {
		this.coMain = coMain;
	}
}
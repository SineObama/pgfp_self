/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import com.thinkgem.jeesite.modules.sys.entity.Area;
import org.hibernate.validator.constraints.Length;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 行政村档案主表Entity
 * @author wumx
 * @version 2017-11-06
 */
public class CoMain extends DataEntity<CoMain> {
	
	private static final long serialVersionUID = 1L;
//	private String countryId;		// country_id
	private String years;		// 归属年度
	private String coId;		//村和年表id
	private Date fillDate;		// 填报时间
	private String auditor;		// 审核人
	private String formHolder;		// 填表人
	private String mobile;		// 联系电话
	private String type;		// 属于哪个表
	private Area area;
	private List<CoLaborOut> coLaborOutList;
	private List<CoLaborSituation> coLaborSituationList;
	private List<CoHouseSituation> coHouseSituationList;
	private List<CoInsuranceNameList> coInsuranceNameLists;
	private List<CoIllTreatment> coIllTreatmentList;
	private List<CoSafeDrink> coSafeDrinkList;
	private List<CoDrinkSituation> coDrinkSituationList;
	private List<CoRoadSituation> coRoadSituationList;
	private List<CoTwentyRoad> coTwentyRoadList;
	private List<CoCultureSituation> coCultureSituationList;
	private List<CoNetwork> coNetworkList;
	private List<CoTvOnline> coTvOnlineList;
	private List<CoDigitalCount> coDigitalCountList;
	private List<CoIncidenceOfPoverty> coIncidenceOfPovertyList;
	private CoIndustry coIndustry;

	public List<CoIncidenceOfPoverty> getCoIncidenceOfPovertyList() {
		return coIncidenceOfPovertyList;
	}

	public void setCoIncidenceOfPovertyList(List<CoIncidenceOfPoverty> coIncidenceOfPovertyList) {
		this.coIncidenceOfPovertyList = coIncidenceOfPovertyList;
	}

	public List<CoDigitalCount> getCoDigitalCountList() {
		return coDigitalCountList;
	}

	public void setCoDigitalCountList(List<CoDigitalCount> coDigitalCountList) {
		this.coDigitalCountList = coDigitalCountList;
	}

	public List<CoTvOnline> getCoTvOnlineList() {
		return coTvOnlineList;
	}

	public void setCoTvOnlineList(List<CoTvOnline> coTvOnlineList) {
		this.coTvOnlineList = coTvOnlineList;
	}

	public List<CoNetwork> getCoNetworkList() {
		return coNetworkList;
	}

	public void setCoNetworkList(List<CoNetwork> coNetworkList) {
		this.coNetworkList = coNetworkList;
	}

	public List<CoCultureSituation> getCoCultureSituationList() {
		return coCultureSituationList;
	}

	public void setCoCultureSituationList(List<CoCultureSituation> coCultureSituationList) {
		this.coCultureSituationList = coCultureSituationList;
	}

	public List<CoTwentyRoad> getCoTwentyRoadList() {
		return coTwentyRoadList;
	}

	public void setCoTwentyRoadList(List<CoTwentyRoad> coTwentyRoadList) {
		this.coTwentyRoadList = coTwentyRoadList;
	}

	public List<CoRoadSituation> getCoRoadSituationList() {
		return coRoadSituationList;
	}

	public void setCoRoadSituationList(List<CoRoadSituation> coRoadSituationList) {
		this.coRoadSituationList = coRoadSituationList;
	}

	public List<CoDrinkSituation> getCoDrinkSituationList() {
		return coDrinkSituationList;
	}

	public void setCoDrinkSituationList(List<CoDrinkSituation> coDrinkSituationList) {
		this.coDrinkSituationList = coDrinkSituationList;
	}

	public List<CoSafeDrink> getCoSafeDrinkList() {
		return coSafeDrinkList;
	}

	public void setCoSafeDrinkList(List<CoSafeDrink> coSafeDrinkList) {
		this.coSafeDrinkList = coSafeDrinkList;
	}

	public List<CoIllTreatment> getCoIllTreatmentList() {
		return coIllTreatmentList;
	}

	public void setCoIllTreatmentList(List<CoIllTreatment> coIllTreatmentList) {
		this.coIllTreatmentList = coIllTreatmentList;
	}

	private List<CoCharacterIndustry> industries = new ArrayList<>();

	private List<CoPoorHouIndustry> coPoorHouIndustries = new ArrayList<>();

	private List<CoHouseSecurity> coHouseSecurities = new ArrayList<>();

	private List<CoPovertyRelocation> relocations = new ArrayList<>();

	private List<CoBuyMedicalInsurance> insurances = new ArrayList<>();

	private List<CoChildHaveEducation> educations = new ArrayList<>();

	private List<CoNoEducation> noEducations = new ArrayList<>();

	private CoPoorStudentPolicy coPoorStudentPolicy;

	private List<CoHaveElectric> electrics = new ArrayList<>();

	private List<CoNoElectric> noElectrics = new ArrayList<>();

	private List<CoEndowmentInsured> insureds = new ArrayList<>();

	private List<CoNoEndowmentInsured> noInsureds = new ArrayList<>();

	private List<CoAllowances> allowances = new ArrayList<>();

	public List<CoInsuranceNameList> getCoInsuranceNameLists() {
		return coInsuranceNameLists;
	}

	public void setCoInsuranceNameLists(List<CoInsuranceNameList> coInsuranceNameLists) {
		this.coInsuranceNameLists = coInsuranceNameLists;
	}

	public List<CoHouseSituation> getCoHouseSituationList() {
		return coHouseSituationList;
	}

	public void setCoHouseSituationList(List<CoHouseSituation> coHouseSituationList) {
		this.coHouseSituationList = coHouseSituationList;
	}

	public List<CoLaborSituation> getCoLaborSituationList() {
		return coLaborSituationList;
	}

	public void setCoLaborSituationList(List<CoLaborSituation> coLaborSituationList) {
		this.coLaborSituationList = coLaborSituationList;
	}

	public List<CoLaborOut> getCoLaborOutList() {
		return coLaborOutList;
	}

	public void setCoLaborOutList(List<CoLaborOut> coLaborOutList) {
		this.coLaborOutList = coLaborOutList;
	}

	public List<CoPoorHouIndustry> getCoPoorHouIndustries() {
		return coPoorHouIndustries;
	}

	public void setCoPoorHouIndustries(List<CoPoorHouIndustry> coPoorHouIndustries) {
		this.coPoorHouIndustries = coPoorHouIndustries;
	}

	public CoMain() {
		super();
	}

	public CoMain(String id){
		super(id);
	}

	public String getCoId() {
		return coId;
	}

	public void setCoId(String coId) {
		this.coId = coId;
	}
//
//	@Length(min=0, max=64, message="country_id长度必须介于 0 和 64 之间")
//	public String getCountryId() {
//		return countryId;
//	}
//
//	public void setCountryId(String countryId) {
//		this.countryId = countryId;
//	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	@Length(min=0, max=10, message="归属年度长度必须介于 0 和 10 之间")
	public String getYears() {
		return years;
	}

	public void setYears(String years) {
		this.years = years;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getFillDate() {
		return fillDate;
	}

	public void setFillDate(Date fillDate) {
		this.fillDate = fillDate;
	}
	
	@Length(min=0, max=20, message="审核人长度必须介于 0 和 20 之间")
	public String getAuditor() {
		return auditor;
	}

	public void setAuditor(String auditor) {
		this.auditor = auditor;
	}
	
	@Length(min=0, max=20, message="填表人长度必须介于 0 和 20 之间")
	public String getFormHolder() {
		return formHolder;
	}

	public void setFormHolder(String formHolder) {
		this.formHolder = formHolder;
	}
	
	@Length(min=0, max=20, message="联系电话长度必须介于 0 和 20 之间")
	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	@Length(min=0, max=10, message="属于哪个表长度必须介于 0 和 10 之间")
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<CoCharacterIndustry> getIndustries() {
		return industries;
	}

	public void setIndustries(List<CoCharacterIndustry> industries) {
		this.industries = industries;
	}

	public CoIndustry getCoIndustry() {
		return coIndustry;
	}

	public void setCoIndustry(CoIndustry coIndustry) {
		this.coIndustry = coIndustry;
	}

	public List<CoHouseSecurity> getCoHouseSecurities() {
		return coHouseSecurities;
	}

	public void setCoHouseSecurities(List<CoHouseSecurity> coHouseSecurities) {
		this.coHouseSecurities = coHouseSecurities;
	}

	public List<CoPovertyRelocation> getRelocations() {
		return relocations;
	}

	public void setRelocations(List<CoPovertyRelocation> relocations) {
		this.relocations = relocations;
	}

	public List<CoBuyMedicalInsurance> getInsurances() {
		return insurances;
	}

	public void setInsurances(List<CoBuyMedicalInsurance> insurances) {
		this.insurances = insurances;
	}

	public List<CoChildHaveEducation> getEducations() {
		return educations;
	}

	public void setEducations(List<CoChildHaveEducation> educations) {
		this.educations = educations;
	}

	public List<CoNoEducation> getNoEducations() {
		return noEducations;
	}

	public void setNoEducations(List<CoNoEducation> noEducations) {
		this.noEducations = noEducations;
	}

	public CoPoorStudentPolicy getCoPoorStudentPolicy() {
		return coPoorStudentPolicy;
	}

	public void setCoPoorStudentPolicy(CoPoorStudentPolicy coPoorStudentPolicy) {
		this.coPoorStudentPolicy = coPoorStudentPolicy;
	}

	public List<CoHaveElectric> getElectrics() {
		return electrics;
	}

	public void setElectrics(List<CoHaveElectric> electrics) {
		this.electrics = electrics;
	}

	public List<CoNoElectric> getNoElectrics() {
		return noElectrics;
	}

	public void setNoElectrics(List<CoNoElectric> noElectrics) {
		this.noElectrics = noElectrics;
	}

	public List<CoEndowmentInsured> getInsureds() {
		return insureds;
	}

	public void setInsureds(List<CoEndowmentInsured> insureds) {
		this.insureds = insureds;
	}

	public List<CoNoEndowmentInsured> getNoInsureds() {
		return noInsureds;
	}

	public void setNoInsureds(List<CoNoEndowmentInsured> noInsureds) {
		this.noInsureds = noInsureds;
	}

	public List<CoAllowances> getAllowances() {
		return allowances;
	}

	public void setAllowances(List<CoAllowances> allowances) {
		this.allowances = allowances;
	}
}
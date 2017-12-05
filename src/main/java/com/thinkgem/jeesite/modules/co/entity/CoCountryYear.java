/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.entity;

import com.thinkgem.jeesite.modules.sys.entity.Area;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import java.util.Date;

/**
 * 村和年表Entity
 * @author zhaojf
 * @version 2017-11-06
 */
public class CoCountryYear extends DataEntity<CoCountryYear> {
	
	private static final long serialVersionUID = 1L;
	private String countryId;		// country_id
	private String years;		// years
	private Area area;
	private Date yearDate;

	public Date getYearDate() {
		return yearDate;
	}

	public void setYearDate(Date yearDate) {
		this.yearDate = yearDate;
	}

	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public CoCountryYear() {
		super();
	}

	public CoCountryYear(String id){
		super(id);
	}

	@Length(min=0, max=64, message="country_id长度必须介于 0 和 64 之间")
	public String getCountryId() {
		return countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}
	
	@Length(min=0, max=64, message="years长度必须介于 0 和 64 之间")
	public String getYears() {
		return years;
	}

	public void setYears(String years) {
		this.years = years;
	}
	
}
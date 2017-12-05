package com.thinkgem.jeesite.modules.co.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import org.hibernate.validator.constraints.Length;

public abstract class BaseCoEntity<T> extends DataEntity<T> {
    private String mainId;		// main_id
    private Integer idx;		// 序号
    private String countryId;		// 自然村（屯）

    private CoMain coMain;

    public BaseCoEntity() {
        super();
    }

    public BaseCoEntity(String id){
        super(id);
    }

    @Length(min=0, max=64, message="main_id长度必须介于 0 和 64 之间")
    public String getMainId() {
        return mainId;
    }

    public void setMainId(String mainId) {
        this.mainId = mainId;
    }

    public Integer getIdx() {
        return idx;
    }

    public void setIdx(Integer idx) {
        this.idx = idx;
    }

    @Length(min=0, max=64, message="自然村（屯）长度必须介于 0 和 64 之间")
    public String getCountryId() {
        return countryId;
    }

    public void setCountryId(String countryId) {
        this.countryId = countryId;
    }

    public CoMain getCoMain() {
        return coMain;
    }

    public void setCoMain(CoMain coMain) {
        this.coMain = coMain;
    }
}

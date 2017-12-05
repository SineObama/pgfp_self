package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.BaseEntity;
import com.thinkgem.jeesite.common.persistence.CrudDao;

import java.util.List;

public interface BaseCoDao<T extends BaseEntity<T>> extends CrudDao<T> {
    public List<T> getByMainId(String mainId);
}

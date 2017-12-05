package com.thinkgem.jeesite.modules.co.service;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.co.dao.BaseCoDao;
import com.thinkgem.jeesite.modules.co.entity.BaseCoEntity;

import java.util.List;

public abstract class BaseCoService<D extends BaseCoDao<T>, T extends BaseCoEntity<T>> extends CrudService<D, T> {
    public List<T> getByMainId(String mainId){
        return dao.getByMainId(mainId);
    }
}

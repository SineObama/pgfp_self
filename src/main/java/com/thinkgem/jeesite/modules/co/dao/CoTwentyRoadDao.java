/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.co.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.co.entity.CoTwentyRoad;

import java.util.List;

/**
 * 20户以上自然村屯通路情况DAO接口
 * @author wumx
 * @version 2017-11-20
 */
@MyBatisDao
public interface CoTwentyRoadDao extends CrudDao<CoTwentyRoad> {
    public List<CoTwentyRoad> getByMainId(String mainId);
}
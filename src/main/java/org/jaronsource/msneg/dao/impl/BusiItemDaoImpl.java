package org.jaronsource.msneg.dao.impl;

import org.jaronsource.msneg.domain.BusiItem;
import org.jaronsource.msneg.dao.BusiItemDao;
import com.ccesun.framework.core.dao.support.GenericDao;
import org.springframework.stereotype.Repository;

@Repository
public class BusiItemDaoImpl extends GenericDao<BusiItem, Integer> implements BusiItemDao {

}
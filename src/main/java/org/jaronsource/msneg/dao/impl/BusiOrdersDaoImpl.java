package org.jaronsource.msneg.dao.impl;

import org.jaronsource.msneg.domain.BusiOrders;
import org.jaronsource.msneg.dao.BusiOrdersDao;
import com.ccesun.framework.core.dao.support.GenericDao;
import org.springframework.stereotype.Repository;

@Repository
public class BusiOrdersDaoImpl extends GenericDao<BusiOrders, Integer> implements BusiOrdersDao {

}
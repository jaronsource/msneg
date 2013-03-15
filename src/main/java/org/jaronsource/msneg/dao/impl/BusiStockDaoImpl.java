package org.jaronsource.msneg.dao.impl;

import org.jaronsource.msneg.domain.BusiStock;
import org.jaronsource.msneg.dao.BusiStockDao;
import com.ccesun.framework.core.dao.support.GenericDao;
import org.springframework.stereotype.Repository;

@Repository
public class BusiStockDaoImpl extends GenericDao<BusiStock, Integer> implements BusiStockDao {

}
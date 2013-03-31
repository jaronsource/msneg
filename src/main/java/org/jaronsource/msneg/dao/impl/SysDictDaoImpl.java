package org.jaronsource.msneg.dao.impl;

import org.jaronsource.msneg.dao.SysDictDao;
import org.jaronsource.msneg.domain.SysDict;
import org.springframework.stereotype.Repository;

import com.ccesun.framework.core.dao.support.GenericDao;

@Repository
public class SysDictDaoImpl extends GenericDao<SysDict, Integer> implements SysDictDao {

}
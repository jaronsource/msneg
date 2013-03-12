package org.jaronsource.msneg.dao.impl;

import org.jaronsource.msneg.domain.SysUser;
import org.jaronsource.msneg.dao.SysUserDao;
import com.ccesun.framework.core.dao.support.GenericDao;
import org.springframework.stereotype.Repository;

@Repository
public class SysUserDaoImpl extends GenericDao<SysUser, Integer> implements SysUserDao {

}
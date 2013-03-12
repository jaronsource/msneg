package org.jaronsource.msneg.dao.impl;

import org.jaronsource.msneg.domain.Contact;
import org.jaronsource.msneg.dao.ContactDao;
import com.ccesun.framework.core.dao.support.GenericDao;
import org.springframework.stereotype.Repository;

@Repository
public class ContactDaoImpl extends GenericDao<Contact, Integer> implements ContactDao {

}
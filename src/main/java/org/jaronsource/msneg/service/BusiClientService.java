package org.jaronsource.msneg.service;

import java.util.List;

import org.jaronsource.msneg.domain.BusiClient;
import com.ccesun.framework.core.service.ISearchFormSupportService;

public interface BusiClientService extends ISearchFormSupportService<BusiClient, Integer> {

	List<BusiClient> findClientByTerm(String term);

}
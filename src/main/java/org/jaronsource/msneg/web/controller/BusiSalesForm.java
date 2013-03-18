package org.jaronsource.msneg.web.controller;

import org.jaronsource.msneg.domain.BusiClient;
import org.jaronsource.msneg.domain.BusiSales;

public class BusiSalesForm {
	
	private BusiClient busiClient;
	private BusiSales busiSales;
	
	public BusiClient getBusiClient() {
		return busiClient;
	}
	public void setBusiClient(BusiClient busiClient) {
		this.busiClient = busiClient;
	}
	public BusiSales getBusiSales() {
		return busiSales;
	}
	public void setBusiSales(BusiSales busiSales) {
		this.busiSales = busiSales;
	}
	
}

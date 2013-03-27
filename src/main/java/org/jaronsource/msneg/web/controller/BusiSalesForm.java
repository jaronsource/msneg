package org.jaronsource.msneg.web.controller;

import org.jaronsource.msneg.domain.BusiSales;

public class BusiSalesForm {
	
	private BusiSales busiSales;
	private String[] itemId;
	private String[] itemAmount;
	private String[] itemSum;
	private String[] itemRemarks;
	
	public BusiSales getBusiSales() {
		return busiSales;
	}
	public void setBusiSales(BusiSales busiSales) {
		this.busiSales = busiSales;
	}
	public String[] getItemId() {
		return itemId;
	}
	public void setItemId(String[] itemId) {
		this.itemId = itemId;
	}
	public String[] getItemAmount() {
		return itemAmount;
	}
	public void setItemAmount(String[] itemAmount) {
		this.itemAmount = itemAmount;
	}
	public String[] getItemSum() {
		return itemSum;
	}
	public void setItemSum(String[] itemSum) {
		this.itemSum = itemSum;
	}
	public String[] getItemRemarks() {
		return itemRemarks;
	}
	public void setItemRemarks(String[] itemRemarks) {
		this.itemRemarks = itemRemarks;
	}
}

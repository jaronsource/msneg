<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesItem" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['salesItemId_eq_int']" id="search_salesItemId" placeholder="销售商品ID"/>
	    	<form:input path="form['busiSales_eq']" id="search_busiSales" placeholder="销售单ID"/>
	    	<form:input path="form['busiItem_eq']" id="search_busiItem" placeholder="商品ID"/>
	    	<form:input path="form['itemAmount_eq']" id="search_itemAmount" placeholder="商品数量"/>
	    	<form:input path="form['itemSum_eq_int']" id="search_itemSum" placeholder="合计"/>
	    	<form:input path="form['itemRemarks_eq']" id="search_itemRemarks" placeholder="信息备注"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>销售商品ID</td>
		    	<td>销售单ID</td>
		    	<td>商品ID</td>
		    	<td>商品数量</td>
		    	<td>合计</td>
		    	<td>信息备注</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesItemPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.salesItemId}</td>
		    	<td>${entry.busiSales}</td>
		    	<td>${entry.busiItem}</td>
		    	<td>${entry.itemAmount}</td>
		    	<td>${entry.itemSum}</td>
		    	<td>${entry.itemRemarks}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.salesItemId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.salesItemId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.salesItemId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesItemPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiStock" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['stockId_eq_int']" id="search_stockId" placeholder="库存ID"/>
	    	<form:input path="form['busiItem_eq']" id="search_busiItem" placeholder="商品ID"/>
	    	<form:input path="form['stockAmount_eq_int']" id="search_stockAmount" placeholder="库存数量"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>库存ID</td>
		    	<td>商品ID</td>
		    	<td>库存数量</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiStockPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.stockId}</td>
		    	<td>${entry.busiItem}</td>
		    	<td>${entry.stockAmount}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.stockId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.stockId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.stockId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiStockPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
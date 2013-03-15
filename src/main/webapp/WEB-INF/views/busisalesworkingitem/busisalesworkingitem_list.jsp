<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesWorkingItem" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['workingItemId_eq_int']" id="search_workingItemId" placeholder="工时单商品ID"/>
	    	<form:input path="form['busiSalesWorking_eq']" id="search_busiSalesWorking" placeholder="工时单ID"/>
	    	<form:input path="form['busiItem_eq']" id="search_busiItem" placeholder="商品ID"/>
	    	<form:input path="form['returnVisitKey_eq']" id="search_returnVisitKey" placeholder="回访"/>
	    	<form:input path="form['itemRemarks_eq']" id="search_itemRemarks" placeholder="备注"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>工时单商品ID</td>
		    	<td>工时单ID</td>
		    	<td>商品ID</td>
		    	<td>回访</td>
		    	<td>备注</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesWorkingItemPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.workingItemId}</td>
		    	<td>${entry.busiSalesWorking}</td>
		    	<td>${entry.busiItem}</td>
		    	<td>${entry.returnVisitKey}</td>
		    	<td>${entry.itemRemarks}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.workingItemId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.workingItemId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.workingItemId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesWorkingItemPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
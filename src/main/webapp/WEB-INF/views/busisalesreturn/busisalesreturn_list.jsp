<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesReturn" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['returnId_eq_int']" id="search_returnId" placeholder="返销单ID"/>
	    	<form:input path="form['busiSales_eq']" id="search_busiSales" placeholder="销售单ID"/>
	    	<form:input path="form['sysUser_eq']" id="search_sysUser" placeholder="经手人"/>
	    	<form:input path="form['returnLoss_eq_int']" id="search_returnLoss" placeholder="返销破损"/>
	    	<form:input path="form['rerateLoss_eq_int']" id="search_rerateLoss" placeholder="折扣破损"/>
	    	<form:input path="form['returnRemarks_eq']" id="search_returnRemarks" placeholder="备注"/>
	    	<form:input path="form['clearMethodKey_eq']" id="search_clearMethodKey" placeholder="结算方式"/>
	    	<form:input path="form['otherRemarks_eq']" id="search_otherRemarks" placeholder="其他备注"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>返销单ID</td>
		    	<td>销售单ID</td>
		    	<td>经手人</td>
		    	<td>返销破损</td>
		    	<td>折扣破损</td>
		    	<td>备注</td>
		    	<td>结算方式</td>
		    	<td>其他备注</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesReturnPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.returnId}</td>
		    	<td>${entry.busiSales}</td>
		    	<td>${entry.sysUser}</td>
		    	<td>${entry.returnLoss}</td>
		    	<td>${entry.rerateLoss}</td>
		    	<td>${entry.returnRemarks}</td>
		    	<td>${entry.clearMethodKey}</td>
		    	<td>${entry.otherRemarks}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.returnId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.returnId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.returnId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesReturnPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
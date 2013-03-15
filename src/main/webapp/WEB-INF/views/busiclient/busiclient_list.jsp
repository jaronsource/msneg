<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiClient" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['clientId_eq_int']" id="search_clientId" placeholder="客户ID"/>
	    	<form:input path="form['clientName_eq']" id="search_clientName" placeholder="客户姓名"/>
	    	<form:input path="form['phone_eq']" id="search_phone" placeholder="电话"/>
	    	<form:input path="form['cellPhone_eq']" id="search_cellPhone" placeholder="手机"/>
	    	<form:input path="form['address_eq']" id="search_address" placeholder="地址"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>客户ID</td>
		    	<td>客户姓名</td>
		    	<td>电话</td>
		    	<td>手机</td>
		    	<td>地址</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiClientPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.clientId}</td>
		    	<td>${entry.clientName}</td>
		    	<td>${entry.phone}</td>
		    	<td>${entry.cellPhone}</td>
		    	<td>${entry.address}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.clientId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.clientId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.clientId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiClientPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
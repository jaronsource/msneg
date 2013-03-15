<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesBrokerage" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['brokId_eq_int']" id="search_brokId" placeholder="提成单ID"/>
	    	<form:input path="form['brokSum_eq_int']" id="search_brokSum" placeholder="提成总额"/>
	    	<form:input path="form['clearMethodKey_eq']" id="search_clearMethodKey" placeholder="结算方式"/>
	    	<form:input path="form['brokPersonName_eq']" id="search_brokPersonName" placeholder="提成人"/>
	    	<form:input path="form['sysUser_eq']" id="search_sysUser" placeholder="经手人"/>
	    	<form:input path="form['createTime_eq']" id="search_createTime" placeholder="创建时间"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>提成单ID</td>
		    	<td>提成总额</td>
		    	<td>结算方式</td>
		    	<td>提成人</td>
		    	<td>经手人</td>
		    	<td>创建时间</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesBrokeragePage.content}" var="entry">
	    	<tr>
		    	<td>${entry.brokId}</td>
		    	<td>${entry.brokSum}</td>
		    	<td>${entry.clearMethodKey}</td>
		    	<td>${entry.brokPersonName}</td>
		    	<td>${entry.sysUser}</td>
		    	<td>${entry.createTime}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.brokId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.brokId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.brokId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesBrokeragePage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
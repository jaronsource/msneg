<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/sysDept" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['deptId_eq_int']" id="search_deptId" placeholder="主键"/>
	    	<form:input path="form['deptName_eq']" id="search_deptName" placeholder="名称"/>
	    	<form:input path="form['deptRemarks_eq']" id="search_deptRemarks" placeholder="描述"/>
	    	<form:input path="form['deptTypeKey_eq']" id="search_deptTypeKey" placeholder="部门类型"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>主键</td>
		    	<td>名称</td>
		    	<td>描述</td>
		    	<td>部门类型</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${sysDeptPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.deptId}</td>
		    	<td>${entry.deptName}</td>
		    	<td>${entry.deptRemarks}</td>
		    	<td>${entry.deptTypeKey}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.deptId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.deptId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.deptId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${sysDeptPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
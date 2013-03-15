<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/sysFunc" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['funcId_eq_int']" id="search_funcId" placeholder="主键"/>
	    	<form:input path="form['funcName_eq']" id="search_funcName" placeholder="名称"/>
	    	<form:input path="form['funcUrl_eq']" id="search_funcUrl" placeholder="地址"/>
	    	<form:input path="form['funcRemarks_eq']" id="search_funcRemarks" placeholder="描述"/>
	    	<form:input path="form['sysFunc_eq']" id="search_sysFunc" placeholder="父功能"/>
	    	<form:input path="form['funcGroupcode_eq']" id="search_funcGroupcode" placeholder="功能组"/>
	    	<form:input path="form['funcOrder_eq_int']" id="search_funcOrder" placeholder="序号"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>主键</td>
		    	<td>名称</td>
		    	<td>地址</td>
		    	<td>描述</td>
		    	<td>父功能</td>
		    	<td>功能组</td>
		    	<td>序号</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${sysFuncPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.funcId}</td>
		    	<td>${entry.funcName}</td>
		    	<td>${entry.funcUrl}</td>
		    	<td>${entry.funcRemarks}</td>
		    	<td>${entry.sysFunc}</td>
		    	<td>${entry.funcGroupcode}</td>
		    	<td>${entry.funcOrder}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.funcId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.funcId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.funcId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${sysFuncPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
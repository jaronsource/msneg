<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesClear" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['clearId_eq_int']" id="search_clearId" placeholder="结算单ID"/>
	    	<form:input path="form['feeClear_eq_int']" id="search_feeClear" placeholder="结算金额"/>
	    	<form:input path="form['feeClearCash_eq_int']" id="search_feeClearCash" placeholder="结算金额现金"/>
	    	<form:input path="form['feeClearCard_eq_int']" id="search_feeClearCard" placeholder="结算金额刷卡"/>
	    	<form:input path="form['feeRemain_eq_int']" id="search_feeRemain" placeholder="剩余尾款"/>
	    	<form:input path="form['busiSales_eq']" id="search_busiSales" placeholder="销售单ID"/>
	    	<form:input path="form['sysUser_eq']" id="search_sysUser" placeholder="经手人"/>
	    	<form:input path="form['createTime_eq']" id="search_createTime" placeholder="创建时间"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>结算单ID</td>
		    	<td>结算金额</td>
		    	<td>结算金额现金</td>
		    	<td>结算金额刷卡</td>
		    	<td>剩余尾款</td>
		    	<td>销售单ID</td>
		    	<td>经手人</td>
		    	<td>创建时间</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesClearPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.clearId}</td>
		    	<td>${entry.feeClear}</td>
		    	<td>${entry.feeClearCash}</td>
		    	<td>${entry.feeClearCard}</td>
		    	<td>${entry.feeRemain}</td>
		    	<td>${entry.busiSales}</td>
		    	<td>${entry.sysUser}</td>
		    	<td>${entry.createTime}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.clearId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.clearId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.clearId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesClearPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
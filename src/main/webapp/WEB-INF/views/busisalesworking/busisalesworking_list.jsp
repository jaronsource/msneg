<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesWorking" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['workingId_eq_int']" id="search_workingId" placeholder="工时单ID"/>
	    	<form:input path="form['otherItemName_eq']" id="search_otherItemName" placeholder="其他项目名称"/>
	    	<form:input path="form['otherItemPrice_eq_int']" id="search_otherItemPrice" placeholder="其他项目单价"/>
	    	<form:input path="form['otherItemAmount_eq_int']" id="search_otherItemAmount" placeholder="其他项目数量"/>
	    	<form:input path="form['otherItemSum_eq_int']" id="search_otherItemSum" placeholder="其他项目合计"/>
	    	<form:input path="form['otherItemRemarks_eq']" id="search_otherItemRemarks" placeholder="项目备注"/>
	    	<form:input path="form['feeSum_eq_int']" id="search_feeSum" placeholder="工时总额"/>
	    	<form:input path="form['clearMethodKey_eq']" id="search_clearMethodKey" placeholder="结算形式"/>
	    	<form:input path="form['sysDept_eq']" id="search_sysDept" placeholder="安装部门"/>
	    	<form:input path="form['otherRemarks_eq']" id="search_otherRemarks" placeholder=""/>
	    	<form:input path="form['createTime_eq']" id="search_createTime" placeholder="创建时间"/>
	    	<form:input path="form['sysUser_eq']" id="search_sysUser" placeholder="经手人"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>工时单ID</td>
		    	<td>其他项目名称</td>
		    	<td>其他项目单价</td>
		    	<td>其他项目数量</td>
		    	<td>其他项目合计</td>
		    	<td>项目备注</td>
		    	<td>工时总额</td>
		    	<td>结算形式</td>
		    	<td>安装部门</td>
		    	<td></td>
		    	<td>创建时间</td>
		    	<td>经手人</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesWorkingPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.workingId}</td>
		    	<td>${entry.otherItemName}</td>
		    	<td>${entry.otherItemPrice}</td>
		    	<td>${entry.otherItemAmount}</td>
		    	<td>${entry.otherItemSum}</td>
		    	<td>${entry.otherItemRemarks}</td>
		    	<td>${entry.feeSum}</td>
		    	<td>${entry.clearMethodKey}</td>
		    	<td>${entry.sysDept}</td>
		    	<td>${entry.otherRemarks}</td>
		    	<td>${entry.createTime}</td>
		    	<td>${entry.sysUser}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.workingId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.workingId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.workingId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesWorkingPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
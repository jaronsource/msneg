<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesReturnItem" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['returnItemId_eq_int']" id="search_returnItemId" placeholder="返销商品ID"/>
	    	<form:input path="form['busiSalesReturn_eq']" id="search_busiSalesReturn" placeholder="返销单ID"/>
	    	<form:input path="form['busiItem_eq']" id="search_busiItem" placeholder="商品ID"/>
	    	<form:input path="form['returnPrice_eq_int']" id="search_returnPrice" placeholder="返销单价"/>
	    	<form:input path="form['returnAmount_eq_int']" id="search_returnAmount" placeholder="返销数量"/>
	    	<form:input path="form['returnSum_eq_int']" id="search_returnSum" placeholder="返销合计"/>
	    	<form:input path="form['returnReasonKey_eq']" id="search_returnReasonKey" placeholder="返销事由"/>
	    	<form:input path="form['returnRemarks_eq']" id="search_returnRemarks" placeholder="备注"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>返销商品ID</td>
		    	<td>返销单ID</td>
		    	<td>商品ID</td>
		    	<td>返销单价</td>
		    	<td>返销数量</td>
		    	<td>返销合计</td>
		    	<td>返销事由</td>
		    	<td>备注</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesReturnItemPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.returnItemId}</td>
		    	<td>${entry.busiSalesReturn}</td>
		    	<td>${entry.busiItem}</td>
		    	<td>${entry.returnPrice}</td>
		    	<td>${entry.returnAmount}</td>
		    	<td>${entry.returnSum}</td>
		    	<td>${entry.returnReasonKey}</td>
		    	<td>${entry.returnRemarks}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.returnItemId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.returnItemId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.returnItemId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesReturnItemPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
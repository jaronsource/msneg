<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiOrders" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['ordersId_eq_int']" id="search_ordersId" placeholder="主键"/>
	    	<form:input path="form['busiClient_eq']" id="search_busiClient" placeholder="客户ID"/>
	    	<form:input path="form['ordersTypeKeys_eq']" id="search_ordersTypeKeys" placeholder="定金类型"/>
	    	<form:input path="form['ordersRemarks_eq']" id="search_ordersRemarks" placeholder="备注"/>
	    	<form:input path="form['ordersUseKey_eq']" id="search_ordersUseKey" placeholder="定金用途"/>
	    	<form:input path="form['ordersReturnKey_eq']" id="search_ordersReturnKey" placeholder="定金返还"/>
	    	<form:input path="form['ordersSum_eq_int']" id="search_ordersSum" placeholder="总金额"/>
	    	<form:input path="form['ordersCash_eq_int']" id="search_ordersCash" placeholder="现金"/>
	    	<form:input path="form['ordersCard_eq_int']" id="search_ordersCard" placeholder="刷卡"/>
	    	<form:input path="form['otherRemarks_eq']" id="search_otherRemarks" placeholder="其他信息部分"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>主键</td>
		    	<td>客户ID</td>
		    	<td>定金类型</td>
		    	<td>备注</td>
		    	<td>定金用途</td>
		    	<td>定金返还</td>
		    	<td>总金额</td>
		    	<td>现金</td>
		    	<td>刷卡</td>
		    	<td>其他信息部分</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiOrdersPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.ordersId}</td>
		    	<td>${entry.busiClient}</td>
		    	<td>${entry.ordersTypeKeys}</td>
		    	<td>${entry.ordersRemarks}</td>
		    	<td>${entry.ordersUseKey}</td>
		    	<td>${entry.ordersReturnKey}</td>
		    	<td>${entry.ordersSum}</td>
		    	<td>${entry.ordersCash}</td>
		    	<td>${entry.ordersCard}</td>
		    	<td>${entry.otherRemarks}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.ordersId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.ordersId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.ordersId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiOrdersPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
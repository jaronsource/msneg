<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesBrokerageItem" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['brokItemId_eq_int']" id="search_brokItemId" placeholder="提成商品ID"/>
	    	<form:input path="form['busiSalesBrokerage_eq']" id="search_busiSalesBrokerage" placeholder="提成单ID"/>
	    	<form:input path="form['busiItem_eq']" id="search_busiItem" placeholder="商品ID"/>
	    	<form:input path="form['brokReturn_eq_int']" id="search_brokReturn" placeholder="返销"/>
	    	<form:input path="form['brokInstall_eq_int']" id="search_brokInstall" placeholder="安装"/>
	    	<form:input path="form['brokMakeup_eq_int']" id="search_brokMakeup" placeholder="辅差"/>
	    	<form:input path="form['brokRatio_eq_int']" id="search_brokRatio" placeholder="比率"/>
	    	<form:input path="form['brokMerePrice_eq_int']" id="search_brokMerePrice" placeholder="净价"/>
	    	<form:input path="form['brokMereAmount_eq_int']" id="search_brokMereAmount" placeholder="净量"/>
	    	<form:input path="form['brokSum_eq_int']" id="search_brokSum" placeholder="提成合计"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>提成商品ID</td>
		    	<td>提成单ID</td>
		    	<td>商品ID</td>
		    	<td>返销</td>
		    	<td>安装</td>
		    	<td>辅差</td>
		    	<td>比率</td>
		    	<td>净价</td>
		    	<td>净量</td>
		    	<td>提成合计</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesBrokerageItemPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.brokItemId}</td>
		    	<td>${entry.busiSalesBrokerage}</td>
		    	<td>${entry.busiItem}</td>
		    	<td>${entry.brokReturn}</td>
		    	<td>${entry.brokInstall}</td>
		    	<td>${entry.brokMakeup}</td>
		    	<td>${entry.brokRatio}</td>
		    	<td>${entry.brokMerePrice}</td>
		    	<td>${entry.brokMereAmount}</td>
		    	<td>${entry.brokSum}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.brokItemId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.brokItemId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.brokItemId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesBrokerageItemPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
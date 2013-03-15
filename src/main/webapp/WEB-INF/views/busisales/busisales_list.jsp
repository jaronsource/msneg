<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSales" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['salesId_eq_int']" id="search_salesId" placeholder="销售单ID"/>
	    	<form:input path="form['salesCode_eq']" id="search_salesCode" placeholder="编码"/>
	    	<form:input path="form['sysDept_eq']" id="search_sysDept" placeholder="销售部门"/>
	    	<form:input path="form['sysUser_eq']" id="search_sysUser" placeholder="经手人"/>
	    	<form:input path="form['createTime_eq']" id="search_createTime" placeholder="创建时间"/>
	    	<form:input path="form['salesRemarks_eq']" id="search_salesRemarks" placeholder="备注"/>
	    	<form:input path="form['salesTypeKey_eq']" id="search_salesTypeKey" placeholder="销售单类型"/>
	    	<form:input path="form['busiClient_eq']" id="search_busiClient" placeholder="客户ID"/>
	    	<form:input path="form['salesStateKey_eq']" id="search_salesStateKey" placeholder="状态"/>
	    	<form:input path="form['servLogisKey_eq']" id="search_servLogisKey" placeholder="物流信息"/>
	    	<form:input path="form['servGetmethodKey_eq']" id="search_servGetmethodKey" placeholder="取货方式"/>
	    	<form:input path="form['servInstallmethodKey_eq']" id="search_servInstallmethodKey" placeholder="安装方式"/>
	    	<form:input path="form['feeSum_eq_int']" id="search_feeSum" placeholder="总金额"/>
	    	<form:input path="form['feePrepay_eq_int']" id="search_feePrepay" placeholder="预付金额"/>
	    	<form:input path="form['feePrepayCash_eq_int']" id="search_feePrepayCash" placeholder="预付金现金"/>
	    	<form:input path="form['feePrepayCard_eq_int']" id="search_feePrepayCard" placeholder="预付金刷卡"/>
	    	<form:input path="form['feeRemain_eq_int']" id="search_feeRemain" placeholder="剩余尾款"/>
	    	<form:input path="form['otherRemarks_eq']" id="search_otherRemarks" placeholder="其他备注"/>
	    	<form:input path="form['salesContract_eq']" id="search_salesContract" placeholder="合同条款"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>销售单ID</td>
		    	<td>编码</td>
		    	<td>销售部门</td>
		    	<td>经手人</td>
		    	<td>创建时间</td>
		    	<td>备注</td>
		    	<td>销售单类型</td>
		    	<td>客户ID</td>
		    	<td>状态</td>
		    	<td>物流信息</td>
		    	<td>取货方式</td>
		    	<td>安装方式</td>
		    	<td>总金额</td>
		    	<td>预付金额</td>
		    	<td>预付金现金</td>
		    	<td>预付金刷卡</td>
		    	<td>剩余尾款</td>
		    	<td>其他备注</td>
		    	<td>合同条款</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.salesId}</td>
		    	<td>${entry.salesCode}</td>
		    	<td>${entry.sysDept}</td>
		    	<td>${entry.sysUser}</td>
		    	<td>${entry.createTime}</td>
		    	<td>${entry.salesRemarks}</td>
		    	<td>${entry.salesTypeKey}</td>
		    	<td>${entry.busiClient}</td>
		    	<td>${entry.salesStateKey}</td>
		    	<td>${entry.servLogisKey}</td>
		    	<td>${entry.servGetmethodKey}</td>
		    	<td>${entry.servInstallmethodKey}</td>
		    	<td>${entry.feeSum}</td>
		    	<td>${entry.feePrepay}</td>
		    	<td>${entry.feePrepayCash}</td>
		    	<td>${entry.feePrepayCard}</td>
		    	<td>${entry.feeRemain}</td>
		    	<td>${entry.otherRemarks}</td>
		    	<td>${entry.salesContract}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.salesId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.salesId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.salesId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiSalesMakeup" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['makeupId_eq_int']" id="search_makeupId" placeholder="补价单ID"/>
	    	<form:input path="form['makeupSum_eq_int']" id="search_makeupSum" placeholder="补价总额"/>
	    	<form:input path="form['sysUser_eq']" id="search_sysUser" placeholder="经手人"/>
	    	<form:input path="form['addItem1_eq_int']" id="search_addItem1" placeholder="新增临时性损耗费用"/>
	    	<form:input path="form['addItem2_eq_int']" id="search_addItem2" placeholder="增值服务取费"/>
	    	<form:input path="form['addItem3_eq_int']" id="search_addItem3" placeholder="上衣托管安装（含多施工费用）"/>
	    	<form:input path="form['addItem4_eq_int']" id="search_addItem4" placeholder="变更议价补价"/>
	    	<form:input path="form['addItem5_eq_int']" id="search_addItem5" placeholder="新增运输及商品管理费用"/>
	    	<form:input path="form['addItem6_eq_int']" id="search_addItem6" placeholder="其他商议费用"/>
	    	<form:input path="form['minusItem1_eq_int']" id="search_minusItem1" placeholder="递减临时性损耗费用"/>
	    	<form:input path="form['minusItem2_eq_int']" id="search_minusItem2" placeholder="补退议价差额"/>
	    	<form:input path="form['minusItem3_eq_int']" id="search_minusItem3" placeholder="递减托管安装（含少施工费用）"/>
	    	<form:input path="form['minusItem4_eq_int']" id="search_minusItem4" placeholder="遇零取整差价"/>
	    	<form:input path="form['minusItem5_eq_int']" id="search_minusItem5" placeholder="商品瑕疵/破损议价差额"/>
	    	<form:input path="form['minusItem6_eq_int']" id="search_minusItem6" placeholder=" 其他商议费用"/>
	    	<form:input path="form['makeupRemarks_eq']" id="search_makeupRemarks" placeholder="补价信息备注"/>
	    	<form:input path="form['otherRemarks_eq']" id="search_otherRemarks" placeholder="其他备注"/>
	    	<form:input path="form['createTime_eq']" id="search_createTime" placeholder="创建时间"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>补价单ID</td>
		    	<td>补价总额</td>
		    	<td>经手人</td>
		    	<td>新增临时性损耗费用</td>
		    	<td>增值服务取费</td>
		    	<td>上衣托管安装（含多施工费用）</td>
		    	<td>变更议价补价</td>
		    	<td>新增运输及商品管理费用</td>
		    	<td>其他商议费用</td>
		    	<td>递减临时性损耗费用</td>
		    	<td>补退议价差额</td>
		    	<td>递减托管安装（含少施工费用）</td>
		    	<td>遇零取整差价</td>
		    	<td>商品瑕疵/破损议价差额</td>
		    	<td> 其他商议费用</td>
		    	<td>补价信息备注</td>
		    	<td>其他备注</td>
		    	<td>创建时间</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiSalesMakeupPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.makeupId}</td>
		    	<td>${entry.makeupSum}</td>
		    	<td>${entry.sysUser}</td>
		    	<td>${entry.addItem1}</td>
		    	<td>${entry.addItem2}</td>
		    	<td>${entry.addItem3}</td>
		    	<td>${entry.addItem4}</td>
		    	<td>${entry.addItem5}</td>
		    	<td>${entry.addItem6}</td>
		    	<td>${entry.minusItem1}</td>
		    	<td>${entry.minusItem2}</td>
		    	<td>${entry.minusItem3}</td>
		    	<td>${entry.minusItem4}</td>
		    	<td>${entry.minusItem5}</td>
		    	<td>${entry.minusItem6}</td>
		    	<td>${entry.makeupRemarks}</td>
		    	<td>${entry.otherRemarks}</td>
		    	<td>${entry.createTime}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.makeupId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.makeupId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.makeupId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiSalesMakeupPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
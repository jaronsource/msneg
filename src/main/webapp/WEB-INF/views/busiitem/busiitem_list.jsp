<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="row">
    <spring:url value="/busiItem" var="baseUrl"/>  
    
    <div class="span10"> 
    	<h3>列表</h3>
	    <form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	    	<form:input path="form['itemId_eq_int']" id="search_itemId" placeholder="商品ID"/>
	    	<form:input path="form['itemCode_eq']" id="search_itemCode" placeholder="货号"/>
	    	<form:input path="form['itemName_eq']" id="search_itemName" placeholder="名称"/>
	    	<form:input path="form['itemFormat_eq']" id="search_itemFormat" placeholder="型号"/>
	    	<form:input path="form['itemUnit_eq']" id="search_itemUnit" placeholder="单位"/>
	    	<form:input path="form['itemPrice_eq_int']" id="search_itemPrice" placeholder="单价"/>
	    	<form:input path="form['itemCnspell_eq']" id="search_itemCnspell" placeholder="助记符"/>
	    	<form:input path="form['itemTypeKey_eq']" id="search_itemTypeKey" placeholder="类别"/>
	    	<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	    </form:form>
    
	    <table class="table table-bordered table-hover"> 
	    	<tr>
		    	<td>商品ID</td>
		    	<td>货号</td>
		    	<td>名称</td>
		    	<td>型号</td>
		    	<td>单位</td>
		    	<td>单价</td>
		    	<td>助记符</td>
		    	<td>类别</td>
		    	<td>操作</td>
	    	</tr>
	    	<c:forEach items="${busiItemPage.content}" var="entry">
	    	<tr>
		    	<td>${entry.itemId}</td>
		    	<td>${entry.itemCode}</td>
		    	<td>${entry.itemName}</td>
		    	<td>${entry.itemFormat}</td>
		    	<td>${entry.itemUnit}</td>
		    	<td>${entry.itemPrice}</td>
		    	<td>${entry.itemCnspell}</td>
		    	<td>${entry.itemTypeKey}</td>
		    	<td>
		    		<a href="${baseUrl}/${entry.itemId}/show" class="btn btn-small"><i class="icon-eye-open"></i></a> 
		    		<a href="${baseUrl}/${entry.itemId}/update" class="btn btn-small"><i class="icon-edit"></i></a> 
		    		<a href="${baseUrl}/${entry.itemId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')"><i class="icon-remove-sign"></i></a> 
		    	</td>
	    	</tr>	
	    	</c:forEach>
	    </table> 
    	
    	<pg:pager url="${baseUrl}" page="${busiItemPage}" />
    	<%@ include file="/WEB-INF/pagers/pager-default.jsp" %>
    	<a href="${baseUrl}/create" class="btn"><i class="icon-file"></i> 新建</a>
    </div>

</div>
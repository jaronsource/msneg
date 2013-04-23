<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="title_box">
	<h2>客户信息管理</h2>
</div>
<div class="customer">
<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	<p>客户姓名：
		<form:input path="form['clientName_blk']" id="search_clientName" cssClass="input_text w_172" placeholder="客户姓名"/>
		客户电话号码：
		<form:input path="form['cellPhone_blk']" id="search_cellPhone" cssClass="input_text w_172" placeholder="客户电话号码"/>
		<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	</p>
</form:form>
</div>
<div class="order_box"> 
	<!--box-->
<div class="com_box">
	<h3 class="title_line">客户信息列表<a href="#this" class="toggle_table">折叠</a></h3>
	<table width="100%" border="1" class="tbl_l" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="120" />
			<col width="60" />
			<col width="120" />
			<col width="*" />
			<%-- <col width="120" /> --%>
		</colgroup>
		<thead>
			<tr>
				<th>客户姓名</th>
				<th>区号</th>
				<th>电话</th>
				<th>手机</th>
				<th>地址</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${busiClientPage.content}" var="entry">
			<tr>
				<td>${entry.clientName }</td>
				<td>${entry.areacode }</td>
				<td>${entry.phone }</td>
				<td>${entry.cellPhone }</td>
				<td>${entry.address }</td>
				<td>
					<a href="${pageContext.request.contextPath }/busiClient/${entry.clientId}/update" class="btn btn-small">修改</a> 
		    		<a href="${pageContext.request.contextPath }/busiClient/${entry.clientId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')">删除</a> 
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="paging"> 
		<pg:pager url="${baseUrl}" page="${busiClientPage}" />
	    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
	    <div class="sys_btnBox">
			<input type="button" value="创建新客户" onclick="window.location='busiClient/create'">
		</div>
	</div>	
</div>
</div>
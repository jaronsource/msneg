<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<div class="title_box">
	<h2>报备信息管理</h2>
</div>
<div class="customer">
<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
	<p>客户姓名：
		<form:input path="form['clientName_blk']" id="search_clientName" cssClass="input_text w_172" placeholder="客户姓名"/>
		客户电话号码：
		<form:input path="form['clientCellphone_blk']" id="search_clientCellphone" cssClass="input_text w_172" placeholder="客户电话号码"/>
		报备人姓名：
		<form:input path="form['preordPerson_blk']" id="search_preordPerson" cssClass="input_text w_172" placeholder="报备人姓名"/>
		<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
	</p>
</form:form>
</div>
<div class="order_box"> 
	<!--box-->
<div class="com_box">
	<h3 class="title_line">报备信息列表<a href="#this" class="toggle_table">折叠</a></h3>
	<table width="100%" border="1" class="tbl_l" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="120" />
			<col width="120" />
			<col width="*" />
			<col width="120" />
			<col width="120" />
			<col width="120" />
		</colgroup>
		<thead>
			<tr>
				<th>客户姓名</th>
				<th>客户电话</th>
				<th>客户地址</th>
				<th>报备人姓名</th>
				<th>报备人电话</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${busiPreordPage.content}" var="entry">
			<tr>
				<td>${entry.clientName }</td>
				<td>${entry.clientCellphone }</td>
				<td>${entry.clientAddress }</td>
				<td>${entry.preordPerson }</td>
				<td>${entry.preordPersonPhone }</td>
				<td>
					<a href="${pageContext.request.contextPath }/busiPreord/${entry.preordId}/update" class="btn btn-small">修改</a> 
		    		<a href="${pageContext.request.contextPath }/busiPreord/${entry.preordId}/remove" class="btn btn-small" onclick="return confirm('确定要删除吗？')">删除</a> 
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="paging"> 
		<pg:pager url="${baseUrl}" page="${busiPreordPage}" />
	    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
	    <div class="sys_btnBox">
			<input type="button" value="创建新报备" onclick="window.location='busiPreord/create'">
		</div>
	</div>	
</div>
</div>
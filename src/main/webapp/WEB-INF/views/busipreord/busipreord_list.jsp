<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
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
	<h3 class="title_line">报备信息列表<a class="toggle_table" href="#this">折叠</a></h3>
	<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_l">
		<colgroup>
		<col width="74">
		<col width="90">
		<col width="70">
		<col width="200">
		<col width="90">
		<col width="*">
		<col width="40">
		<col width="40">
		<col width="100">
		<col width="70">
		<col width="100">
		</colgroup>
		<thead>
			<tr>
				<th colspan="2">报 备 人 信 息</th>
				<th colspan="8">报  备  信  息</th>
				<th rowspan="2">操作</th>
			</tr>
			<tr>
				<th>姓名/公司</th>
				<th>联系方式</th>
				
				<th>姓名</th>
				<th>物业地址</th>
				<th>联系方式</th>
				<th>描述</th>
				<th>登记</th>
				<th>核实</th>
				<th>报备时间</th>
				<th>状态</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${busiPreordPage.content}" var="entry">
			<tr>
				<td>${entry.preordPerson }</td>
				<td>${entry.preordPersonPhone }</td>
				<td>${entry.clientName }</td>
				<td>${entry.clientAddress }</td>
				<td>${entry.clientCellphone }</td>
				<td>${entry.remarks }</td>
				<td>${entry.inputUser }</td>
				<td>${entry.checkUser }</td>
				<td>${fn:substring(entry.createTime, 0, 8) }</td>
				<td><dict:lookupDictValue key="${entry.preordStateKey }" type="preord_state"></dict:lookupDictValue></td>
				<td><a class="btn btn-small" href="${pageContext.request.contextPath }/busiPreord/1/update">修改</a> <a onclick="return confirm('确定要删除吗？')" class="btn btn-small" href="${pageContext.request.contextPath }/busiPreord/1/remove" onclick="return confirm('确定要删除吗？')">删除</a></td>
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
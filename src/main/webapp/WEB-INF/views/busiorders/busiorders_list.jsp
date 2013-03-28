<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>

<dict:loadDictList type="orders_state" var="orders_state" />
<div class="title_box">
		<h2>定金单管理</h2>
	</div>
	<div class="customer">
	<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
		<p>手工输入定金单号
			<input type="text" name="" class="input_text w_172" value="" id="" />
			<form:input path="form['ordersCode_blk']" id="search_ordersCode" cssClass="input_text w_172" placeholder="定金单号"/>
			快速查找客户：
			<form:input path="form['client.cellPhone_blk']" id="search_clientCellPhone" cssClass="input_text w_172" placeholder="客户电话号码"/>
			<form:hidden path="form['ordersStateKey_eq']" id="search_ordersStateKey" />
			<form:hidden path="form['sysDept.deptId_eq_int']" id="search_deptId" />
			<form:hidden path="form['createTime_let']" id="search_createTime" />
			<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
		</p>
	</form:form>
	</div>
	<div class="customer">
	<h4><a href="javascript: void(0)" id="toggleFilter">定金单筛选</a></h4>
	<dl>
		<dt>类型筛选：</dt>
		<dd><a href="javascript: void(0)" class="ordersStateKey" value="">全部</a>
		<c:forEach items="${orders_state}" var="entry" varStatus="status">
			<a href="javascript: void(0)" class="ordersStateKey" value="${entry.dictKey}">${entry.dictValue0}</a>
		</c:forEach>
		</dd> 
	</dl>
	<dl>
		<dt>部门筛选：</dt>
		<dd><a href="javascript: void(0)" >全部部门</a> <a href="javascript: void(0)">销售一部</a> <a href="javascript: void(0)">销售二部</a> <a href="javascript: void(0)">销售三部</a></dd>
	</dl>
	<dl>
		<dt>时间筛选：</dt>
		<dd><a href="javascript: void(0)">所有历史时间</a> <a href="javascript: void(0)" >最近一周</a> <a href="javascript: void(0)">最近一个月</a> <a href="javascript: void(0)">最近三个月</a> </dd>
	</dl>
	<script>
		$('#toggleFilter').toggle(function() {
				$('dl').show();
			}, function() {
				$('dl').hide();
			});
	</script>
</div>
<div class="order_box"> 
	<!--box-->
<div class="com_box">
	<h3 class="title_line">订单信息列表<a href="#this" class="toggle_table">折叠</a></h3>
	<table width="100%" border="1" class="tbl_l" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="100" />
			<col width="100" />
			<col width="40%" />
			<col width="80" />
			<col width="150" />
			<col width="100" />
			<col width="*" />
		</colgroup>
		<thead>
			<tr>
				<th>日期/时间</th>
				<th>订单号</th>
				<th>单据简明</th>
				<th>单据状态</th>
				<th>部门</th>
				<th>经手人</th>
				<th>快速操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${busiOrdersPage.content}" var="entry">
			<tr>
				<td>${entry.createTime }</td>
				<td><a href="#this">${entry.ordersCode }</a></td>
				<td class="tl">${entry.ordersRemark }</td>
				<td><dict:lookupDictValue key="${entry.orderStateKey }" type="orders_state" /></td>
				<td class="tl">${entry.sysDept.deptName }</td>
				<td class="tl">${entry.sysUser.realName }</td>
				<td><input type="button" value="使用" onclick="window.location='useOrders';" /><input type="button" value="退回" onclick="window.location='returnOrders'" /></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<pg:pager url="${baseUrl}" page="${busiSalesPage}" />
    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>			
</div>
</div>
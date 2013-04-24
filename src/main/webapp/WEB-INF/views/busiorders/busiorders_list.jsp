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
		<p>定金单号：
			<form:input path="form['ordersCode_blk']" id="search_ordersCode" cssClass="input_text w_172" placeholder="定金单号"/>
			客户电话号码：
			<form:input path="form['busiClient.cellPhone_blk']" id="search_busiClientCellPhone" cssClass="input_text w_172" placeholder="客户电话号码"/>
			<form:hidden path="form['ordersStateKey_eq']" id="search_ordersStateKey" />
			<form:hidden path="form['sysDept.deptId_eq_int']" id="search_deptId" />
			<form:hidden path="form['createTime_elt']" id="search_createTime" />
			<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
		</p>
	</form:form>
	</div>
	<div class="customer">
	<h4>定金单筛选<a href="#this" class="toggle_table">折叠</a></h4> 
	<dl>
		<dt>类型筛选：</dt>
		<dd><a href="javascript: void(0)" class="ordersStateKey filter" value="">全部</a>
		<c:forEach items="${orders_state}" var="entry" varStatus="status">
			<a href="javascript: void(0)" class="ordersStateKey filter" value="${entry.dictKey}">${entry.dictValue0}</a>
		</c:forEach>
		</dd> 
	</dl>
	<dl>
		<dt>部门筛选：</dt>
		<dd><a href="javascript: void(0)" class="deptId filter" value="" >全部部门</a> 
		<c:forEach items="${depts}" var="entry" varStatus="status">
			<a href="javascript: void(0)" class="deptId filter" value="${entry.deptId}">${entry.deptName}</a>
		</c:forEach>
		</dd>
	</dl>
	<dl>
		<dt>时间筛选：</dt>
		<dd><a href="javascript: void(0)" class="createTime filter" value="">所有历史时间</a> <a href="javascript: void(0)" class="createTime filter" value="${weekTime }" >最近一周</a> <a href="javascript: void(0)" class="createTime filter" value="${monthTime }">最近一个月</a> <a href="javascript: void(0)" class="createTime filter" value="${threeMonthTime}">最近三个月</a> </dd>
	</dl>
	<script>
		$('.ordersStateKey').each(function() {
			var value = $('#search_ordersStateKey').val();
			if (value == $(this).attr('value'))
				$(this).addClass('curr');
		});
		
		$('.deptId').each(function() {
			var value = $('#search_deptId').val();
			if (value == $(this).attr('value'))
				$(this).addClass('curr');
		});
		
		$('.createTime').each(function() {
			var value = $('#search_createTime').val();
			if (value == $(this).attr('value'))
				$(this).addClass('curr');
		});
		
		$('.filter').click(function() {
			$(this).siblings().removeClass('curr');
			$(this).addClass('curr');
		});
		
		$('.ordersStateKey').click(function() {
			$('#search_ordersStateKey').val($(this).attr('value'));
		});
		
		$('.deptId').click(function() {
			$('#search_deptId').val($(this).attr('value'));
		});
		
		$('.createTime').click(function() {
			$('#search_createTime').val($(this).attr('value'));
		});
	</script>
</div>
<div class="order_box"> 
	<!--box-->
<div class="com_box">
	<h3 class="title_line">订单信息列表<a href="#this" class="toggle_table">折叠</a></h3>
	<table width="100%" border="1" class="tbl_l" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="200" />
			<col width="100" />
			<col width="*" />
			<col width="80" />
			<col width="150" />
			<col width="100" />
			<col width="120" />
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
				<td class="tl nowrap">${entry.busiClient.clientName } | ${entry.busiClient.cellPhone } | ${entry.busiClient.address }</td>
				<td><dict:lookupDictValue key="${entry.ordersStateKey }" type="orders_state" /></td>
				<td class="tl">${entry.sysDept.deptName }</td>
				<td class="tl">${entry.sysUser.realName }</td>
				<td> 
					<c:choose>
						<c:when test="${entry.ordersStateKey == 'A'}">
							<input type="button" value="使用" onclick="useOrders('${entry.ordersId }')" />
							<input type="button" value="退回" onclick="returnOrders('${entry.ordersId }')" />
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	<script>
		function useOrders(ordersId) {
			if (confirm('确定使用此定单吗？')) {
				window.location='busiOrders/useOrders?ordersId=' + ordersId;
			} 
		}

		function returnOrders(ordersId) {
			if (confirm('确定退回此定单吗？')) {
				window.location='busiOrders/returnOrders?ordersId=' + ordersId;
			} 
		}
	</script>
	<div class="paging"> 
		<pg:pager url="${baseUrl}" page="${busiOrdersPage}" />
	    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
	    <div class="sys_btnBox">
			<input type="button" value="创建新定金单" onclick="window.location='busiOrders/create'" />
		</div>	
	</div>	
</div>
</div>
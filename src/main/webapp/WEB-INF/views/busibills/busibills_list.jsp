<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="utils" uri="http://www.ccesun.com/tags/utils" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<dict:loadDictList type="sales_type" var="sales_type" />
<dict:loadDictList type="sales_state" var="sales_state" />

			<div class="title_box">
				<h2>销售单据管理</h2>
			</div>
			<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
			<div class="customer">
				<p>销售单号
					<form:input path="form['salesCode_blk']" id="search_salesCode" cssClass="input_text w_172" placeholder="销售单号"/>
					客户电话号码
					<form:input path="form['busiClient.cellPhone_blk']" id="search_cellPhone" cssClass="input_text w_172" placeholder="客户电话号码"/>
					<form:hidden path="form['salesTypeKey_eq']" id="search_salesTypeKey" />
					<form:hidden path="form['salesStateKey_eq']" id="search_salesStateKey" />
					<form:hidden path="form['sysDept.deptId_eq_int']" id="search_deptId" />
					<form:hidden path="form['createTime_elt']" id="search_createTime" />
					<button type="submit" class="btn"><i class="icon-search"></i> 搜索</button>
				</p>
			</div>
			</form:form>
			<div class="customer">
				<h4>单据筛选表<a href="#this" class="toggle_table">折叠</a></h4>
				<dl>
					<dt>类型筛选：</dt>
					<dd><a href="javascript: void(0)" class="salesTypeKey filter" value="">全部</a>
					<c:forEach items="${sales_type}" var="entry" varStatus="status">
						<a href="javascript: void(0)" class="salesTypeKey filter" value="${entry.dictKey}">${entry.dictValue0}</a>
					</c:forEach>
					</dd>
				</dl>
				<dl>
					<dt>状态筛选：</dt>
					<dd><a href="javascript: void(0)" class="salesStateKey filter" value="">全部</a>
					<c:forEach items="${sales_state}" var="entry" varStatus="status">
						<a href="javascript: void(0)" class="salesStateKey filter" value="${entry.dictKey}">${entry.dictValue0}</a>
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
					$('.salesTypeKey').each(function() {
						var value = $('#search_salesTypeKey').val();
						if (value == $(this).attr('value'))
							$(this).addClass('curr');
					});
					
					$('.salesStateKey').each(function() {
						var value = $('#search_salesStateKey').val();
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
					
					$('.salesTypeKey').click(function() {
						$('#search_salesTypeKey').val($(this).attr('value'));
					});
					
					$('.salesStateKey').click(function() {
						$('#search_salesStateKey').val($(this).attr('value'));
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
				<table class="tbl_l" border="1" cellpadding="0" cellspacing="0" width="100%">
						<colgroup>
							<col width="150">
							<col width="150">
							<col width="100">
							<col width="*">
							<col width="100">
							<col width="220">
							<col width="80">
						</colgroup>
						<thead>
							<tr>
								<th>日期/时间</th>
								<th>订单号</th>
								<th>总金额</th>
								<th>单据简明</th>
								<th>单据状态</th>
								<th>系统关联提示</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${busiSalesPage.content}" var="entry">
							<tr>
								<td>${entry.createTime }</td>
								<td><a href="${pageContext.request.contextPath }/busiBills/viewBills?salesId=${entry.salesId}" title="查看">${entry.salesCode }</a></td>
								<td>${entry.feeSum }</td>
								<td class="tl nowrap">${entry.busiClient.clientName } | ${entry.busiClient.cellPhone } | ${entry.busiClient.address }</td>
								<td><dict:lookupDictValue key="${entry.salesStateKey }" type="sales_state" /> </td>
								<td class="tl">
									<utils:methodInvokor methodName="countBySalesId" var="countSalesClear" className="org.jaronsource.msneg.service.BusiSalesClearService" >
										<utils:miParam type="java.lang.Integer" value="${entry.salesId }"></utils:miParam>
									</utils:methodInvokor>
									<utils:methodInvokor methodName="countBySalesId" var="countSalesReturn" className="org.jaronsource.msneg.service.BusiSalesReturnService" >
										<utils:miParam type="java.lang.Integer" value="${entry.salesId }"></utils:miParam>
									</utils:methodInvokor>
									<utils:methodInvokor methodName="countBySalesId" var="countSalesMakeup" className="org.jaronsource.msneg.service.BusiSalesMakeupService" >
										<utils:miParam type="java.lang.Integer" value="${entry.salesId }"></utils:miParam>
									</utils:methodInvokor>
									<c:if test="${countSalesClear > 0 }"><a href="${pageContext.request.contextPath }/busiBills/viewBills?salesId=${entry.salesId}" title="查看">结算单(${countSalesClear })</a></c:if> 
									<c:if test="${countSalesMakeup > 0 }"><a href="${pageContext.request.contextPath }/busiBills/viewBills?salesId=${entry.salesId}" title="查看">补价单(${countSalesMakeup })</a></c:if>
									<c:if test="${countSalesReturn > 0 }"><a href="${pageContext.request.contextPath }/busiBills/viewBills?salesId=${entry.salesId}" title="查看">返销单(${countSalesReturn })</a></c:if>
								</td>
								<td>
									<c:choose>
										<c:when test="${entry.billStateKey != 'B' && entry.billStateKey != 'C' && entry.billStateKey != 'D' }">
											<security:hasPerm permCode="12">
												<a href="${pageContext.request.contextPath }/busiBills/changeBillState?salesId=${entry.salesId }&state=C">申请完结</a>
											</security:hasPerm>
										</c:when>
										<c:when test="${entry.billStateKey == 'C'}">
											<security:hasPerm permCode="13">
												<a href="${pageContext.request.contextPath }/busiBills/changeBillState?salesId=${entry.salesId }&state=D">完结</a>
											</security:hasPerm>
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
					<div class="paging"> 
						<pg:pager url="${baseUrl}" page="${busiSalesPage}" />
					    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
					</div>				
				</div>
			<!--//box--> 
		</div>
	
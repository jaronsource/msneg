<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="utils" uri="http://www.ccesun.com/tags/utils" %>
<dict:loadDictList type="sales_type" var="sales_type" />
<dict:loadDictList type="sales_state" var="sales_state" />
<dict:loadDictList type="finance_state" var="finance_state" />
			<%
				String financeState = request.getParameter("form['financeStateKey_eq']");
				pageContext.setAttribute("financeState", financeState);
			%>
			
			<div class="title_box">
				<h2>财务统计审核 </h2>
			</div>
			
			<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
				<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all" role="tablist">
					<li class="ui-state-default ui-corner-top <c:if test="${financeState == 'A' }" >ui-tabs-active ui-state-active</c:if>" role="tab" tabindex="0" aria-controls="tabs-1" aria-labelledby="ui-id-1" aria-selected="true"><a href="${pageContext.request.contextPath}/busiFinance?form['financeStateKey_eq']=A" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-1">待审核</a></li>
					<li class="ui-state-default ui-corner-top <c:if test="${financeState == 'B' }" >ui-tabs-active ui-state-active</c:if>" role="tab" tabindex="-1" aria-controls="tabs-2" aria-labelledby="ui-id-2" aria-selected="false"><a href="${pageContext.request.contextPath}/busiFinance?form['financeStateKey_eq']=B" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-2">已审核</a></li>
				</ul>
				
				<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
			<div class="customer">
				<p>销售单号
					<form:input path="form['salesCode_blk']" id="search_salesCode" cssClass="input_text w_172" placeholder="销售单号"/>
					客户电话号码
					<form:input path="form['busiClient.cellPhone_blk']" id="search_cellPhone" cssClass="input_text w_172" placeholder="客户电话号码"/>
					<form:hidden path="form['salesTypeKey_eq']" id="search_salesTypeKey" />
					<form:hidden path="form['financeStateKey_eq']" id="search_salesStateKey" />
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
							<col width="40">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="100">
							<col width="*">
							<col width="150">
							<col width="60">
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>日期</th>
								<th>订单号</th>
								<th>总金额</th>
								<th>预付现金</th>
								<th>预付刷卡</th>
								<th>单据简明</th>
								<th>相关单据</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${busiSalesPage.content}" var="entry">
							<tr>
								<td><a href="javascript: void(0)" class="detailLink" style="text-decoration: none" title="查看单据">+</a></td>
								<td>${fn:substring(entry.createTime, 0, 8) }</td>
								<td>${entry.salesCode }</td>
								<td>${entry.feeSum }</td>
								<td>${entry.feePrepayCash }</td>
								<td>${entry.feePrepayCard }</td>
								<td>${entry.busiClient.clientName } ${entry.busiClient.cellPhone }</td>
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
										<c:when test="${financeState == 'A' }">
											<input type="button" value="确认" onclick="if (confirm('确定进行此操作吗？')) {window.location='busiFinance/changeState?salesId=${entry.salesId }&state=B';}" />
										</c:when>
										<c:otherwise>
											-
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
							<utils:methodInvokor methodName="findBySalesId" var="clearList" className="org.jaronsource.msneg.service.BusiSalesClearService">
								<utils:miParam type="java.lang.Integer" value="${entry.salesId }"></utils:miParam>
							</utils:methodInvokor>
							<utils:methodInvokor methodName="findBySalesId" var="returnList" className="org.jaronsource.msneg.service.BusiSalesReturnService">
								<utils:miParam type="java.lang.Integer" value="${entry.salesId }"></utils:miParam>
							</utils:methodInvokor>
							<utils:methodInvokor methodName="findBySalesId" var="makeupList" className="org.jaronsource.msneg.service.BusiSalesMakeupService">
								<utils:miParam type="java.lang.Integer" value="${entry.salesId }"></utils:miParam>
							</utils:methodInvokor>
							<tr style="display: none">
								<td colspan="10" style="padding: 10px;">
										<table class="tbl_l" border="1" cellpadding="0" cellspacing="0" width="100%">
										<colgroup>
											<col width="140">
											<col width="200">
											<col width="140">
											<col width="140">
											<col width="*">
										</colgroup>
										<thead>
											<th>单据类型</th>
											<th>日期/时间</th>
											<th>金额</th>
											<th>结算状态</th>
											<th>信息备注</th>
										</thead> 
										<tbody>
											<c:forEach items="${clearList}" var="item">
											<tr>
												<td>结算单</td>
												<td>${item.createTime }</td>
												<td>${item.clearSum }</td>
												<td><dict:lookupDictValue key="${item.financeStateKey }" type="finance_state"></dict:lookupDictValue> </td>
												<td>&nbsp;</td>
											</tr>
											</c:forEach>
											<c:forEach items="${returnList}" var="item">
											<tr>
												<td>返销单</td>
												<td>${item.createTime }</td>
												<td>${item.actReturnSum }</td>
												<td><dict:lookupDictValue key="${item.financeStateKey }" type="finance_state"></dict:lookupDictValue> </td>
												<td>${item.returnRemarks }</td>
											</tr>
											</c:forEach>
											<c:forEach items="${makeupList}" var="item">
											<tr>
												<td>补价单</td>
												<td>${item.createTime }</td>
												<td>${item.makeupSum }</td>
												<td><dict:lookupDictValue key="${item.financeStateKey }" type="finance_state"></dict:lookupDictValue> </td>
												<td>${item.makeupRemarks }</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</td>
							</tr>
							</c:forEach>
							<script>
								$('.detailLink').toggle(function() {
									$(this).parents('tr').next().show();
									$(this).text('-');
								}, function() {
									$(this).parents('tr').next().hide();
									$(this).text('+');
								});
							</script>
						</tbody>
					</table>
					<div class="paging"> 
						<pg:pager url="${baseUrl}" page="${busiSalesPage}" />
					    <%@ include file="/WEB-INF/pagers/pager-default.jsp" %>	
					</div>				
				</div>
			<!--//box--> 
		</div>
	</div>	
			
			
	
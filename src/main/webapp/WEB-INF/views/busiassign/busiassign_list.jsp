<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<dict:loadDictList type="sales_type" var="sales_type" />
<dict:loadDictList type="sales_state" var="sales_state" />
			<%
				String salesState = request.getParameter("form['salesStateKey_eq']");
				pageContext.setAttribute("salesState", salesState);
			%>
			
			<div class="title_box">
				<h2>销售单据管理 </h2>
			</div>
			
			<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
				<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all" role="tablist">
					<li class="ui-state-default ui-corner-top <c:if test="${salesState == 'B' }" >ui-tabs-active ui-state-active</c:if>" role="tab" tabindex="0" aria-controls="tabs-1" aria-labelledby="ui-id-1" aria-selected="true"><a href="${pageContext.request.contextPath}/busiAssign?form['salesStateKey_eq']=B" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-1">待备货</a></li>
					<li class="ui-state-default ui-corner-top <c:if test="${salesState == 'C' }" >ui-tabs-active ui-state-active</c:if>" role="tab" tabindex="-1" aria-controls="tabs-2" aria-labelledby="ui-id-2" aria-selected="false"><a href="${pageContext.request.contextPath}/busiAssign?form['salesStateKey_eq']=C" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-2">已备货</a></li>
					<li class="ui-state-default ui-corner-top <c:if test="${salesState == 'D' }" >ui-tabs-active ui-state-active</c:if>" role="tab" tabindex="-1" aria-controls="tabs-3" aria-labelledby="ui-id-3" aria-selected="false"><a href="${pageContext.request.contextPath}/busiAssign?form['salesStateKey_eq']=D" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-3">已到货</a></li>
				</ul>
				
				<form:form modelAttribute="searchForm" action="${REQUEST_URI}" class="form-inline" >
			<div class="customer">
				<p>销售单号
					<form:input path="form['salesCode_blk']" id="search_salesCode" cssClass="input_text w_172" placeholder="销售单号"/>
					客户电话号码
					<form:input path="form['cellPhone_blk']" id="search_cellPhone" cssClass="input_text w_172" placeholder="客户电话号码"/>
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
							<col width="140">
							<col width="100">
							<col width="25%">
							<col width="100">
							<col width="30">
						</colgroup>
						<thead>
							<tr>
								<th>日期/时间</th>
								<th>订单号</th>
								<th>单据简明</th>
								<th>单据状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${busiSalesPage.content}" var="entry">
							<tr>
								<td>${entry.createTime }</td>
								<td>${entry.salesCode }</td>
								<td class="tl">${entry.salesRemarks }</td>
								<td><dict:lookupDictValue key="${entry.salesStateKey }" type="sales_state" /> </td>
								<td>
									<c:choose>
										<c:when test="${salesState == 'B' }">
											<input type="button" value="备货" onclick="window.location='busiAssign/changeState?salesId=${entry.salesId }&state=C';" />
										</c:when>
										<c:when test="${salesState == 'C' }">
											<input type="button" value="到货" onclick="window.location='busiAssign/changeState?salesId=${entry.salesId }&state=D';" />
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
	</div>	
			
			
	
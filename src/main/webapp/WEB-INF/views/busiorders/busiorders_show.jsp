<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<dict:loadDictList type="orders_type" var="orders_type" />
<dict:loadDictList type="orders_use" var="orders_use" />
<dict:loadDictList type="orders_return" var="orders_return" />
<security:securityUser var="user" />
<div class="title_box">
	<h2>开据定金单</h2>
	<div class="sys_btnBox">
		<input type="button" value="打印" onclick="window.location='print'" />
		<input type="button" value="退出" onclick="window.location='${pageContext.request.contextPath}/busiOrders';"/>
	</div>
</div>
<div class="order_box">
<!--box-->
	<div class="com_box">
		<h3 class="title_line">客户信息<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="10%" />
				<col width="15%" />
				<col width="10%" />
				<col width="15%" />
				<col width="10%" />
				<col width="15%" />
				<col width="10%" />
				<col width="15%" />
			</colgroup>
			<tbody>
				<tr>
					<th>客户名称</th>
					<td>${busiOrders.busiClient.clientName }</td>
					<th>物业地址</th>
					<td colspan="5">${busiOrders.busiClient.address }</td>
				</tr> 
				<tr>
					<th>联系手机</th>
					<td>${busiOrders.busiClient.cellPhone }</td>
					<th>联系电话</th>
					<td>${busiOrders.busiClient.areacode } - ${busiOrders.busiClient.phone }</td>
					<th>出单部门</th>
					<td>${busiOrders.sysDept.deptName}</td>
					<th>单据经手</th>
					<td>${busiOrders.busiClient.clientName }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td colspan="7">${busiOrders.ordersCode }</td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>预定/定金信息部分<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="10%" />
				<col width="50%" />
				<col width="10%" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>定金类型</th>
					<td colspan="3">
						<c:forEach items="${busiOrders.ordersTypeKeys }" var="ordersTypeKey">
						<c:forEach items="${orders_type}" var="entry" varStatus="status">
							<c:if test="${ordersTypeKey == entry.dictKey }">${entry.dictValue0 } </c:if>
						</c:forEach>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>信息填写</th>
					<td colspan="3"><textarea name="textarea" style="height:200px" class="textarea" cols="" rows="" readonly="readonly">${busiOrders.ordersRemarks }</textarea></td>
							</tr>
							<tr>
								<th>定金用途</th>
								<td>
									<c:forEach items="${orders_use}" var="entry" varStatus="status">
										<input type="radio" name="ordersUseKey" class="radio orders_use" value="${entry.dictKey}" <c:if test="${busiOrders.ordersUseKey == entry.dictKey }">checked="checked"</c:if>/>${entry.dictValue0}
									</c:forEach>
								</td>
								<th>定金返还</th>
								<td>
									<c:forEach items="${orders_return}" var="entry" varStatus="status">
										<input type="radio" name="ordersReturnKey" class="radio orders_return" value="${entry.dictKey}" <c:if test="${busiOrders.ordersReturnKey == entry.dictKey }">checked="checked"</c:if>/>${entry.dictValue0}
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>

				</div>
				<!--//box-->
	<!--box--><!--//box-->
	
	<!--box-->
	<div class="com_box">
		<h3>财务结算部分<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="10%" />
				<col width="40%" />
				<col width="40%" />
			</colgroup>
			<tbody>
				<tr>
					<th>总金额</th>
					<td>¥ <span class="money" id="ordersSumDisplay">${busiOrders.ordersSum }</span></td>
					<td> 现金 ¥ <span class="money">${busiOrders.ordersCash}</span> 刷卡 ¥ <span class="money">${busiOrders.ordersCard}</span></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>其他信息备注部分<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<td><textarea name="otherRemarks" class="textarea" cols="" rows="" readonly="readonly">${busiOrders.otherRemarks }</textarea></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box--><!--//box-->
</div>

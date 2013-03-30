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
		<input type="button" value="保存" id="submitBtn" /> <input type="button" value="打印" /> <input type="button" value="退出" />
		<script>
			$('#submitBtn').click(function() { $('#busiOrdersForm').submit(); });
		</script>
	</div>
</div>
<div class="customer">
	<p>快速查找客户：<input type="text" name="clientPhone" class="input_text w_172" id="clientPhoneTerm" placeholder="请输入电话号码" /> <input type="button" value="确定" /></p>
	<script>
	$('#clientPhoneTerm').autocomplete(
			{
				source : function(request, response) {
					
					$.getJSON('${pageContext.request.contextPath}/busiClient/ajaxFindClient', request, function(data) {
						response(data); 
					});
				}
				,autoFocus: true
				,select: function(event, ui) {
					$('#clientId').val(ui.item.clientId);
					$('#clientName').val(ui.item.clientName);
					$('#address').val(ui.item.address);
					$('#areacode').val(ui.item.areacode);
					$('#phone').val(ui.item.phone);
					$('#cellPhone').val(ui.item.cellPhone);
				}
				,open: function() { $('.ui-menu').width(300); } 
			});
	</script>
</div>
<form:form modelAttribute="busiOrders" id="busiOrdersForm">
<form:hidden path="busiClient.clientId" id="clientId" />
<form:hidden path="ordersCode" value="${ordersCode}" />
<form:hidden path="ordersTypeKeys" id="ordersTypeKeys" />
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
					<td><form:input path="busiClient.clientName" cssClass="wb90 input_text" id="clientName"/></td>
					<th>物业地址</th>
					<td colspan="5"><form:input path="busiClient.address" cssClass="wb95 input_text" id="address"/></td>
				</tr> 
				<tr>
					<th>联系电话</th>
					<td><form:input path="busiClient.areacode" cssClass="w_40 input_text" id="areacode" /> - <form:input path="busiClient.phone" cssClass="w_70 input_text" id="phone" /></td>
					<th>联系手机</th>
					<td><form:input path="busiClient.cellPhone" cssClass="wb90 input_text" id="cellPhone"/></td>
					<th>出单部门</th>
					<td>${user.dept.deptName }</td>
					<th>单据经手</th>
					<td>${user.realName }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td>${ordersCode }</td>
					<th>相关备注</th>
					<td colspan="5"><form:input path="ordersRemarks" cssClass="wb95 input_text" /></td>
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
						<c:forEach items="${orders_type}" var="entry" varStatus="status">
							<input type="checkbox" class="orders_type input" value="${entry.dictKey}" />${entry.dictValue0}
						</c:forEach>
					</td>
					<script>
						var keys = $('#ordersTypeKeys').val();
						var keyArray = keys.split(',');
						$.each(keyArray, function(index, value) {
							$('.orders_type').each(function() {
								if ($(this).val() == value) {
									$(this).attr('checked', true);
								}
							});
						});
						
						$('.orders_type').change(function() {
							var keyArray = [];
							$('.orders_type:checked').each(function() {
								keyArray.push($(this).val());
							});
							$('#ordersTypeKeys').val(keyArray.join(','));
						});
					</script>
				</tr>
				<tr>
					<th>信息填写</th>
					<td colspan="3"><textarea name="textarea" style="height:200px" class="textarea" cols="" rows=""></textarea></td>
							</tr>
							<tr>
								<th>定金用途</th>
								<td>
									<c:forEach items="${orders_use}" var="entry" varStatus="status">
										<input type="radio" class="radio orders_use" value="${entry.dictKey}" <c:if test="${status.index == 0 }">checked="checked"</c:if>/>${entry.dictValue0}
									</c:forEach>
								</td>
								<th>定金返还</th>
								<td>
									<c:forEach items="${orders_return}" var="entry" varStatus="status">
										<input type="radio" class="radio orders_return" value="${entry.dictKey}" <c:if test="${status.index == 0 }">checked="checked"</c:if>/>${entry.dictValue0}
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
					<td><span class="money" id="ordersSumDisplay">￥ 0.00</span></td>
					<input type="hidden" name="ordersSum" />
					<td><input type="checkbox" id="checkCash" /> 现金 ￥ <input type="text" class="input_money" name="ordersCash" id="ordersCash" />  <input type="checkbox" id="checkCard" /> 刷卡 ￥ <input type="text" class="input_money" name="ordersCard" id="" /></td>
					<script>
						$('#checkCash').click(function() {
							if ($(this).is(':checked')) { 
								$('#feePrepayCash').attr('disabled', false);
							} else {
								$('#feePrepayCash').attr('disabled', true); 
								$('#feePrepayCash').val('0.00');
							}
						});
						$('#checkCard').click(function() {
							if ($(this).is(':checked')) {
								$('#feePrepayCard').attr('disabled', false);
							} else {
								$('#feePrepayCard').attr('disabled', true);
								$('#feePrepayCard').val('0.00');
							}
						});
						
						$('#feePrepayCash, #feePrepayCard').keyup(feeRemain);
					</script>
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
					<td><textarea name="otherRemarks" class="textarea" cols="" rows=""></textarea></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box--><!--//box-->
</div>
</form:form>
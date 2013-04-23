<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<dict:loadDictList type="return_reason" var="return_reason" />
<dict:loadDictList type="clear_method" var="clear_method" />
<security:securityUser var="user" />
<script>
function addSaleItems(element, value) {
	var $tr = $('<tr></tr>');
	var $td1 = $('<td><input type="checkbox" name="salesItemId" class="salesItemId" value="' + value.salesItemId + '"/></td>');
	var $td2 = $('<td><span class="category">' + value.category + '</span></td>');
	var $td3 = $('<td><span class="itemName">' + value.itemName + '</span></td>');
	var $td4 = $('<td><span class="itemUnit">' + value.itemUnit + '</span></td>');
	var $td5 = $('<td><span class="itemAmount">' + value.itemAmount + '</span></td>');
	var $td6 = $('<td><input type="text" name="returnAmount" class="w_50 input_text returnAmount" /></td>');
	var $td7 = $('<td><span class="money itemPrice">' + new Number(value.itemPrice).toFixed(2) + '</span></td>');
	var $td8 = $('<td><input type="text" name="returnPrice" class="w_50 input_text returnPrice" value="' + new Number(value.itemPrice).toFixed(2) + '" /></td>');
	var $td9 = $('<td><span class="money returnSum">' + new Number(value.itemSum).toFixed(2) + '</span></td>');
	var $td10 = $('<td><select name="returnReasonKey" class="returnReasonKey"></select></td>');
	<c:forEach items="${return_reason}" var="entry">
		$('<option value="${entry.dictKey}">${entry.dictValue0}</option>').appendTo($td10.find('select'));
	</c:forEach>
	var $td11 = $('<td><span class="itemRemarks">' + value.itemRemarks + '</span></td>');

	$tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8).append($td9).append($td10).append($td11);
	$tr.appendTo(element);
	
	$tr.find(".returnAmount, .returnPrice, .salesItemId").keyup(function() {
		sumTotal();
	});
	
	$tr.find(".returnPrice").change(formatMoney);
}

function sumTotal () {
	
	var total = 0;
	$('.returnAmount').each(function () {
		var $parent = $(this).parents('tr');
		
		var checked = $parent.find('input[name="salesItemId"]:checked').length == 1;
		if (checked) {
			var returnPriceValue = parseFloat($parent.find('.returnPrice').val());
			returnPriceValue = isNaN(returnPriceValue) ? 0 : returnPriceValue;
			var returnAmountValue = parseFloat($parent.find('.returnAmount').val());
			returnAmountValue = isNaN(returnAmountValue) ? 0 : returnAmountValue;
			total += returnPriceValue * returnAmountValue;
			console.debug(total);
		}
	});
	
	$('#returnSumDisplay').text(total.toFixed(2));
	$('#returnSum').val(total.toFixed(2));
	
	actReturn();
	
}

function actReturn() {
	var returnLoss = parseFloat($('#returnLoss').val());
	returnLoss = isNaN(returnLoss) ? 0 : returnLoss;
	var rerateLoss = parseFloat($('#rerateLoss').val());
	rerateLoss = isNaN(rerateLoss) ? 0 : rerateLoss;
	
	var total = $('#returnSum').val();
	var actReturnSum = total - returnLoss - rerateLoss;
	
	$('#actReturnSumDisplay').text(actReturnSum.toFixed(2));
	$('#actReturnSum').val(actReturnSum); 
	
}


</script>
<form:form modelAttribute="busiSalesReturn" id="busiSalesReturnForm" method="post">
<input type="hidden" name="busiSales.salesId" id="salesId" />
<div class="title_box">
	<h2>开据返销单</h2>
	<div class="sys_btnBox">
		<input type="button" value="保存" id="submitBtn" /> <input type="button" value="退出" id="returnBtn"/>
		<script>
			$('#submitBtn').click(function() { $('#busiSalesReturnForm').submit(); });
			$('#returnBtn').click(function() { window.location = '${pageContext.request.contextPath}/sales'; });
		</script>
	</div>
</div>
<div class="customer">
	<p>手工输入母单号 <input type="text" name="salesCodeTerm" class="input_text w_172" placeholder="请输入母单号" id="salesCodeTerm" /> 快速查找客户：<input type="text" name="clientPhoneTerm" class="input_text w_172" placeholder="请输入电话号码" id="clientPhoneTerm" /></p>
	<script>
		function select(event, ui) {
			$('#clientName').text(ui.item.clientName);
			$('#address').text(ui.item.address);
			$('#areacode').text(ui.item.areacode);
			$('#phone').text(ui.item.phone);
			$('#cellPhone').text(ui.item.cellPhone);
			$('#deptName').text(ui.item.deptName);
			$('#sysUser').text(ui.item.sysUser);
			$('#salesCode').text(ui.item.salesCode);
			$('#salesRemarks').text(ui.item.salesRemarks);
			$('#salesId').val(ui.item.salesId);
			
			var salesId = ui.item.salesId;
			$.getJSON('${pageContext.request.contextPath}/busiSalesItem/ajaxFindSalesItem', {'salesId': salesId}, function(data) {
				$('#salesItemList tbody').empty();
				$.each(data, function(index, value) {
					addSaleItems($('#salesItemList tbody'), value);
				});
			});
		}
		
		$('#salesCodeTerm').autocomplete(
			{
				source : function(request, response) {
					
					$.getJSON('${pageContext.request.contextPath}/busiSales/ajaxFindSalesBySalesCode', request, function(data) {
						response(data); 
					});
				}
				,autoFocus: true
				,select: select
				,open: function() { $('.ui-menu').width(400); } 
			});
		
		$('#clientPhoneTerm').autocomplete(
			{
				source : function(request, response) {
					
					$.getJSON('${pageContext.request.contextPath}/busiSales/ajaxFindSalesByClientCellPhone', request, function(data) {
						response(data); 
					});
				}
				,autoFocus: true
				,select: select
				,open: function() { $('.ui-menu').width(400); } 
			});
	</script>
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
					<td><span id="clientName"></span></td>
					<th>物业地址</th>
					<td colspan="5"><span id="address"></span></td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td><span id="phone"></span></td>
					<th>联系手机</th>
					<td><span id="cellPhone"></span></td>
					<th>出单部门</th>
					<td><span id="deptName"></span></td>
					<th>单据经手</th>
					<td><span id="sysUser"></span></td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td><span id="salesCode"></span></td>
					<th>相关备注</th>
					<td colspan="5"><span id="salesRemarks"></span></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>商品信息<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" id="salesItemList" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="40" />
				<col width="100" />
				<col width="*" />
				<col width="50" />
				<col width="50" />
				<col width="80" />
				<col width="90" />
				<col width="80" />
				<col width="90" />
				<col width="70" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th>选择</th>
					<th>系列</th>
					<th>名称/货号/型号</th>
					<th>单位</th>
					<th>数量</th>
					<th>返销数量</th>
					<th>单价</th>
					<th>返销单价</th>
					<th>合计</th>
					<th>返销事由</th>
					<th>信息备注</th>
				</tr>
			</thead>
			<tbody>
				
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
				<col width="14%" />
				<col width="10%" />
				<col width="*" />
				<col width="10%" />
				<col width="*" />
				<col width="*" />
			</colgroup>
						<tbody>
							<tr>
								<th>应返金额</th>
								<td>¥ <span class="money" id="returnSumDisplay" >0.00</span></td>
								<input type="hidden" name="returnSum" id="returnSum" />
								<th>返销报损</th>
								<td>¥ <input type="text" class="input_money returnLoss" name="returnLoss" id="returnLoss" value="0.00"/></td>
								<th>折扣报损</th>
								<td>¥ <input type="text" class="input_money rerateLoss" name="rerateLoss" id="rerateLoss" value="0.00"/></td>
								<script>
									$('#returnLoss, #rerateLoss').keyup(function() {
										actReturn();
									});
								</script>
								<th>其他备注</th>
								<td><input type="text" name="return_remarks" class="wb95 input_text" /></td>
							</tr>
							<tr>
								<th>实返金额</th>
								<td>¥ <span class="money" id="actReturnSumDisplay">0.00</span></td>
								<input type="hidden" name="actReturnSum" id="actReturnSum"/>
								<th>结算形式</th>
								<td colspan="3">
									<c:forEach items="${clear_method}" var="entry" varStatus="status">
										<input type="radio" class="clearMethodKey radio" name="clearMethodKey" value="${entry.dictKey}" <c:if test="${status.index == 0 }">checked="checked"</c:if>/>${entry.dictValue0}
									</c:forEach>
								</td>
								<th>经手人</th>
								<td>${user.userName }</td>
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
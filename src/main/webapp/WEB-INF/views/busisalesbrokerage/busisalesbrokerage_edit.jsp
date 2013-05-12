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
	var $td6 = $('<td><span class="money itemPrice">' + value.itemPrice + '</span></td>');
	var $td7 = $('<td><span class="money itemSum">' + value.itemSum + '</span></td>');
	var $td8 = $('<td><span class="returnMarkers" ></span></td>');

	$tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8);
	$tr.appendTo(element);
	
	$(".returnAmount").keyup(function() {
		sumTotal($(this));
	});
	
	$(".returnPrice").keyup(function() {
		sumTotal($(this));
	});
	
	$(".salesItemId").click(function() {
		sumTotal($(this));
	});
}

function sumTotal ($element) {
	
	var total = 0;
	$('.returnAmount').each(function () {
		var $parent = $element.parents('tr');
		
		var checked = $parent.find('input[name="salesItemId"]:checked').length == 1;
		if (checked) {
			var returnPriceValue = parseFloat($parent.find('.returnPrice').val());
			returnPriceValue = isNaN(returnPriceValue) ? 0 : returnPriceValue;
			var returnAmountValue = parseFloat($parent.find('.returnAmount').val());
			returnAmountValue = isNaN(returnAmountValue) ? 0 : returnAmountValue;
			total += returnPriceValue * returnAmountValue;
		}
	});
	
	$('#returnSumDisplay').text(total);
	$('#returnSum').val(total);
	
	actReturn();
	
}

function actReturn() {
	var returnLoss = parseFloat($('#returnLoss').val());
	returnLoss = isNaN(returnLoss) ? 0 : returnLoss;
	var rerateLoss = parseFloat($('#rerateLoss').val());
	rerateLoss = isNaN(rerateLoss) ? 0 : rerateLoss;
	
	var total = $('#returnSum').val();
	var actReturnSum = total - returnLoss - rerateLoss;
	
	$('#actReturnSumDisplay').text(actReturnSum);
	$('#actReturnSum').val(actReturnSum); 
	
}

</script>
<form:form modelAttribute="busiSalesClear" id="busiSalesClearForm" method="post">
<input type="hidden" name="busiSales.salesId" id="salesId" />
<div class="title_box">
	<h2>开据结算单</h2>
	<div class="sys_btnBox">
		<input type="button" value="保存" id="submitBtn" /> <input type="button" value="打印" /> <input type="button" value="退出" />
		<script>
			$('#submitBtn').click(function() { $('#busiSalesClearForm').submit(); });
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
				,open: function() { $('.ui-menu').width(300); } 
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
				,open: function() { $('.ui-menu').width(300); } 
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
					<th>联系手机</th>
					<td><span id="cellPhone"></span></td>
					<th>联系电话</th>
					<td><span id="phone"></span></td>
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
		<table id="salesItemList" width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="40" />
				<col width="50" />
				<col width="*" />
				<col width="50" />
				<col width="50" />
				<col width="80" />
				<col width="80" />
				<col width="*" />
			</colgroup>
			<thead>
				<tr>
					<th>选择</th>
					<th>类别</th>
					<th>名称/货号/型号</th>
					<th>单位</th>
					<th>数量</th>
					<th>单价</th>
					<th>合计</th>
					<th>信息备注</th>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>安装/取送/服务部分<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="10%" />
				<col width="15%" />
				<col width="10%" />
				<col width="23%" />
				<col width="10%" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>物流信息</th>
					<td>正常</td>
					<th>取送方式</th>
					<td>自取</td>
					<th>安装方式</th>
					<td>工费自付</td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	
	<!--box-->
	<div class="com_box">
		<h3>财务结算部分<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="10%" />
				<col width="14%" />
				<col width="10%" />
				<col width="40%" />
				<col width="10%" />
				<col width="*" />
			</colgroup>548u7 
			<tbody>
				<tr>
					<th>总金额</th>
					<td><span class="money">￥ 0.00</span></td>
					<th>预付金额</th>
					<td><input type="checkbox" name="" id="" /> 现金 ￥ <input type="text" class="input_money" name="" id="" />  <input type="checkbox" name="" id="" /> 刷卡 ￥ <input type="text" class="input_money" name="" id="" /></td>
					<th>剩余尾款</th>
					<td><span class="money">￥ 0.00</span></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!-- 
	<div class="sys_btnBox bom_btn">
		<input type="button" value="单据结算" />
	</div>
	 -->
	<!--box-->
	<div class="com_box">
		<h3>其他信息备注部分<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<td><textarea name="" class="textarea" cols="" rows=""></textarea></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box--><!--//box-->
</div>
</form:form>   
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<dict:loadDictList type="item_unit" var="item_unit" />
<dict:loadDictList type="serv_logis" var="serv_logis" />
<dict:loadDictList type="serv_getmethod" var="serv_getmethod" />
<dict:loadDictList type="serv_installmethod" var="serv_installmethod" />
<style type="text/css">
#busiCategorySelector li {float: left; margin-right: 5px; padding: 5px;}
</style>
<script>
var $selectCateId; 
var $selectCateIdDisplay; 
function addSaleItems(element) {
	var $tr = $('<tr></tr>');
	var $td1 = $('<td><input type="hidden" name="cateId" class="cateId"/><input class="cateIdBtn" type="button" value="选择系列" /></td>');
	//var $td1 = $('<td><select name="cateId" class="cateId"></select></td>');
	//<c:forEach items="${busiCategories}" var="entry">
	//	$('<option value="${entry.cateId}">${entry.cateName}</option>').appendTo($td1.find('select'));
	//</c:forEach>
	var $td2 = $('<td><input type="hidden" name="itemId" /><input type="text" name="itemName" class="wb95 input_text itemName" /></td>');
	var $td3 = $('<td><select name="itemUnit" class="itemUnit"></select></td>');
	<c:forEach items="${item_unit}" var="entry">
		$('<option value="${entry.dictKey}">${entry.dictValue0}</option>').appendTo($td3.find('select'));
	</c:forEach>
	var $td4 = $('<td><input type="text" name="itemAmount" class="w_50 input_text itemAmount" value="0" /></td>');
	var $td5 = $('<td>¥ <input type="text" class="w_50 input_money itemPrice" name="itemPrice" value="0.00" /></td>');
	var $td6 = $('<td><input type="hidden" name="itemSum" />¥ <span class="money itemSum">0.00</span></td>');
	var $td7 = $('<td><input type="text" name="itemRemarks" class="wb95 input_text itemRemarks" /></td>');
	var $td8 = $('<td><span class="green stockAmount"></span></td>');
	
	$tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8);
	$tr.appendTo(element);
	
	$tr.find('.cateIdBtn').click(function() {
		var $parent = $(this).parents('tr');
		$selectCateId = $parent.find('.cateId');
		$selectCateIdDisplay = $parent.find('.cateIdBtn');
		$('#busiCategorySelector').dialog('open');
	});
	
	$tr.find('.itemName').autocomplete(
			{
				source : function(request, response) {
					
					var $parent = $($(this)[0].element).parents('tr');
					var cateIdValue = $parent.find('.cateId').val();
					request['cateId'] = cateIdValue;
					
					$.getJSON('${pageContext.request.contextPath}/busiItem/ajaxFindItem', request, function(data) {
						response(data); 
					});
				}
				,autoFocus: true
				,select: function(event, ui) {
					var $parent = $(this).parents('tr');
					$parent.find('input[name=itemId]').val(ui.item.itemId);
					$parent.find('.itemPrice').val(new Number(ui.item.price).toFixed(2));
					$parent.find('.itemUnit').children('[value="' + ui.item.unit + '"]').attr('selected', true);
					var stock = parseInt(ui.item.stockAmount) == 0 ? '没货' : '有货(' + ui.item.stockAmount + ')';
					$parent.find('.stockAmount').text(stock);
				}
			});
	
	$tr.find(".itemAmount, .itemPrice").keyup(function() {
		var $parent = $(this).parents('tr');
		var itemPriceValue = parseFloat($parent.find('.itemPrice').val());
		itemPriceValue = isNaN(itemPriceValue) ? 0 : itemPriceValue;
		var itemAmountValue = parseFloat($parent.find('.itemAmount').val());
		itemAmountValue = isNaN(itemAmountValue) ? 0 : itemAmountValue;
		
		var itemSumValue = itemPriceValue * itemAmountValue;
		$parent.find('.itemSum').text(itemSumValue.toFixed(2));
		$parent.find('input[name=itemSum]').val(itemSumValue.toFixed(2));
		
		sumTotal();
	});
	
	$tr.find('.input_money').change(formatMoney);
	
}

function sumTotal () {
	var total = 0;
	$('.itemAmount').each(function () {
		var price = parseFloat($(this).parents('tr').find('.itemPrice').val());
		price = isNaN(price) ? 0 : price;
		var amount = parseInt($(this).val());
		amount = isNaN(amount) ? 0 : amount;
		total += price * amount;
		
	});
	
	$('#feeSumDisplay').text(total.toFixed(2));
	$('#feeSum').val(total);
	
	feeRemain();
	
}

function feeRemain() {
	var feePrepayCash = parseFloat($('#feePrepayCash').val());
	feePrepayCash = isNaN(feePrepayCash) ? 0 : feePrepayCash;
	var feePrepayCard = parseFloat($('#feePrepayCard').val());
	feePrepayCard = isNaN(feePrepayCard) ? 0 : feePrepayCard;
	
	var total = $('#feeSum').val();
	var remain = total - feePrepayCash - feePrepayCard;
	
	$('#feeRemainDisplay').text(remain.toFixed(2));
	$('#feeRemain').val(remain); 
	
}
</script>
<security:securityUser var="user"/>
<div class="title_box">
	<h2>开据销售单</h2>
	<div class="sys_btnBox">
		<input type="button" id="submitBtn" value="保存" /> <input id="returnBtn" type="button" value="退出" />
		<script>
			$('#submitBtn').click(function() { 
				var hasError = false;
				$('.itemName').each(function() {
					var $parent = $(this).parents('tr');
					var cateIdValue = $parent.find('.cateId').val();
					var itemAmountValue = $parent.find('.itemAmount').val();
					var itemPriceValue = $parent.find('.itemPrice').val();
					var itemNameValue = $parent.find('.itemName').val();
					if (itemNameValue != '') {
						if (cateIdValue == '' || isNaN(itemAmountValue) || parseInt(itemAmountValue) == 0 || isNaN(itemPriceValue) || parseFloat(itemPriceValue) == 0) {
							$parent.find('td').css('background-color', '#FF6600');
							hasError = true;
						}
						else {
							$parent.find('td').css('background-color', '#FFFFFF');
						}
					}
				});

				var feeSum = parseFloat($('#feeSum').val());
				var feePrepayCash = parseFloat($('#feePrepayCash').val());
				feePrepayCash = isNaN(feePrepayCash) ? 0 : feePrepayCash;
				var feePrepayCard = parseFloat($('#feePrepayCard').val());
				feePrepayCard = isNaN(feePrepayCard) ? 0 : feePrepayCard;
				var feePrepay = feePrepayCash + feePrepayCard;
				var feeRemain = feeSum - feePrepay; 
				
				var msg = '总金额：¥ ' + feeSum + ' 预付金额：¥ ' + feePrepay + ' 剩余尾款：¥ ' + feeRemain + '\n\n' + '确定要保存此单据吗？'
				
				if (!hasError && confirm(msg)) {
					$('#busiSalesForm').submit();
				}				 
			});
			$('#returnBtn').click(function() { window.location = '${pageContext.request.contextPath}/sales'; });
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
<form:form modelAttribute="form" id="busiSalesForm">
<form:hidden path="busiSales.busiClient.clientId" id="clientId"/>
<form:hidden path="busiSales.salesCode" value="${salesCode}"/>
<form:hidden path="busiSales.salesTypeKey" value="${param.salesType}"/>
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
					<td><form:input path="busiSales.busiClient.clientName" cssClass="wb90 input_text" id="clientName"/></td>
					<th>物业地址</th>
					<td colspan="5"><form:input path="busiSales.busiClient.address" cssClass="wb95 input_text" id="address"/></td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td><form:input path="busiSales.busiClient.areacode" cssClass="w_40 input_text" id="areacode" /> - <form:input path="busiSales.busiClient.phone" cssClass="w_70 input_text" id="phone" /></td>
					<th>联系手机</th>
					<td><form:input path="busiSales.busiClient.cellPhone" cssClass="wb90 input_text" id="cellPhone"/></td>
					<th>出单部门</th>
					<td>${user.dept.deptName }</td>
					<th>单据经手</th>
					<td>${user.realName }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td>${salesCode }</td>
					<th>相关备注</th>
					<td colspan="5"><form:input path="busiSales.salesRemarks" cssClass="wb95 input_text" /></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>商品信息<a href="#this" class="add_tr" id="addSalesItems">添加商品信息行</a><a href="#this" class="toggle_table">折叠</a></h3>
		<script>
			$('#addSalesItems').click(function() {
				addSaleItems($('#items tbody'));
			});
		</script>
		<table id="items" width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="50" />
				<col width="400" />
				<col width="50" />
				<col width="80" />
				<col width="120" />
				<col width="120" />
				<col width="200" />
				<col width="100" />
			</colgroup>
			<thead>
				<tr>
					<th>系列</th>
					<th>名称/货号/型号</th>
					<th>单位</th>
					<th>数量</th>
					<th>单价</th>
					<th>合计</th>
					<th>信息备注</th>
					<th>库存</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<script>
			for (var i = 0; i < 5; i++) {
				addSaleItems($('#items tbody'));
			}
		</script>
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
					<td>
						<c:forEach items="${serv_logis}" var="entry" varStatus="status">
							<input type="radio" class="servLogisKey radio"  name="busiSales.servLogisKey" value="${entry.dictKey}" <c:if test="${status.index == 0 }">checked="checked"</c:if> />${entry.dictValue0}
						</c:forEach>
					</td>
					<th>取送方式</th>
					<td>
						<c:forEach items="${serv_getmethod}" var="entry" varStatus="status">
							<input type="radio" class="servGetmethodKey radio" name="busiSales.servGetmethodKey" value="${entry.dictKey}" <c:if test="${status.index == 0 }">checked="checked"</c:if>/>${entry.dictValue0}
						</c:forEach>
					</td>
					<th>安装方式</th>
					<td>
						<c:forEach items="${serv_installmethod}" var="entry" varStatus="status">
							<input type="radio" class="servInstallmethodKey radio" name="busiSales.servInstallmethodKey" value="${entry.dictKey}" <c:if test="${status.index == 0 }">checked="checked"</c:if>/>${entry.dictValue0}
						</c:forEach>
					</td>
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
			</colgroup>
			<tbody>
				<tr>
					<th>总金额</th>
					<td><span class="money" >¥ <span id="feeSumDisplay">0.00</span></span></td>
					<form:hidden path="busiSales.feeSum" id="feeSum" />
					<th>预付金额</th> 
					<td><input type="checkbox" id="checkCash" /> 现金 ¥ <form:input cssClass="input_money" path="busiSales.feePrepayCash" id="feePrepayCash" disabled="true" value="0.00"/>  <input type="checkbox" id="checkCard" /> 刷卡 ¥ <form:input cssClass="input_money" path="busiSales.feePrepayCard" id="feePrepayCard" disabled="true" value="0.00"/></td>
					<script>
						$('#checkCash').click(function() {
							if ($(this).is(':checked')) { 
								$('#feePrepayCash').attr('disabled', false);
							} else {
								$('#feePrepayCash').attr('disabled', true); 
								$('#feePrepayCash').val('0.00');
							}
							feeRemain();
						});
						$('#checkCard').click(function() {
							if ($(this).is(':checked')) {
								$('#feePrepayCard').attr('disabled', false);
							} else {
								$('#feePrepayCard').attr('disabled', true);
								$('#feePrepayCard').val('0.00');
							}
							feeRemain();
						});
						
						$('#feePrepayCash, #feePrepayCard').keyup(feeRemain);
					</script>
					<th>剩余尾款</th>
					<td><span class="money" > ¥ <span id="feeRemainDisplay">0.00</span></span></td>
					<form:hidden path="busiSales.feeRemain" id="feeRemain" />
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
					<td><form:textarea path="busiSales.otherRemarks" cssClass="textarea" cols="" rows="" /></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>本单附带合同条款编辑部分<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<td><form:textarea path="busiSales.salesContract" cssClass="textarea" cols="" rows="" /></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
</div>
</form:form>

<div id="busiCategorySelector">

	<c:forEach items="${busiCategoryListMap}" var="entry">
		<h3 style="border-bottom: 1px solid #f0f0f0; color: #FF6600;"><dict:lookupDictValue key="${entry.key }" type="item_type" /> </h3>
		<ul style="margin-bottom: 10px;">
			<c:forEach items="${entry.value}" var="busiCategory">
			<li><a href="javascript: void(0)" onclick="selectCategory('${busiCategory.cateId }', '${busiCategory.cateName }')">${busiCategory.cateName }</a></li>
			</c:forEach>
		</ul>
		<br clear="all" />	
	</c:forEach>
	
</div>

<script>
	$('#busiCategorySelector').dialog({'autoOpen': false, 'modal': true, 'width': 600, 
		buttons: {"关闭": function() {$('#busiCategorySelector').dialog('close');  }},
		title: '选择商品系列'
	});
	
	function selectCategory(cateId, cateName) {
		$selectCateId.val(cateId); 
		$selectCateIdDisplay.val(cateName);
		$('#busiCategorySelector').dialog('close');
	}
	
</script>
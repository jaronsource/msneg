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
	var $td2 = $('<td><span class="itemType">' + value.itemType + '</span></td>');
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
<form:form modelAttribute="busiSalesWorking" id="busiSalesWorkingForm" method="post">
<input type="hidden" name="busiSales.salesId" id="salesId" />
<div class="title_box">
	<h2>开据工时单</h2>
	<div class="sys_btnBox">
		<input type="button" value="保存" /> <input type="button" value="提交" /> <input type="button" value="预览" /> <input type="button" value="打印" /> <input type="button" value="退出" />
	</div>
</div>
<div class="customer">
	<p>请选择返销关联母单 <input type="text" name="" class="input_text w_172" value="" id="" /> 手工输入母单号 <input type="text" name="" class="input_text w_172" value="" id="" /> 快速查找客户：<input type="text" name="" class="input_text w_172" value="请输入电话号码" id="" /> <input type="button" value="确定" /></p>
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
					<td>于林</td>
					<th>物业地址</th>
					<td colspan="5">松原市江北花园 16栋4楼 407室</td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td>0438 - 99887676</td>
					<th>联系手机</th>
					<td>13898766565</td>
					<th>出单部门</th>
					<td>销售二部</td>
					<th>单据经手</th>
					<td>于林</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td>12N1211B017</td>
					<th>相关备注</th>
					<td colspan="5">XXXXxxXXx</td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>商品信息<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="40" />
				<col width="50" />
				<col width="*" />
				<col width="50" />
				<col width="50" />
				<col width="90" />
				<col width="90" />
				<col width="240" />
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
					<th>返销事由</th>
					<th>信息备注</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" name="" id="" /></td>
					<td>A</td>
					<td>XXx-83736</td>
					<td>卷</td>
					<td>20</td>
					<td><span class="money">￥400</span></td>
					<td><span class="money">300000.00</span></td>
					<td><input type="radio" name="" class="radio01" checked="checked" id="" /> 非常满意 <input type="radio" name="" class="radio01" id="" /> 满意 <input type="radio" name="" class="radio01" id="" /> 不满意</td>
					<td><input type="text" name="input" class="wb95 input_text" id="input" /></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="input4" id="input5" /></td>
					<td>B</td>
					<td>XXx-83736</td>
					<td>卷</td>
					<td>20</td>
					<td><span class="money">￥400</span></td>
					<td><span class="money">300000.00</span></td>
					<td><input type="radio" name="" class="radio02" checked="checked" id="" /> 非常满意 <input type="radio" name="" class="radio02" id="" /> 满意 <input type="radio" name="" class="radio02" id="" /> 不满意</td>
					<td><input type="text" name="input2" class="wb95 input_text" id="input2" /></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="input4" id="input6" /></td>
					<td>C</td>
					<td>XXx-83736</td>
					<td>卷</td>
					<td>20</td>
					<td><span class="money">￥400</span></td>
					<td><span class="money">300000.00</span></td>
					<td><input type="radio" name="" class="radio03" checked="checked" id="" /> 非常满意 <input type="radio" name="" class="radio03" id="" /> 满意 <input type="radio" name="" class="radio03" id="" /> 不满意</td>
					<td><input type="text" name="input3" class="wb95 input_text" id="input3" /></td>
				</tr>
				<tr>
					<td><input type="checkbox" name="input4" id="input7" /></td>
					<td>D</td>
					<td>XXx-83736</td>
					<td>卷</td>
					<td>20</td>
					<td><span class="money">￥400</span></td>
					<td><span class="money">300000.00</span></td>
					<td><input type="radio" name="" class="radio04" checked="checked" id="" /> 非常满意 <input type="radio" name="" class="radio04" id="" /> 满意 <input type="radio" name="" class="radio04" id="" /> 不满意</td>
					<td><input type="text" name="input5" class="wb95 input_text" id="input4" /></td>
				</tr>
				<tr>
					<th colspan="2">其他项目</th>
					<td colspan="3"><input type="text" name="input11" class="wb95 input_text" id="input13" /></td>
					<td><input type="text" name="input8" class="w_50 input_text" id="input10" /></td>
					<td><input type="text" name="input9" class="w_50 input_text" id="input11" /></td>
					<th>项目备注</th>
					<td><input type="text" name="input10" class="wb95 input_text" id="input12" /></td>
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
				<col width="14%" />
				<col width="10%" />
				<col width="40%" />
				<col width="10%" />
				<col width="*" />
			</colgroup>
						<tbody>
							<tr>
								<th>工时总额</th>
								<td><input type="text" name="input7" class="w_50 input_text" id="input9" /></td>
								<th>结算形式</th>
								<td><input type="radio" name="" class="radio05" checked="checked"  />
现金
	<input type="radio" name="" class="radio05"  />
财务挂记
<input type="radio" name="" class="radio05" />
内部抵扣</td>
								<th>安装部门</th>
								<td><input type="text" name="input6" class="wb95 input_text" id="input8" /></td>
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
					<td><textarea name="" class="textarea" cols="" rows=""></textarea></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box--><!--//box-->
</div>
</form:form>   
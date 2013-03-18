<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<dict:loadDictList type="item_type" var="item_type" />
<dict:loadDictList type="serv_logis" var="serv_logis" />
<dict:loadDictList type="serv_getmethod" var="serv_getmethod" />
<dict:loadDictList type="serv_installmethod" var="serv_installmethod" />

<script>
function addSaleItems(element) {
	var $tr = $('<tr></tr>');
	var $td1 = $('<td><select name="itemTypeKey" class="itemTypeKey"></select></td>');
	<c:forEach items="${item_type}" var="entry">
		$('<option value="${entry.dictKey}">${entry.dictValue0}</option>').appendTo($td1.find('select'));
	</c:forEach>
	var $td2 = $('<td><input type="text" name="itemName" class="wb95 input_text" class="itemName" /></td>');
	var $td3 = $('<td><select name="itemUnit" class="itemUnit"></select></td>');
	var $td4 = $('<td><input type="text" name="itemAmount" class="wb50 input_text" class="itemAmount" /></td>');
	var $td5 = $('<td><input type="text" name="itemPrice" class="wb50 input_text" class="itemPrice" /></td>');
	var $td6 = $('<td><span class="money">0.00</span</td>');
	var $td7 = $('<td><input type="text" name="itemRemarks" class="wb95 input_text" class="itemRemarks" /></td>');
	var $td8 = $('<td><span class="green">有货</span></td>');
	
	$tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).append($td8);
	$tr.appendTo(element);
}
</script>
<security:securityUser var="user"/>
<div class="title_box">
	<h2>开据销售单</h2>
	<div class="sys_btnBox">
		<input type="button" value="保存" /> <input type="button" value="提交" /> <input type="button" value="预览" /> <input type="button" value="打印" /> <input type="button" value="退出" />
	</div>
</div>
<div class="customer">
	<p>快速查找客户：<input type="text" name="" class="input_text w_172" value="请输入电话号码" id="" /> <input type="button" value="确定" /></p>
</div>
<form:form modelAttribute="form">
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
					<td><form:input path="busiClient.clientName" cssClass="wb90 input_text" /></td>
					<th>物业地址</th>
					<td colspan="5"><form:input path="busiClient.address" cssClass="wb95 input_text" /></td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td><form:input path="busiClient.areacode" cssClass="w_40 input_text" /> - <form:input path="busiClient.phone" cssClass="w_70 input_text" /></td>
					<th>联系手机</th>
					<td><form:input path="busiClient.cellPhone" cssClass="wb90 input_text" /></td>
					<th>出单部门</th>
					<td>${user.dept.deptName }</td>
					<th>单据经手</th>
					<td>${user.realName }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td>${salesCode }</td>
					<th>相关备注</th>
					<td colspan="5"<form:input path="busiSales.salesRemarks" cssClass="wb95 input_text" /></td>
				</tr>
			</tbody>
		</table>

	</div>
	<!--//box-->
	<!--box-->
	<div class="com_box">
		<h3>商品信息<a href="#this" class="add_tr" id="addSalesItems">添加商品信息行</a><a href="#this" class="toggle_table">折叠</a></h3>
		<table id="items" width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="50" />
				<col width="400" />
				<col width="*" />
				<col width="80" />
				<col width="80" />
				<col width="90" />
				<col width="200" />
				<col width="200" />
			</colgroup>
			<thead>
				<tr>
					<th>类别</th>
					<th>名称/货号/型号</th>
					<th>单位</th>
					<th>数量</th>
					<th>单价</th>
					<th>合计</th>
					<th>信息备注</th>
					<th>系统关联提示</th>
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
						<c:forEach items="${serv_logis}" var="entry" >
							<form:radiobutton cssClass="servLogisKey radio"  path="busiSales.servLogisKey" value="${entry.dictKey}" />${entry.dictValue0}
						</c:forEach>
					</td>
					<th>取送方式</th>
					<td>
						<c:forEach items="${serv_getmethod}" var="entry" >
							<form:radiobutton cssClass="servGetmethodKey radio"  path="busiSales.servGetmethodKey" value="${entry.dictKey}" />${entry.dictValue0}
						</c:forEach>
					</td>
					<th>安装方式</th>
					<td>
						<c:forEach items="${serv_installmethod}" var="entry" >
							<form:radiobutton cssClass="servInstallmethodKey radio"  path="busiSales.servInstallmethodKey" value="${entry.dictKey}" />${entry.dictValue0}
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
					<td><span class="money" id="feeSumDisplay">￥ 0.00</span></td>
					<form:hidden path="busiSales.feeSum" id="feeSum" />
					<th>预付金额</th>
					<td><input type="checkbox" id="checkCash" /> 现金 ￥ <form:input cssClass="input_money" path="busiSales.feePrepayCash" id="feePrepayCash" disabled="disabled"/>  <input type="checkbox" id="checkMoney" /> 刷卡 ￥ <form:input cssClass="input_money" path="busiSales.feePrepayCard" id="feePrepayCard" disabled="disabled"/></td>
					<script>
						$('#checkCash').click(function() {
							if ($(this).attr('checked') == true) {
								$('#feePrepayCash').attr('disabled', false);
							} else {
								$('#feePrepayCash').attr('disabled', true);
							}
						});
						$('#feeCard').click(function() {
							if ($(this).attr('checked') == true) {
								$('#feePrepayCard').attr('disabled', false);
							} else {
								$('#feePrepayCard').attr('disabled', true);
							}
						});
					</script>
					<th>剩余尾款</th>
					<td><span class="money" id="feeRemainDisplay">￥ 0.00</span></td>
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
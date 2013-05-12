<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<dict:loadDictList type="clear_method" var="clear_method" />
<security:securityUser var="user" />
<script>


</script>
<form:form modelAttribute="busiSalesMakeup" id="busiSalesMakeupForm" method="post">
<input type="hidden" name="busiSales.salesId" id="salesId" />
<div class="title_box">
	<h2>开据补价单</h2>
	<div class="sys_btnBox">
		<input type="button" value="保存" id="submitBtn" /> <input type="button" value="退出" id="returnBtn" />
		<script>
			$('#submitBtn').click(function() {
				var makeupSum = $('#makeupSum').val();
				var msg = '补价总额：¥ ' + makeupSum + '\n\n' + '确定要保存此单据吗？';
				if (confirm(msg)) {
					$('#busiSalesMakeupForm').submit();
				} 
			});
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
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="40" />
				<col width="*" />
				<col width="30%" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="2">补价信息部分</th>
					<th>补价信息备注</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>增<br />
					加<br />
					补<br />
					价</th>
					<td>
						<ul class="check_list">
							<li><input type="checkbox" name="addItem1" id="addItem1" value="1" />新增临时性损耗费用</li>
							<li><input type="checkbox" name="addItem2" id="addItem2" value="1" />增值服务取费</li>
							<li><input type="checkbox" name="addItem3" id="addItem3" value="1" />上衣托管安装（含多施工费用）</li>
							<li><input type="checkbox" name="addItem4" id="addItem4" value="1" />变更议价补价</li>
							<li><input type="checkbox" name="addItem5" id="addItem5" value="1" />新增运输及商品管理费用</li>
							<li><input type="checkbox" name="addItem6" id="addItem6" value="1" />其他商议费用</li>
						</ul>
					</td>
					<td rowspan="2"><textarea name="makeupRemarks" style="height:200px" class="textarea" cols="" rows=""></textarea></td>
				</tr>
				<tr>
					<th>减<br />
					少<br />
					补<br />
					价</th>
					<td><ul class="check_list">
							<li><input type="checkbox" name="minusItem1" id="minusItem1" value="1" />
							递减临时性损耗费用</li>
							<li><input type="checkbox" name="minusItem2" id="minusItem2" value="1" />
							补退议价差额</li>
							<li><input type="checkbox" name="minusItem3" id="minusItem3" value="1" />
							递减托管安装（含少施工费用）</li>
							<li><input type="checkbox" name="minusItem4" id="minusItem4" value="1" />
							遇零取整差价</li>
							<li><input type="checkbox" name="minusItem5" id="minusItem5" value="1" /> 
							商品瑕疵/破损议价差额</li>
							<li><input type="checkbox" name="minusItem6" id="minusItem6" value="1" /> 
							其他商议费用</li>
						</ul></td>
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
								<th>补价总额</th>
								<td>¥ <input type="text" name="makeupSum" class="w_50 input_text input_money" id="makeupSum" value="0.00" /></td> 
								<th>结算形式</th>
								<td><c:forEach items="${clear_method}" var="entry" varStatus="status">
										<input type="radio" class="clearMethodKey radio" name="clearMethodKey" value="${entry.dictKey}" <c:if test="${status.index == 0 }">checked="checked"</c:if>/>${entry.dictValue0}
									</c:forEach>
								<th>经手人</th>
								<td>${user.realName }</td>
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
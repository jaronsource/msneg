<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="utils" uri="http://www.ccesun.com/tags/utils" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<style type="text/css">
.invalid {
text-decoration: line-through; color: red;
}
</style>
<script type="text/javascript">
$(function() {
    $( "#tabs" ).tabs();
});
</script>
<div class="title_box">
	<h2>销售单据查看</h2>
	<div class="sys_btnBox">
		<input type="button" value="打印" id="printBtn"/>
		<input type="button" value="退出" />
		<script>
			$('#printBtn').click(function () {
				var url = $('.ui-tabs-active').attr('url');
				window.location = url;
			});
		</script>
	</div>
</div>
<div class="order_box"> 
	<!--box-->
	<div class="com_box">
		<h3 class="title_line">客户信息<a href="#this" class="toggle_table">折叠</a></h3>
		<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
			<colgroup>
			<col width="10%">
			<col width="15%"> 
			<col width="10%">
			<col width="15%">
			<col width="10%">
			<col width="15%">
			<col width="10%">
			<col width="15%">
			</colgroup>
			<tbody>
				<tr>
					<th>客户名称</th>
					<td>${busiSales.busiClient.clientName }</td>
					<th>物业地址</th>
					<td colspan="5">${busiSales.busiClient.address }</td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td>${busiSales.busiClient.areacode } - ${busiSales.busiClient.phone }</td>
					<th>联系手机</th>
					<td>${busiSales.busiClient.cellPhone }</td>
					<th>出单部门</th>
					<td>${busiSales.sysDept.deptName }</td>
					<th>单据经手</th>
					<td>${busiSales.sysUser.userName }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td class="money">${busiSales.salesCode }</td>
					<th>相关备注</th>
					<td colspan="5">${busiSales.salesRemarks }</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!--//box-->
	<div id="tabs">
		<ul>
			<li url="${pageContext.request.contextPath }/busiSales/${busiSales.salesId}/print"><a href="#tabs-1" <c:if test="${busiSales.billStateKey == 'B' }">class="invalid"</c:if>>销售单</a></li>
			<c:forEach items="${busiSalesClearList }" var="entry" varStatus="status">
				<li url="${pageContext.request.contextPath }/busiSalesClear/${entry.clearId}/print"><a href="#clear-${status.index }" <c:if test="${entry.billStateKey == 'B' }">class="invalid"</c:if>>结算单</a></li>	
			</c:forEach>
			<c:forEach items="${busiSalesMakeupList }" var="entry" varStatus="status">
				<li url="${pageContext.request.contextPath }/busiSalesMakeup/${entry.makeupId}/print"><a href="#makeup-${status.index }" <c:if test="${entry.billStateKey == 'B' }">class="invalid"</c:if>>补价单</a></li>	
			</c:forEach>
			<c:forEach items="${busiSalesReturnList }" var="entry" varStatus="status">
				<li url="${pageContext.request.contextPath }/busiSalesReturn/${entry.returnId}/print"><a href="#return-${status.index }" <c:if test="${entry.billStateKey == 'B' }">class="invalid"</c:if>>返销单</a></li>	
			</c:forEach>
		</ul>
		<div id="tabs-1" > 
			<!--box-->
			<div class="com_box">
				<h3>商品信息
					<security:hasPerm permCode="10">
						<a class="invalidBillLink" href="${pageContext.request.contextPath }/busiBills/invalidBill?type=busiSales&id=${busiSales.salesId}">[标记作废]</a>
					</security:hasPerm>
					<a class="toggle_table" href="#this">折叠</a></h3>
				<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
					<colgroup>
					<col width="150">
					<col width="*">
					<col width="50">
					<col width="50">
					<col width="80">
					<col width="80">
					<col width="*">
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
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${busiSalesItemList }" var="entry">
						<tr>
							<td>${entry.busiCategory.cateName }</td>
							<td>${entry.itemName }</td>
							<td><dict:lookupDictValue key="${entry.itemUnitKey }" type="item_unit" /></td>
							<td>${entry.itemAmount }</td>
							<td><span class="money">${entry.itemPrice }</span></td>
							<td><span class="money">${entry.itemSum }</span></td>
							<td>${entry.itemRemarks }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!--//box--> 
			<!--box-->
			<div class="com_box">
				<h3>安装/取送/服务部分<a href="#this" class="toggle_table">折叠</a></h3>
				<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
					<colgroup>
					<col width="10%">
					<col width="15%">
					<col width="10%">
					<col width="23%">
					<col width="10%">
					<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>物流信息</th>
							<td><dict:lookupDictValue key="${busiSales.servLogisKey }" type="serv_logis" /> </td>
							<th>取送方式</th>
							<td><dict:lookupDictValue key="${busiSales.servGetmethodKey }" type="serv_getmethod" /></td>
							<th>安装方式</th>
							<td><dict:lookupDictValue key="${busiSales.servInstallmethodKey }" type="serv_installmethod" /></td>
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
							<td><span class="money">${busiSales.feeSum}</span></td>
							<th>预付金额</th>
							<td> 现金 <span class="money">${busiSales.feePrepayCash}</span> 刷卡 <span class="money">${busiSales.feePrepayCard}</span></td>
							<th>剩余尾款</th>
							<td><span class="money">${busiSales.feeRemain}</span></td>
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
							<td>${busiSales.otherRemarks}</td>
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
							<td>${busiSales.salesContract}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//box--> 
		</div>
		<c:forEach items="${busiSalesClearList}" var="entry" varStatus="status">
		<div id="clear-${status.index }"> 
			<!--box-->
			<div class="com_box">
				<h3>商品信息
				<security:hasPerm permCode="10">
					<a class="invalidBillLink" href="${pageContext.request.contextPath }/busiBills/invalidBill?type=busiSalesClear&id=${entry.clearId}">[标记作废]</a>
				</security:hasPerm>
				<a href="#this" class="toggle_table">折叠</a></h3>
				<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
					<colgroup>
					<col width="150" />
					<col width="*" />
					<col width="50" />
					<col width="50" />
					<col width="80" />
					<col width="80" />
					<col width="*" />
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
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${busiSalesItemList }" var="salesItem">
						<tr>
							<td>${salesItem.busiCategory.cateName }</td>
							<td>${salesItem.itemName }</td>
							<td><dict:lookupDictValue key="${salesItem.itemUnitKey }" type="item_unit" /></td>
							<td>${salesItem.itemAmount }</td>
							<td><span class="money">${salesItem.itemPrice }</span></td>
							<td><span class="money">${salesItem.itemSum }</span></td>
							<td>${salesItem.itemRemarks }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!--//box--> 
			<!--box--><!--//box--> 
			
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
							<td><dict:lookupDictValue key="${entry.busiSales.servLogisKey }" type="serv_logis" /> </td>
							<th>取送方式</th>
							<td><dict:lookupDictValue key="${entry.busiSales.servGetmethodKey }" type="serv_getmethod" /></td>
							<th>安装方式</th>
							<td><dict:lookupDictValue key="${entry.busiSales.servInstallmethodKey }" type="serv_installmethod" /></td>
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
							<td><span class="money">${entry.busiSales.feeSum}</span></td>
							<th>预付金额</th>
							<td> 现金 <span class="money">${entry.busiSales.feePrepayCash}</span> 刷卡 <span class="money">${entry.busiSales.feePrepayCard}</span></td>
							<th>剩余尾款</th>
							<td><span class="money">${entry.busiSales.feeRemain}</span></td>
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
							<td>${busiSales.otherRemarks}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//box--> 
		</div>
		</c:forEach>
		
		<c:forEach items="${busiSalesMakeupList}" var="entry" varStatus="status">
		<div id="makeup-${status.index }"> 
			<!--box-->
			<div class="com_box">
				<h3>商品信息
				<security:hasPerm permCode="10">
					<a class="invalidBillLink" href="${pageContext.request.contextPath }/busiBills/invalidBill?type=busiSalesMakeup&id=${entry.makeupId}">[标记作废]</a>
				</security:hasPerm>
				
				<a class="toggle_table" href="#this">折叠</a></h3>
				<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
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
							<td><ul class="check_list">
									<ul class="check_list">
										<li><input type="checkbox" name="addItem1" id="addItem1" value="1" <c:if test="${entry.addItem1 == 1 }">checked="checked"</c:if> />新增临时性损耗费用</li>
										<li><input type="checkbox" name="addItem2" id="addItem2" value="1" <c:if test="${entry.addItem1 == 2 }">checked="checked"</c:if> />增值服务取费</li>
										<li><input type="checkbox" name="addItem3" id="addItem3" value="1" <c:if test="${entry.addItem1 == 3 }">checked="checked"</c:if> />上衣托管安装（含多施工费用）</li>
										<li><input type="checkbox" name="addItem4" id="addItem4" value="1" <c:if test="${entry.addItem1 == 4 }">checked="checked"</c:if> />变更议价补价</li>
										<li><input type="checkbox" name="addItem5" id="addItem5" value="1" <c:if test="${entry.addItem1 == 5 }">checked="checked"</c:if> />新增运输及商品管理费用</li>
										<li><input type="checkbox" name="addItem6" id="addItem6" value="1" <c:if test="${entry.addItem1 == 6 }">checked="checked"</c:if> />其他商议费用</li>
									</ul>
								</ul></td>
							<td rowspan="2">${entry.makeupRemarks }</td>
						</tr>
						<tr>
							<th>减<br />
								少<br />
								补<br />
								价</th>
							<td><ul class="check_list">
							<li><input type="checkbox" name="minusItem1" id="minusItem1" value="1" <c:if test="${entry.minusItem1 == 1 }">checked="checked"</c:if>/>
							递减临时性损耗费用</li>
							<li><input type="checkbox" name="minusItem2" id="minusItem2" value="1" <c:if test="${entry.minusItem2 == 1 }">checked="checked"</c:if>/>
							补退议价差额</li>
							<li><input type="checkbox" name="minusItem3" id="minusItem3" value="1" <c:if test="${entry.minusItem3 == 1 }">checked="checked"</c:if>/>
							递减托管安装（含少施工费用）</li>
							<li><input type="checkbox" name="minusItem4" id="minusItem4" value="1" <c:if test="${entry.minusItem4 == 1 }">checked="checked"</c:if>/>
							遇零取整差价</li>
							<li><input type="checkbox" name="minusItem5" id="minusItem5" value="1" <c:if test="${entry.minusItem5 == 1 }">checked="checked"</c:if>/> 
							商品瑕疵/破损议价差额</li>
							<li><input type="checkbox" name="minusItem6" id="minusItem6" value="1" <c:if test="${entry.minusItem6 == 1 }">checked="checked"</c:if>/> 
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
				<h3>财务结算部分<a class="toggle_table" href="#this">折叠</a></h3>
				<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
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
							<td>${entry.makeupSum }</td>
							<th>结算形式</th>
							<td><dict:lookupDictValue key="${entry.clearMethodKey }" type="clear_method" /></td>
							<th>经手人</th>
							<td>${entry.sysUser.userName }</td>
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
							<td>${entry.otherRemarks }</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//box--> 
		</div>
		</c:forEach>
		
		<c:forEach items="${busiSalesReturnList}" var="entry" varStatus="status">
		<div id="return-${status.index }"> 
			<!--box-->
			
			<utils:methodInvokor methodName="findBusiSalesReturnItemByReturnId" var="salesReturnItemList" className="org.jaronsource.msneg.service.BusiSalesReturnItemService">
				<utils:miParam type="java.lang.Integer" value="${entry.returnId }" />
			</utils:methodInvokor>
			
			<div class="com_box">
				<h3>商品信息
				<security:hasPerm permCode="10">
					<a class="invalidBillLink" href="${pageContext.request.contextPath }/busiBills/invalidBill?type=busiSalesReturn&id=${entry.returnId}">[标记作废]</a>
				</security:hasPerm>
				<a href="#this" class="toggle_table">折叠</a></h3>
				<table width="100%" border="1" class="tbl_w" cellspacing="0" cellpadding="0">
					<colgroup>
					<col width="150" />
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
						<c:forEach items="${salesReturnItemList}" var="salesReturnItem">
						<tr>
							<td>${salesReturnItem.busiSalesItem.busiCategory.cateName }</td>
							<td>${salesReturnItem.busiSalesItem.itemName }</td>
							<td><dict:lookupDictValue key="${salesReturnItem.busiSalesItem.itemUnitKey }" type="item_unit" /></td>
							<td>${salesReturnItem.busiSalesItem.itemAmount }</td>
							<td>${salesReturnItem.returnAmount }</td>
							<td><span class="money">${salesReturnItem.busiSalesItem.itemPrice }</span></td>
							<td><span class="money">${salesReturnItem.returnPrice }</span></td>
							<td><span class="money">${salesReturnItem.returnSum }</span></td>
							<td><dict:lookupDictValue key="${salesRenturnItem.returnReasonKey }" type="return_reason" /></td>
							<td>${salesReturnItem.busiSalesItem.itemRemarks}</td>
						</tr>
						</c:forEach>
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
							<td><span class="money">${entry.returnSum }</span></td>
							<th>返销报损</th>
							<td>${entry.returnLoss }</td>
							<th>折扣报损</th>
							<td>${entry.rerateLoss }</td>
							<th>其他备注</th>
							<td>${entry.returnRemarks }</td>
						</tr>
						<tr>
							<th>实返金额</th>
							<td><span class="money">${entry.actReturnSum }</span></td>
							<th>结算形式</th>
							<td colspan="3"><dict:lookupDictValue key="${entry.clearMethodKey }" type="clear_method" /></td>
							<th>经手人</th>
							<td>${entry.sysUser.userName }</td>
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
							<td>${entry.otherRemarks }</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//box--> 
		</div>
		</c:forEach>
	</div>
</div>
<script type="text/javascript">
	$('.invalidBillLink').click(function(event) {
		event.preventDefault();
		$.post($(this).attr('href'), function() {
			alert('成功废除此单据！');
		});
	});
</script>

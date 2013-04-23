<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="utils" uri="http://www.ccesun.com/tags/utils" %>
<div class="title_box">
	<h2>销售单据查看</h2>
	<div class="sys_btnBox">
		<input type="button" value="打印" onclick="window.location='print'"/>
		<input type="button" value="退出" onclick="window.location = '${pageContext.request.contextPath}/sales';"/>
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
					<td>${busiSalesReturn.busiSales.busiClient.clientName }</td>
					<th>物业地址</th>
					<td colspan="5">${busiSalesReturn.busiSales.busiClient.address }</td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td>${busiSalesReturn.busiSales.busiClient.areacode } - ${busiSalesReturn.busiSales.busiClient.phone }</td>
					<th>联系手机</th>
					<td>${busiSalesReturn.busiSales.busiClient.cellPhone }</td>
					<th>出单部门</th>
					<td>${busiSalesReturn.busiSales.sysDept.deptName }</td>
					<th>单据经手</th>
					<td>${busiSalesReturn.busiSales.sysUser.userName }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td class="money">${busiSalesReturn.busiSales.salesCode }</td>
					<th>相关备注</th>
					<td colspan="5">${busiSalesReturn.busiSales.salesRemarks }</td>
				</tr>
			</tbody>
		</table>
	</div>
	
			<div class="com_box">
				<h3>商品信息<a href="#this" class="toggle_table">折叠</a></h3>
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
							<td><span class="money">${busiSalesReturn.returnSum }</span></td>
							<th>返销报损</th>
							<td>${busiSalesReturn.returnLoss }</td>
							<th>折扣报损</th>
							<td>${busiSalesReturn.rerateLoss }</td>
							<th>其他备注</th>
							<td>${busiSalesReturn.returnRemarks }</td>
						</tr>
						<tr>
							<th>实返金额</th>
							<td><span class="money">${busiSalesReturn.actReturnSum }</span></td>
							<th>结算形式</th>
							<td colspan="3"><dict:lookupDictValue key="${busiSalesReturn.clearMethodKey }" type="clear_method" /></td>
							<th>经手人</th>
							<td>${busiSalesReturn.sysUser.userName }</td>
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
							<td>${busiSalesReturn.otherRemarks }</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//box--> 
</div>
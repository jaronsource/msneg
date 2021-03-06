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
		<input type="button" value="打印" onclick="window.location='print';"/>
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
					<td>${busiSalesClear.busiSales.busiClient.clientName }</td>
					<th>物业地址</th>
					<td colspan="5">${busiSalesClear.busiSales.busiClient.address }</td>
				</tr>
				<tr>
					<th>联系手机</th>
					<td>${busiSalesClear.busiSales.busiClient.cellPhone }</td>
					<th>联系电话</th>
					<td>${busiSalesClear.busiSales.busiClient.areacode } - ${busiSalesClear.busiSales.busiClient.phone }</td>
					<th>出单部门</th>
					<td>${busiSalesClear.busiSales.sysDept.deptName }</td>
					<th>单据经手</th>
					<td>${busiSalesClear.busiSales.handleUser }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td class="money">${busiSalesClear.busiSales.salesCode }</td>
					<th>相关备注</th>
					<td colspan="5">${busiSalesClear.busiSales.salesRemarks }</td>
				</tr>
			</tbody>
		</table>
	</div>
	
			<!--box-->
			<div class="com_box">
				<h3>商品信息<a href="#this" class="toggle_table">折叠</a></h3>
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
							<td>${salesItem.cateName }</td>
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
							<td><dict:lookupDictValue key="${busiSalesClear.busiSales.servLogisKey }" type="serv_logis" /> </td>
							<th>取送方式</th>
							<td><dict:lookupDictValue key="${busiSalesClear.busiSales.servGetmethodKey }" type="serv_getmethod" /></td>
							<th>安装方式</th>
							<td><dict:lookupDictValue key="${busiSalesClear.busiSales.servInstallmethodKey }" type="serv_installmethod" /></td>
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
							<td>¥ <span class="money">${busiSalesClear.busiSales.feeSum}</span></td>
							<th>预付金额</th>
							<td> 现金  ¥ <span class="money">${busiSalesClear.busiSales.feePrepayCash}</span> 刷卡 ¥ <span class="money">${busiSalesClear.busiSales.feePrepayCard}</span></td>
							<th>剩余尾款</th>
							<td>¥ <span class="money">${busiSalesClear.busiSales.feeRemain}</span></td>
						</tr>
						<tr>
							<%--<th>结算金额</th>
							<td><span class="money">${busiSalesClear.clearSum}</span></td> --%>
							<th>结算形式</th>
							<td colspan="5">
								<dict:lookupDictValue key="${busiSalesClear.clearMethodKey }" type="clear_method" />
							</td>
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
							<td>${busiSalesClear.busiSales.otherRemarks}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//box--> 
		</div>
		
</div>
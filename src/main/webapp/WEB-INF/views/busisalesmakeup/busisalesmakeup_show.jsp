<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<%@ taglib prefix="utils" uri="http://www.ccesun.com/tags/utils" %>
<div class="title_box">
	<h2>查看补价单</h2>
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
					<td>${busiSalesMakeup.busiSales.busiClient.clientName }</td>
					<th>物业地址</th>
					<td colspan="5">${busiSalesMakeup.busiSales.busiClient.address }</td>
				</tr>
				<tr>
					<th>联系电话</th>
					<td>${busiSalesMakeup.busiSales.busiClient.areacode } - ${busiSalesMakeup.busiSales.busiClient.phone }</td>
					<th>联系手机</th>
					<td>${busiSalesMakeup.busiSales.busiClient.cellPhone }</td>
					<th>出单部门</th>
					<td>${busiSalesMakeup.busiSales.sysDept.deptName }</td>
					<th>单据经手</th>
					<td>${busiSalesMakeup.busiSales.sysUser.userName }</td>
				</tr>
				<tr>
					<th>单据编号</th>
					<td class="money">${busiSalesMakeup.busiSales.salesCode }</td>
					<th>相关备注</th>
					<td colspan="5">${busiSalesMakeup.busiSales.salesRemarks }</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!--//box-->
		
			<!--box-->
			<div class="com_box">
				<h3>商品信息<a class="toggle_table" href="#this">折叠</a></h3>
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
										<li><input type="checkbox" name="addItem1" id="addItem1" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.addItem1 == 1 }">checked="checked"</c:if> />新增临时性损耗费用</li>
										<li><input type="checkbox" name="addItem2" id="addItem2" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.addItem1 == 2 }">checked="checked"</c:if> />增值服务取费</li>
										<li><input type="checkbox" name="addItem3" id="addItem3" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.addItem1 == 3 }">checked="checked"</c:if> />上衣托管安装（含多施工费用）</li>
										<li><input type="checkbox" name="addItem4" id="addItem4" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.addItem1 == 4 }">checked="checked"</c:if> />变更议价补价</li>
										<li><input type="checkbox" name="addItem5" id="addItem5" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.addItem1 == 5 }">checked="checked"</c:if> />新增运输及商品管理费用</li>
										<li><input type="checkbox" name="addItem6" id="addItem6" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.addItem1 == 6 }">checked="checked"</c:if> />其他商议费用</li>
									</ul>
								</ul></td>
							<td rowspan="2">${busiSalesMakeup.makeupRemarks }</td>
						</tr>
						<tr>
							<th>减<br />
								少<br />
								补<br />
								价</th>
							<td><ul class="check_list">
							<li><input type="checkbox" name="minusItem1" id="minusItem1" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.minusItem1 == 1 }">checked="checked"</c:if>/>
							递减临时性损耗费用</li>
							<li><input type="checkbox" name="minusItem2" id="minusItem2" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.minusItem2 == 1 }">checked="checked"</c:if>/>
							补退议价差额</li>
							<li><input type="checkbox" name="minusItem3" id="minusItem3" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.minusItem3 == 1 }">checked="checked"</c:if>/>
							递减托管安装（含少施工费用）</li>
							<li><input type="checkbox" name="minusItem4" id="minusItem4" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.minusItem4 == 1 }">checked="checked"</c:if>/>
							遇零取整差价</li>
							<li><input type="checkbox" name="minusItem5" id="minusItem5" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.minusItem5 == 1 }">checked="checked"</c:if>/> 
							商品瑕疵/破损议价差额</li>
							<li><input type="checkbox" name="minusItem6" id="minusItem6" disabled="disabled" value="1" <c:if test="${busiSalesMakeup.minusItem6 == 1 }">checked="checked"</c:if>/> 
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
							<td>${busiSalesMakeup.makeupSum }</td>
							<th>结算形式</th>
							<td><dict:lookupDictValue key="${busiSalesMakeup.clearMethodKey }" type="clear_method" /></td>
							<th>经手人</th>
							<td>${busiSalesMakeup.sysUser.userName }</td>
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
							<td>${busiSalesMakeup.otherRemarks }</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!--//box--> 
		
		
</div>
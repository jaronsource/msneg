<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>

<dict:loadDictList var="item_type" type="item_type"></dict:loadDictList>
<dict:loadDictList var="item_unit" type="item_unit"></dict:loadDictList>
<dict:loadDictList var="stock_reason" type="stock_reason"></dict:loadDictList>
<security:securityUser var="user"/>

	
	<div class="customer">
	<form:form modelAttribute="busiCategory">
	<form:hidden path="itemStockAmount"/>
	<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
		<colgroup>
			<col width="140">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th>类型</th>
				<td>
					<form:select path="itemTypeKey" >
						<form:options items="${item_type }" itemLabel="dictValue0" itemValue="dictKey" />
					</form:select>
				</td>
			</tr>
			<tr>
				<th>系列</th>
				<td><form:input path="cateName" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>货号</th>
				<td><form:input path="itemName" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>批次</th>
				<td><form:input path="assignNum" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>单位</th>
				<td>
					<form:select path="itemUnitKey">
						<form:options items="${item_unit }" itemLabel="dictValue0" itemValue="dictKey"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>入库时间</th>
				<td><form:input path="createTime" cssClass="input_text input_date"/></td>
			</tr>
			<tr>
				<th>入库原因</th>
				<td>
					<form:select path="stockReasonKey">
						<form:options items="${stock_reason }" itemLabel="dictValue0" itemValue="dictKey"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<th>库号</th>
				<td><form:input path="kuNum" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>录入人</th>
				<td><form:input path="inputUser" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>商品描述</th>
				<td><form:input path="itemRemarks" cssClass="input_text wb90"/></td>
			</tr>
			<tr>
				<th>备注</th>
				<td><form:input path="remarks" cssClass="input_text wb90"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/busiStock';" /> </td>
			</tr>
		</tbody>
	</table>
	</form:form>
	</div>

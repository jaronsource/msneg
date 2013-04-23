<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="title_box">
	<h2>客户信息编辑 </h2>
</div>
<form:form modelAttribute="busiClient">
<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
	<colgroup>
		<col width="140">
		<col width="*">
	</colgroup>
	<tbody>
		<tr>
			<th>客户名称</th>
			<td><form:input path="clientName" cssClass="input_text"/></td>
		</tr>
		<tr>
			<th>电话</th>
			<td><form:input path="areacode" cssClass="w_40 input_text" /> - <form:input path="phone" cssClass="input_text"/></td>
		</tr>
		<tr>
			<th>手机</th>
			<td><form:input path="cellPhone" cssClass="input_text"/></td>
		</tr>
		<tr>
			<th>地址</th>
			<td><form:input path="address" cssClass="input_text"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/busiClient';" /> </td>
		</tr>
	</tbody>
</table>
</form:form>
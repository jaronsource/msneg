<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="title_box">
	<h2>报备信息编辑 </h2>
</div>
<form:form modelAttribute="busiPreord">
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
			<th>客户电话</th>
			<td><form:input path="clientCellphone" cssClass="input_text"/></td>
		</tr>
		<tr>
			<th>客户地址</th>
			<td><form:input path="clientAddress" cssClass="input_text large"/></td>
		</tr>
		<tr>
			<th>报备人姓名</th>
			<td><form:input path="preordPerson" cssClass="input_text"/></td>
		</tr>
		<tr>
			<th>报备人电话</th>
			<td><form:input path="preordPersonPhone" cssClass="input_text"/></td>
		</tr>
		<tr>
			<th>备注</th>
			<td><form:textarea path="remarks" cssClass="textarea"/></td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/busiClient';" /> </td>
		</tr>
	</tbody>
</table>
</form:form>
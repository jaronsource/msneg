<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>

<dict:loadDictList var="item_type" type="item_type"></dict:loadDictList>
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
				<th>名称</th>
				<td><form:input path="cateName" cssClass="input_text"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/busiStock';" /> </td>
			</tr>
		</tbody>
	</table>
	</form:form>
	</div>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="pg" uri="http://www.ccesun.com/tags/pager" %>
<%@ taglib prefix="security" uri="http://www.ccesun.com/tags/security" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>

<dict:loadDictList var="item_unit" type="item_unit"></dict:loadDictList>
<security:securityUser var="user"/>

	
	<div class="customer">
	<form:form modelAttribute="busiItem">
	<form:hidden path="itemStockAmount"/>
	<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
		<colgroup>
			<col width="140">
			<col width="*">
		</colgroup>
		<tbody>
    		<tr>
				<th>系列</th>
				<td>
					<form:select path="busiCategory.cateId" >
    					<form:options items="${categories}" itemLabel="cateName" itemValue="cateId" />
					</form:select>
				</td>
			</tr>
			<tr>
				<th>名称</th>
				<td><form:input path="itemName" cssClass="input_text"/></td>
			</tr>
			<tr>
				<th>单位</th>
				<td>
					<form:select path="itemUnitKey" >
						<form:options items="${item_unit }" itemLabel="dictValue0" itemValue="dictKey" />
					</form:select>
				</td>
			</tr>
			<tr>
				<th>单价</th>
				<td><form:input path="itemPrice" cssClass="input_text"/></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/busiStock';" /> </td>
			</tr>
		</tbody>
	</table>
	</form:form>
	</div>

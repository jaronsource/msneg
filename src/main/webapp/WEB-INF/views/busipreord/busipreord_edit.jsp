<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="dict" uri="http://www.ccesun.com/tags/dict" %>
<dict:loadDictList type="preord_state" var="preord_state" />

<div class="title_box">
	<h2>报备信息编辑 </h2>
</div>
<form:form modelAttribute="busiPreord">
<table width="100%" cellspacing="0" cellpadding="0" border="1" class="tbl_w">
	<colgroup>
	<col width="40">
	<col width="120">
	<col width="*">
	</colgroup>
	<tbody>
		<tr>
			<th rowspan="2">报 备 人 信 息</th>
			<th>姓名/公司</th>
			<td><form:input cssClass="input_text" path="preordPerson" /></td>
		</tr>
		<tr>
			<th>联系方式</th>
			<td><form:input cssClass="input_text" path="preordPersonPhone" /></td>
		</tr>
		<tr>
			<th rowspan="8">报  备  信  息</th>
			<th>姓名</th>
			<td><form:input cssClass="input_text" path="clientName" id="clientCellphone2" /></td>
		</tr>
		<tr>
			<th>物业地址</th>
			<td><form:input cssClass="input_text large" path="clientAddress" id="clientAddress2" /></td>
		</tr>
		<tr>
			<th>联系方式</th>
			<td><form:input cssClass="input_text" path="clientCellphone" id="clientCellphone3" /></td>
		</tr>
		<tr>
			<th>描述</th>
			<td><form:textarea cssClass="textarea" path="remarks" id="remarks"/></td>
		</tr>
		<tr>
			<th>登记</th>
			<td><form:input cssClass="input_text" path="inputUser" id="clientCellphone4" /></td>
		</tr>
		<c:if test="${preordId != null && preordId != 0 }">
		<tr>
			<th>核实</th>
			<td><form:input cssClass="input_text" path="checkUser" id="clientCellphone5" /></td>
		</tr>
		<tr>
			<th>状态</th>
			<td>
				<form:select path="preordStateKey">
					<form:options items="${preord_state }" itemLabel="dictValue0" itemValue="dictKey"/>
				</form:select>
			</td>
		</tr>
		</c:if>
		<tr>
			<td colspan="3"><input type="submit" value="保存" /> <input type="button" value="返回" onclick="window.location='${pageContext.request.contextPath}/busiPreord';" /></td>
		</tr>
	</tbody>
</table>

</form:form>
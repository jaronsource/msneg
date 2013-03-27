<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiOrders" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiOrders.ordersId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiOrders" id="busiOrdersForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="ordersId" />
	        
	        <form:label path="busiClient">客户ID</form:label>
	        <form:input path="busiClient" />
	        <form:errors path="busiClient" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="ordersTypeKeys">定金类型</form:label>
	        <form:input path="ordersTypeKeys" />
	        <form:errors path="ordersTypeKeys" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="ordersRemarks">备注</form:label>
	        <form:input path="ordersRemarks" />
	        <form:errors path="ordersRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="ordersUseKey">定金用途</form:label>
	        <form:input path="ordersUseKey" />
	        <form:errors path="ordersUseKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="ordersReturnKey">定金返还</form:label>
	        <form:input path="ordersReturnKey" />
	        <form:errors path="ordersReturnKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="ordersSum">总金额</form:label>
	        <form:input path="ordersSum" />
	        <form:errors path="ordersSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="ordersCash">现金</form:label>
	        <form:input path="ordersCash" />
	        <form:errors path="ordersCash" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="ordersCard">刷卡</form:label>
	        <form:input path="ordersCard" />
	        <form:errors path="ordersCard" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherRemarks">其他信息部分</form:label>
	        <form:input path="otherRemarks" />
	        <form:errors path="otherRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>

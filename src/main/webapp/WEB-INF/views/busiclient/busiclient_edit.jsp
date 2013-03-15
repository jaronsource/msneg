<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiClient" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiClient.clientId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiClient" id="busiClientForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="clientId" />
	        
	        <form:label path="clientName">客户姓名</form:label>
	        <form:input path="clientName" />
	        <form:errors path="clientName" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="phone">电话</form:label>
	        <form:input path="phone" />
	        <form:errors path="phone" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="cellPhone">手机</form:label>
	        <form:input path="cellPhone" />
	        <form:errors path="cellPhone" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="address">地址</form:label>
	        <form:input path="address" />
	        <form:errors path="address" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>

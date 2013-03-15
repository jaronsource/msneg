<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesBrokerage" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesBrokerage.brokId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesBrokerage" id="busiSalesBrokerageForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="brokId" />
	        
	        <form:label path="brokSum">提成总额</form:label>
	        <form:input path="brokSum" />
	        <form:errors path="brokSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="clearMethodKey">结算方式</form:label>
	        <form:input path="clearMethodKey" />
	        <form:errors path="clearMethodKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="brokPersonName">提成人</form:label>
	        <form:input path="brokPersonName" />
	        <form:errors path="brokPersonName" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="sysUser">经手人</form:label>
	        <form:input path="sysUser" />
	        <form:errors path="sysUser" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="createTime">创建时间</form:label>
	        <form:input path="createTime" />
	        <form:errors path="createTime" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>

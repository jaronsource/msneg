<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesWorkingItem" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesWorkingItem.workingItemId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesWorkingItem" id="busiSalesWorkingItemForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="workingItemId" />
	        
	        <form:label path="busiSalesWorking">工时单ID</form:label>
	        <form:input path="busiSalesWorking" />
	        <form:errors path="busiSalesWorking" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="busiItem">商品ID</form:label>
	        <form:input path="busiItem" />
	        <form:errors path="busiItem" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnVisitKey">回访</form:label>
	        <form:input path="returnVisitKey" />
	        <form:errors path="returnVisitKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemRemarks">备注</form:label>
	        <form:input path="itemRemarks" />
	        <form:errors path="itemRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>

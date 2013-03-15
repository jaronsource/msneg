<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesReturn" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesReturn.returnId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesReturn" id="busiSalesReturnForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="returnId" />
	        
	        <form:label path="busiSales">销售单ID</form:label>
	        <form:input path="busiSales" />
	        <form:errors path="busiSales" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="sysUser">经手人</form:label>
	        <form:input path="sysUser" />
	        <form:errors path="sysUser" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnLoss">返销破损</form:label>
	        <form:input path="returnLoss" />
	        <form:errors path="returnLoss" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="rerateLoss">折扣破损</form:label>
	        <form:input path="rerateLoss" />
	        <form:errors path="rerateLoss" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnRemarks">备注</form:label>
	        <form:input path="returnRemarks" />
	        <form:errors path="returnRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="clearMethodKey">结算方式</form:label>
	        <form:input path="clearMethodKey" />
	        <form:errors path="clearMethodKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="otherRemarks">其他备注</form:label>
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

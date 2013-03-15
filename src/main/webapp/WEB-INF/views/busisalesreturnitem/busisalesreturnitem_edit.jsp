<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesReturnItem" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesReturnItem.returnItemId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesReturnItem" id="busiSalesReturnItemForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="returnItemId" />
	        
	        <form:label path="busiSalesReturn">返销单ID</form:label>
	        <form:input path="busiSalesReturn" />
	        <form:errors path="busiSalesReturn" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="busiItem">商品ID</form:label>
	        <form:input path="busiItem" />
	        <form:errors path="busiItem" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnPrice">返销单价</form:label>
	        <form:input path="returnPrice" />
	        <form:errors path="returnPrice" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnAmount">返销数量</form:label>
	        <form:input path="returnAmount" />
	        <form:errors path="returnAmount" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnSum">返销合计</form:label>
	        <form:input path="returnSum" />
	        <form:errors path="returnSum" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnReasonKey">返销事由</form:label>
	        <form:input path="returnReasonKey" />
	        <form:errors path="returnReasonKey" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="returnRemarks">备注</form:label>
	        <form:input path="returnRemarks" />
	        <form:errors path="returnRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>

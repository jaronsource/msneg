<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiItem" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiItem.itemId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiItem" id="busiItemForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="itemId" />
	        
	        <form:label path="itemCode">货号</form:label>
	        <form:input path="itemCode" />
	        <form:errors path="itemCode" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemName">名称</form:label>
	        <form:input path="itemName" />
	        <form:errors path="itemName" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemFormat">型号</form:label>
	        <form:input path="itemFormat" />
	        <form:errors path="itemFormat" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemUnit">单位</form:label>
	        <form:input path="itemUnit" />
	        <form:errors path="itemUnit" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemPrice">单价</form:label>
	        <form:input path="itemPrice" />
	        <form:errors path="itemPrice" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemCnspell">助记符</form:label>
	        <form:input path="itemCnspell" />
	        <form:errors path="itemCnspell" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="itemTypeKey">类别</form:label>
	        <form:input path="itemTypeKey" />
	        <form:errors path="itemTypeKey" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>

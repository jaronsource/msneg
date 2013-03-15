<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/busiSalesClear" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="busiSalesClear.clearId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="busiSalesClear" id="busiSalesClearForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="clearId" />
	        
	        <form:label path="feeClear">结算金额</form:label>
	        <form:input path="feeClear" />
	        <form:errors path="feeClear" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feeClearCash">结算金额现金</form:label>
	        <form:input path="feeClearCash" />
	        <form:errors path="feeClearCash" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feeClearCard">结算金额刷卡</form:label>
	        <form:input path="feeClearCard" />
	        <form:errors path="feeClearCard" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="feeRemain">剩余尾款</form:label>
	        <form:input path="feeRemain" />
	        <form:errors path="feeRemain" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="busiSales">销售单ID</form:label>
	        <form:input path="busiSales" />
	        <form:errors path="busiSales" cssClass="error" element="div" />
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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<div class="row">
    
    <spring:url value="/sysDept" var="baseUrl"/>    
    
    <c:set var="labelNew" value="新建" />
    <c:set var="labelUpdate" value="更新" />
    <spring:eval expression="sysDept.deptId == null ? labelNew:labelUpdate" var="formTitle"/>

    <div class="span10">
    <form:form modelAttribute="sysDept" id="sysDeptForm" method="post">
		<fieldset>
			<legend>${formTitle}</legend>
	        <c:if test="${not empty message}">
	            <div id="message" class="${message.type}">${message.message}</div>
	        </c:if>
	        <form:hidden path="deptId" />
	        
	        <form:label path="deptName">名称</form:label>
	        <form:input path="deptName" />
	        <form:errors path="deptName" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="deptRemarks">描述</form:label>
	        <form:input path="deptRemarks" />
	        <form:errors path="deptRemarks" cssClass="error" element="div" />
	        <p/>
	        
	        <form:label path="deptTypeKey">部门类型</form:label>
	        <form:input path="deptTypeKey" />
	        <form:errors path="deptTypeKey" cssClass="error" element="div" />
	        <p/>
	        
	        
	        <button type="submit" class="btn btn-primary">提交</button>
	        <button type="reset" class="btn">重置</button>
	        <a href="${baseUrl}" class="btn">返回列表</a>
        </fieldset>              
    </form:form>   
    </div>

</div>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiClient" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiClientInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>客户ID</td>
                <td>${busiClient.clientId}</td>
            </tr>
	    	<tr>
                <td>客户姓名</td>
                <td>${busiClient.clientName}</td>
            </tr>
	    	<tr>
                <td>电话</td>
                <td>${busiClient.phone}</td>
            </tr>
	    	<tr>
                <td>手机</td>
                <td>${busiClient.cellPhone}</td>
            </tr>
	    	<tr>
                <td>地址</td>
                <td>${busiClient.address}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiClient.clientId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiClient.clientId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesBrokerage" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesBrokerageInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>提成单ID</td>
                <td>${busiSalesBrokerage.brokId}</td>
            </tr>
	    	<tr>
                <td>提成总额</td>
                <td>${busiSalesBrokerage.brokSum}</td>
            </tr>
	    	<tr>
                <td>结算方式</td>
                <td>${busiSalesBrokerage.clearMethodKey}</td>
            </tr>
	    	<tr>
                <td>提成人</td>
                <td>${busiSalesBrokerage.brokPersonName}</td>
            </tr>
	    	<tr>
                <td>经手人</td>
                <td>${busiSalesBrokerage.sysUser}</td>
            </tr>
	    	<tr>
                <td>创建时间</td>
                <td>${busiSalesBrokerage.createTime}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesBrokerage.brokId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesBrokerage.brokId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiStock" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiStockInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>库存ID</td>
                <td>${busiStock.stockId}</td>
            </tr>
	    	<tr>
                <td>商品ID</td>
                <td>${busiStock.busiItem}</td>
            </tr>
	    	<tr>
                <td>库存数量</td>
                <td>${busiStock.stockAmount}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiStock.stockId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiStock.stockId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

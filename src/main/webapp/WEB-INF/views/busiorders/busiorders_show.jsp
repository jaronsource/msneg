<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiOrders" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiOrdersInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>主键</td>
                <td>${busiOrders.ordersId}</td>
            </tr>
	    	<tr>
                <td>客户ID</td>
                <td>${busiOrders.busiClient}</td>
            </tr>
	    	<tr>
                <td>定金类型</td>
                <td>${busiOrders.ordersTypeKeys}</td>
            </tr>
	    	<tr>
                <td>备注</td>
                <td>${busiOrders.ordersRemarks}</td>
            </tr>
	    	<tr>
                <td>定金用途</td>
                <td>${busiOrders.ordersUseKey}</td>
            </tr>
	    	<tr>
                <td>定金返还</td>
                <td>${busiOrders.ordersReturnKey}</td>
            </tr>
	    	<tr>
                <td>总金额</td>
                <td>${busiOrders.ordersSum}</td>
            </tr>
	    	<tr>
                <td>现金</td>
                <td>${busiOrders.ordersCash}</td>
            </tr>
	    	<tr>
                <td>刷卡</td>
                <td>${busiOrders.ordersCard}</td>
            </tr>
	    	<tr>
                <td>其他信息部分</td>
                <td>${busiOrders.otherRemarks}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiOrders.ordersId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiOrders.ordersId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

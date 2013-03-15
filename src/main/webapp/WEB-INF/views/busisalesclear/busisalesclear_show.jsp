<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesClear" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesClearInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>结算单ID</td>
                <td>${busiSalesClear.clearId}</td>
            </tr>
	    	<tr>
                <td>结算金额</td>
                <td>${busiSalesClear.feeClear}</td>
            </tr>
	    	<tr>
                <td>结算金额现金</td>
                <td>${busiSalesClear.feeClearCash}</td>
            </tr>
	    	<tr>
                <td>结算金额刷卡</td>
                <td>${busiSalesClear.feeClearCard}</td>
            </tr>
	    	<tr>
                <td>剩余尾款</td>
                <td>${busiSalesClear.feeRemain}</td>
            </tr>
	    	<tr>
                <td>销售单ID</td>
                <td>${busiSalesClear.busiSales}</td>
            </tr>
	    	<tr>
                <td>经手人</td>
                <td>${busiSalesClear.sysUser}</td>
            </tr>
	    	<tr>
                <td>创建时间</td>
                <td>${busiSalesClear.createTime}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesClear.clearId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesClear.clearId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSales" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>销售单ID</td>
                <td>${busiSales.salesId}</td>
            </tr>
	    	<tr>
                <td>编码</td>
                <td>${busiSales.salesCode}</td>
            </tr>
	    	<tr>
                <td>销售部门</td>
                <td>${busiSales.sysDept}</td>
            </tr>
	    	<tr>
                <td>经手人</td>
                <td>${busiSales.sysUser}</td>
            </tr>
	    	<tr>
                <td>创建时间</td>
                <td>${busiSales.createTime}</td>
            </tr>
	    	<tr>
                <td>备注</td>
                <td>${busiSales.salesRemarks}</td>
            </tr>
	    	<tr>
                <td>销售单类型</td>
                <td>${busiSales.salesTypeKey}</td>
            </tr>
	    	<tr>
                <td>客户ID</td>
                <td>${busiSales.busiClient}</td>
            </tr>
	    	<tr>
                <td>状态</td>
                <td>${busiSales.salesStateKey}</td>
            </tr>
	    	<tr>
                <td>物流信息</td>
                <td>${busiSales.servLogisKey}</td>
            </tr>
	    	<tr>
                <td>取货方式</td>
                <td>${busiSales.servGetmethodKey}</td>
            </tr>
	    	<tr>
                <td>安装方式</td>
                <td>${busiSales.servInstallmethodKey}</td>
            </tr>
	    	<tr>
                <td>总金额</td>
                <td>${busiSales.feeSum}</td>
            </tr>
	    	<tr>
                <td>预付金额</td>
                <td>${busiSales.feePrepay}</td>
            </tr>
	    	<tr>
                <td>预付金现金</td>
                <td>${busiSales.feePrepayCash}</td>
            </tr>
	    	<tr>
                <td>预付金刷卡</td>
                <td>${busiSales.feePrepayCard}</td>
            </tr>
	    	<tr>
                <td>剩余尾款</td>
                <td>${busiSales.feeRemain}</td>
            </tr>
	    	<tr>
                <td>其他备注</td>
                <td>${busiSales.otherRemarks}</td>
            </tr>
	    	<tr>
                <td>合同条款</td>
                <td>${busiSales.salesContract}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSales.salesId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSales.salesId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

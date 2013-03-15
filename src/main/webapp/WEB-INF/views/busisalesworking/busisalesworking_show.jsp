<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesWorking" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesWorkingInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>工时单ID</td>
                <td>${busiSalesWorking.workingId}</td>
            </tr>
	    	<tr>
                <td>其他项目名称</td>
                <td>${busiSalesWorking.otherItemName}</td>
            </tr>
	    	<tr>
                <td>其他项目单价</td>
                <td>${busiSalesWorking.otherItemPrice}</td>
            </tr>
	    	<tr>
                <td>其他项目数量</td>
                <td>${busiSalesWorking.otherItemAmount}</td>
            </tr>
	    	<tr>
                <td>其他项目合计</td>
                <td>${busiSalesWorking.otherItemSum}</td>
            </tr>
	    	<tr>
                <td>项目备注</td>
                <td>${busiSalesWorking.otherItemRemarks}</td>
            </tr>
	    	<tr>
                <td>工时总额</td>
                <td>${busiSalesWorking.feeSum}</td>
            </tr>
	    	<tr>
                <td>结算形式</td>
                <td>${busiSalesWorking.clearMethodKey}</td>
            </tr>
	    	<tr>
                <td>安装部门</td>
                <td>${busiSalesWorking.sysDept}</td>
            </tr>
	    	<tr>
                <td></td>
                <td>${busiSalesWorking.otherRemarks}</td>
            </tr>
	    	<tr>
                <td>创建时间</td>
                <td>${busiSalesWorking.createTime}</td>
            </tr>
	    	<tr>
                <td>经手人</td>
                <td>${busiSalesWorking.sysUser}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesWorking.workingId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesWorking.workingId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

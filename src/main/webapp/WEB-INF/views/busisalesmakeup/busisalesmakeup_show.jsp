<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="row">

    <spring:url value="/busiSalesMakeup" var="baseUrl"/>   

    <h3>信息</h3>

    <div id="busiSalesMakeupInfo" class="span10">

        <table class="table table-bordered table-hover">
	    	<tr>
                <td>补价单ID</td>
                <td>${busiSalesMakeup.makeupId}</td>
            </tr>
	    	<tr>
                <td>补价总额</td>
                <td>${busiSalesMakeup.makeupSum}</td>
            </tr>
	    	<tr>
                <td>经手人</td>
                <td>${busiSalesMakeup.sysUser}</td>
            </tr>
	    	<tr>
                <td>新增临时性损耗费用</td>
                <td>${busiSalesMakeup.addItem1}</td>
            </tr>
	    	<tr>
                <td>增值服务取费</td>
                <td>${busiSalesMakeup.addItem2}</td>
            </tr>
	    	<tr>
                <td>上衣托管安装（含多施工费用）</td>
                <td>${busiSalesMakeup.addItem3}</td>
            </tr>
	    	<tr>
                <td>变更议价补价</td>
                <td>${busiSalesMakeup.addItem4}</td>
            </tr>
	    	<tr>
                <td>新增运输及商品管理费用</td>
                <td>${busiSalesMakeup.addItem5}</td>
            </tr>
	    	<tr>
                <td>其他商议费用</td>
                <td>${busiSalesMakeup.addItem6}</td>
            </tr>
	    	<tr>
                <td>递减临时性损耗费用</td>
                <td>${busiSalesMakeup.minusItem1}</td>
            </tr>
	    	<tr>
                <td>补退议价差额</td>
                <td>${busiSalesMakeup.minusItem2}</td>
            </tr>
	    	<tr>
                <td>递减托管安装（含少施工费用）</td>
                <td>${busiSalesMakeup.minusItem3}</td>
            </tr>
	    	<tr>
                <td>遇零取整差价</td>
                <td>${busiSalesMakeup.minusItem4}</td>
            </tr>
	    	<tr>
                <td>商品瑕疵/破损议价差额</td>
                <td>${busiSalesMakeup.minusItem5}</td>
            </tr>
	    	<tr>
                <td> 其他商议费用</td>
                <td>${busiSalesMakeup.minusItem6}</td>
            </tr>
	    	<tr>
                <td>补价信息备注</td>
                <td>${busiSalesMakeup.makeupRemarks}</td>
            </tr>
	    	<tr>
                <td>其他备注</td>
                <td>${busiSalesMakeup.otherRemarks}</td>
            </tr>
	    	<tr>
                <td>创建时间</td>
                <td>${busiSalesMakeup.createTime}</td>
            </tr>
        </table>         
       
        <a href="${baseUrl}/${busiSalesMakeup.makeupId}/update" class="btn">修改</a>
        <a href="${baseUrl}/${busiSalesMakeup.makeupId}/remove" class="btn">删除</a>
        <a href="${baseUrl}" class="btn">返回列表</a>     
        <a href="${baseUrl}/create" class="btn">新建</a>     
                      
    </div>

</div>

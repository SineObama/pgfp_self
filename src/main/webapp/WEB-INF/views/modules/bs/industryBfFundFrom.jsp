<%@page contentType="text/html;charset=UTF-8"%>
<%@include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫产业帮扶资金发放汇总表</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>

	<script>
        $(document).ready(function() {
            $('.btnEx').click(function(){
                top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v ,h, f) {
					<%--console.log(${county});--%>
                    if (v == "ok") {
                        $("#inputForm").attr("action", "${ctx}/bs/industryAssistanceApplication/exportSummary?countyName=${county}");
                        $("#inputForm").submit();
                    }
                });
            });
        });

        $(window).scroll(function(){
            if(($("body").height()-$("body,html").scrollTop())<=document.documentElement.clientHeight){
                $("#btnEx1").hide();
                $("#btnEx2").show();

            }else{
                $("#btnEx1").show();
                $("#btnEx2").hide();
            }
        });
        //    $(window).scroll(function(){
        //        var scrollTop = $(this).scrollTop();
        //        var scrollHeight = $(document).height();
        //        var windowHeight = $(this).height();
        //        if(scrollTop + windowHeight == scrollHeight){
        //            alert("you are in the bottom");
        //        }
        //    });
	</script>
	<style>
		.inputType {
			border-width: 0 0 1px 0;
			text-align: center;
			border-bottom-color: #000000;
			width: 160px;
		}
		.content-detail td{
			border-collapse: collapse;
			min-width: 40px!important;
		}
		.content-detail thead td{
			text-align: center;
		}
		.content-detail{
			margin-bottom: 150px;
		}
	</style>


</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/bs/industryAssistanceApplication/industryBfFundList">扶贫产业帮扶资金发放汇总列表</a></li>
	<li class="active"><a href="${ctx}/bs/industryAssistanceApplication/industryBfFundFrom?county=${list[0].county}">扶贫产业帮扶资金发放汇总表</a></li>
</ul><br/>

<div class="content tabs f-clear">
	<div id="tab-1" class="content-detail" style="width: 788px;">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="list" action="" method="post" class="form-horizontal">
			<h1 style="text-align: center;">脱贫攻坚特色种植养殖扶贫产业帮扶资金发放汇总表</h1>
			<br/><br/>
			<p style="margin-bottom: 15px;">
				<span>填报单位：<input class="inputType"/></span>
				<span>领导签字：<input class="inputType"/></span>
				<span>填报时间：<input class="inputType"/></span>
				<span style="z-index: 9999; position: fixed ! important;">
					<input id="btnEx1" class="btn btn-primary btnEx" type="button"
						   style="position: absolute; width:62px;margin-left: 60px;" value="导 出"/>
				</span>
			</p>
			<table id="contentTable" class="table table-striped table-bordered table-condensed">
				<thead>
				<tr>
					<td rowspan="2">序号</td>
					<td rowspan="2">村组</td>
					<td rowspan="2">贫困户姓名</td>
					<td rowspan="2">身份证号码</td>
					<td colspan="2">银行账户</td>
					<td rowspan="2">补助金额(元)</td>
					<td rowspan="2">补助类型</td>
					<td rowspan="2">联系电话</td>
					<td rowspan="2">备注</td>
				</tr>
				<tr>
					<td>户名</td>
					<td>账号</td>
				</tr>
				</thead>
				<tbody>
					 <c:forEach var="i" items="${list}" varStatus="l">
						 <tr>
							 <td>${l.index + 1}</td>
							 <td>${i.group1}</td>
							 <td>${i.householdName}</td>
							 <td>${i.idNumber}</td>
							 <td>${i.card.bankHolder}</td>
							 <td>${i.cardNumber}</td>
							 <td>${i.subsidyMoney}</td>
							 <td>${i.name}${i.scale}${i.company}</td>
							 <td>${i.card.mobile}</td>
							 <td>${i.remarks}</td>
						 </tr>
					  </c:forEach>
				</tbody>
			</table>
		</form:form>
		<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important; float: right" value="返 回" onclick="history.go(-1)">
		<input hidden="hidden" id="btnEx2" class="btn btn-primary btnEx" type="button" style="margin-right: 30px;float: right;" value="导 出"/>
	</div>
</div>
</body>
</html>


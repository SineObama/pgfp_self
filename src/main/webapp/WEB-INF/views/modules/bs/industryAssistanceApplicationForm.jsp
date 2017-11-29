<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产业发展帮扶申请表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	<style>
		#inputForm {
			width: 900px;
			margin-left: 30px;
		}

		table {
			border: 2px solid #ccc;
		}

		td {
			height: 34px;
			min-width: 120px;
			text-align: center;
			border: 1px solid #ccc;
		}

		.table-title {
			font-size: 18px;
			font-weight: bold;
			text-align: center;
			color: #000;
		}

		.table-subtitle {
			font-size: 16px;
			font-weight: bold;
			text-align: center;
			color: #000;
		}

		.thead-r {
			float: right;
			margin-right: 100px;
			display: inline-block;
		}

		.border-none {
			border-width: 0 1px 0 1px;
		}

		.text-l {
			padding: 10px 8px;
			text-align: left;
		}

		.text-l .sig {
			text-align: right;
		}

		.text-l span {
			display: inline-block;
			text-indent: 2em;
		}

		.accept {
			margin-left: 500px;
			color: #333;
			background: #4b7ee6;
		}

		.accept:hover {
			color: #fff;
			background: #4b7ee6;
		}

		.back {
			color: #333;
			background: #ff3c2f;
		}

		.back:hover {
			color: #fff;
			background: #ff3c2f;
		}
		.btn.back[readonly]{
			color: #333;
		}
		.btn.back[readonly]:hover{
			color: #333;
			background-color: rgb(243,243,243);
		}

		.return {
			display: inline-block;
			padding: 4px 12px;
			border: 1px solid rgb(179, 179, 179);
			font-size: 14px;
			line-height: 20px;
			color: #f5f5f5;
			text-align: center;
			text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
			border-radius: 4px;
			text-decoration: none;
			vertical-align: top;
			margin-left: 600px;
			background-color: #467ca2;
		}

		.return:hover {
			color: #333;
			text-decoration: none;
		}

		.btn {
			text-shadow: none;
		}

		.audit {
			margin-left: 0px;
		}

		.year {
			margin-left: 120px;
		}

		.month {
			margin-left: 5px;
		}

		.day {
			margin-left: 5px;
		}
		.control-group .input {
			border-width: 0 0 1px 0;
			text-align: center;
			border-bottom-color: #000000;
		}
		td{
			width: 130px;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bs/industryAssistanceApplication/list">产业发展帮扶申请表列表</a></li>
		<li class="active"><a href="${ctx}/bs/industryAssistanceApplication/form?id=${industryAssistanceApplication.id}">产业发展帮扶申请表<shiro:hasPermission name="bs:industryAssistanceApplication:edit">${not empty industryAssistanceApplication.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bs:industryAssistanceApplication:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="industryAssistanceApplication" action="${ctx}/bs/industryAssistanceApplication/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<h2 class="table-title">平桂区2017年贫困户产业发展帮扶申请表</h2>
		<br>
		<div class="control-group">
		<form:input path="county" class="input" style="width: 120px;" type="none"/>
		<span>镇</span>
		<form:input path="country" class="input" style="width: 120px;" type="none"/>
		<span>村委</span>
		<form:input path="village" class="input" style="width: 120px;" type="none"/>
		<span>自然村</span>
		<form:input path="group1" class="input" style="width: 120px;" type="none"/>
		<span>小组</span>
		<span class="thead-r"><span>户主：<form:input path="householdName" class="input" style="width: 100px;" type="none"/></span>
		</span>
			<br>
			<br>
		<table>
			<tr>
				<td rowspan="2">身份证号</td>
				<td rowspan="2">银行账号</td>
				<td colspan="3">发展产业</td>
				<td rowspan="2">申请补助资金（元）</td>
			</tr>
			<tr>
				<td>名称</td>
				<td>规模</td>
				<td>单位</td>
			</tr>
			<tr style="height: 60px">
				<td rowspan="">${industryAssistanceApplication.idNumber}</td>
				<td rowspan="">${industryAssistanceApplication.cardNumber}</td>
				<td rowspan="">${industryAssistanceApplication.name}</td>
				<td rowspan="">${industryAssistanceApplication.scale}</td>
				<td rowspan="">${industryAssistanceApplication.company}</td>
				<td rowspan="">${industryAssistanceApplication.subsidyMoney}</td>
			</tr>
			<tr>
				<td style="height: 100px" colspan="6" class="text-l">
					贫困户签名：<br/>
					<span></span><br/><br/>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="text-l" style="height: 100px">
					帮扶责任人签名：<br/>
					<span></span><br/><br/>
				</td>
				<td colspan="4" class="text-l" style="height: 100px">
					第一书记或包村工作队长签名：<br/>
					<span></span><br/><br/>


				</td>
			</tr>
		</table>
			<br>
		<div style="font-size: 17px">
			<strong>填表说明：</strong>此表为一户一表，不用分类填报。原件要求一式三份（村委会一份、乡镇扶贫站1份、财政所1份）。
		</div>
		<div class="control-group" style="margin:20px 60px;height: 60px;padding: 0px">
			<a class="return" href="${ctx}/bs/industryAssistanceApplication/list">返回</a>
				<%--<input class="btn" type="button" style="margin-left: 20px" onclick="history.go(-1)" value="返回">--%>
		</div>
	</form:form>
</body>
</html>
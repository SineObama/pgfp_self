<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>有电视看认定表管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/style.css"/>
	<style>
		.content-detail p>input[type=text]{
			border-bottom: 1px solid #ccc;
			margin-bottom: 0;
		}
		.content-detail h2{
			margin-top: 10px;
			margin-bottom: -8px;
			font-size: 16px;
		}
		.content-detail h1{
			font-size: 22px;
		}
		.content-detail input[type=radio]{
			margin-left: 20px;
		}
		.content-detail input[type=checkbox]{
			margin-left: 20px;
		}
		.content-detail .signDate{
			float: right;
		}
		.content-detail .signDate input[type=text]{
			width: 40px;
			border-bottom: 1px solid #ccc;
		}
		.content-detail .content-save{
			margin-top: 40px;
		}
		.content-detail .content-save .save-btn{
			margin-right: 30px;
		}
	</style>
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
</head>
<body>

<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<ul class="nav nav-tabs">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/report/foodAndClothing/list">贫困户列表</a></li>
		<li class="active"><a href="${ctx}/report/digitalGuarantee/form?id=${digitalGuarantee.id}">有电视看认定表<shiro:hasPermission name="report:foodAndClothing:edit">${not empty foodAndClothing.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="report:foodAndClothing:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
</ul>
<br>
<form:form id="inputForm" modelAttribute="digitalGuarantee" action="${ctx}/report/digitalGuarantee/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="regcardId" value="${digitalGuarantee.regcardId}"/>
	<sys:message content="${message}"/>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li>
				<a href="${ctx}/report/foodAndClothing/form?regcardId=${digitalGuarantee.regcardId}">（一）吃穿不愁</a></li>
			<li>
				<a href="${ctx}/report/houseGuarantee/form?regcardId=${digitalGuarantee.regcardId}">（二）住房保障</a>
			</li>
			<li>
				<a href="${ctx}/report/medicalGuarantee/form?regcardId=${digitalGuarantee.regcardId}">（三）医疗保障</a>
			</li>
			<li>
				<a href="${ctx}/report/educationGuarantee/form?regcardId=${digitalGuarantee.regcardId}">（四）义务教育保障</a>
			</li>
			<li>
				<a href="${ctx}/report/drinkGuarantee/form?regcardId=${digitalGuarantee.regcardId}">（五）安全饮水</a>
			</li>
			<li>
				<a href="${ctx}/report/roadGuarantee/form?regcardId=${digitalGuarantee.regcardId}">（六）有路通村屯</a>
			</li>
			<li>
				<a href="${ctx}/report/electricGuarantee/form?regcardId=${digitalGuarantee.regcardId}">（七）有电用</a>
			</li>
			<li class="active">
				（八）有电视看
			</li>

		</ul>
		<div id="tab-1" class="content-detail">
			<h1>（八）建档立卡贫困户脱贫“双认定”（有电视看）分析表</h1>
			<h2>一、是否有电视、电脑或智能手机：</h2>
			<form:radiobuttons path="isdigital" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			<p>
				<form:checkbox path="istv" value="1" label="电视"/>（<form:input path="tvNumber" style="width: 60px"/>台）
				<form:checkbox path="ispc" value="1" label="电脑"/>（<form:input path="pcNumber" style="width: 60px"/>台）
				<form:checkbox path="isphone" value="1" label="智能手机"/>（<form:input path="phoneNumber" style="width: 60px"/>台）
			</p>
			<h2>二、电视类别：</h2>
			<p>
				<form:radiobuttons path="tvType" items="${fns:getDictList('tv_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</p>
			<h2>二、电视机信号方式：</h2>
			<p>
				<form:radiobuttons path="signalType" items="${fns:getDictList('signal_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</p>
			<h2>四、能收看到的频道：</h2>
			<p>
				<form:checkboxes path="channelTypeList" items="${fns:getDictList('channel_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</p>
			<h2>五、有电视看图片：</h2>
			<div class="control-group">
				<div class="controls" style="margin-left: 0">
					<form:textarea id="content" htmlEscape="true" path="img" rows="4" maxlength="200" class="input-xxlarge"/>
					<sys:ckeditor replace="content" uploadPath="/cms/article" />
				</div>
			</div>
			<p>户主签名（手印/电话）：</p>
			<p>帮扶人员签名（手印/电话）：</p>
			<div class="signDate"><input type="text"/>年<input type="text"/>月<input type="text"/>日</div>
			<div class="content-save"><input type="submit" value="提 交" class="save-btn"></div>
		</div>
		<script type="text/javascript">//<!-- 无框架时，左上角显示菜单图标按钮。
		if (!(self.frameElement && self.frameElement.tagName == "IFRAME")) {
			$("body").prepend("<i id=\"btnMenu\" class=\"icon-th-list\" style=\"cursor:pointer;float:right;margin:10px;\"></i><div id=\"menuContent\"></div>");
			$("#btnMenu").click(function () {
				top.$.jBox('get:/a/sys/menu/treeselect;JSESSIONID=c57c304b63c745e2a5dcdbf0c27eb6ab', {
					title: '选择菜单',
					buttons: {'关闭': true},
					width: 300,
					height: 350,
					top: 10
				});
				//if ($("#menuContent").html()==""){$.get("/a/sys/menu/treeselect", function(data){$("#menuContent").html(data);});}else{$("#menuContent").toggle(100);}
			});
		}//-->
		</script>
	</div>
</form:form>
</body>
</html>
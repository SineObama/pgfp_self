<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>住房保障认定表管理</title>
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
		<li class="active"><a href="${ctx}/report/houseGuarantee/form?id=${houseGuarantee.id}">住房分析表<shiro:hasPermission name="report:foodAndClothing:edit">${not empty foodAndClothing.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="report:foodAndClothing:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
</ul>
<br>
<form:form id="inputForm" modelAttribute="houseGuarantee" action="${ctx}/report/houseGuarantee/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<form:hidden path="regcardId" value="${houseGuarantee.regcardId}"/>
	<sys:message content="${message}"/>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/report/foodAndClothing/form?regcardId=${houseGuarantee.regcardId}">（一）吃穿不愁</a></li>
			<li class="active">
				（二）住房保障
			</li>
			<li>
				<a href="${ctx}/report/medicalGuarantee/form?regcardId=${houseGuarantee.regcardId}">（三）医疗保障</a>
			</li>
			<li>
				<a href="${ctx}/report/educationGuarantee/form?regcardId=${houseGuarantee.regcardId}">（四）义务教育保障</a>
			</li>
			<li>
				<a href="${ctx}/report/drinkGuarantee/form?regcardId=${houseGuarantee.regcardId}">（五）安全饮水</a>
			</li>
			<li>
				<a href="${ctx}/report/roadGuarantee/form?regcardId=${houseGuarantee.regcardId}">（六）有路通村屯</a>
			</li>
			<li>
				<a href="${ctx}/report/electricGuarantee/form?regcardId=${houseGuarantee.regcardId}">（七）有电用</a>
			</li>
			<li>
				<a href="${ctx}/report/digitalGuarantee/form?regcardId=${houseGuarantee.regcardId}">（八）有电视看</a>
			</li>

		</ul>
		<div id="tab-1" class="content-detail">
			<h1>（二）建档立卡贫困户脱贫“双认定”（有住房保障）分析表</h1>
			<h2>一、有稳固住房且达标：</h2>
			<p><strong>　　是</strong>
			<form:radiobutton path="houseStandard" value="1" label=""/>
			〔（1）有钢混、砖混、砖木、土木或木制结构的住房，房屋主体稳固安全〔按照《广西壮族自治区农村危房评定技术导则（实行）》评定，达到房屋安全A、B级标准〕，人均建筑面积13平方米以上（含）（包括厅堂、厨房、卫生间等生活用房面积），属新建住房（含危旧房改造）的，达到入住基本条件（安装好门、窗等）。（2）易地扶贫搬迁户，属集中安置的，房屋质量合格并达到入住基本条件（安装好水、电、门、窗等），且已正式交付钥匙；属分散安置的，房屋质量合格并已搬迁入住。备注：父母与子女拆户分户的，按父母与子女住房总面积测算，人均达到13平方米以上（含）稳固住房的，视为有住房保障。)。
			</p>
			<p>房屋可以是钢混结构、砖混结构、土木结构、也可以是木制结构]，人均面积<form:input path="avgArea" style="width: 60px" class="disAvg disSel decimal"/>㎡，房屋结构：<form:radiobuttons class="disSel" path="houseStructure" items="${fns:getDictList('structure')}" itemValue="value" itemlabel="label"/></p>
			<p><strong>　　否</strong>
			<form:radiobutton path="houseStandard" value="0" label=""/>（如选否，请拍摄主体结构、4个角的照片。）
			</p>
			<h2>二、有稳固住房但达不到人均13平方米：</h2>
			<p><strong>　　是</strong>
					<form:radiobutton class="disSel2 disRadio" path="houseUnstandard" value="1" label=""/>（目前稳固住房<form:input path="houseArea"  style="width: 60px" class="decimal disRadio disAvg2"/>㎡）
				<strong>　　否</strong>
					<form:radiobutton class="disSel2 disRadio" path="houseUnstandard" value="0" label=""/>
			</p>
			<p>
				房屋结构：<form:radiobuttons class="disRadio" path="houseStructure2" items="${fns:getDictList('structure')}" itemValue="value" itemlabel="label"/>
			</p>
			<h2>三、无房或危房：</h2>
			　　无房<form:radiobutton class="disRadio disSel2" path="noOrDangerous" value="0" label=""/>　　　
			危房<form:radiobutton class="disRadio disSel2" path="noOrDangerous" value="1" label=""/>
			<h2>四、住房图片：</h2>
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
		$("#houseStandard1,#houseStandard2").click(function(){
			if($("#houseStandard1").attr("checked")){
				$(".disRadio").attr("disabled",true)
				$(".disSel").attr("disabled",false)
				$(".disSel2").attr({"disabled":true,"checked":false})
				$(".disAvg2").val("")
			}else{
				$(".disRadio").attr("disabled",false)
			}
			if($("#houseStandard2").attr("checked")){
				$(".disSel").attr({"disabled":true,"checked":false})
				$(".disAvg").val("")
			}
		})
		if($("#houseStandard1").attr("checked")){
			$(".disRadio").attr("disabled",true)
			$(".disSel").attr("disabled",false)
			$(".disSel2").attr({"disabled":true,"checked":false})
			$(".disAvg2").val("")
		}else{
			$(".disRadio").attr("disabled",false)
		}
		if($("#houseStandard2").attr("checked")){
			$(".disSel").attr({"disabled":true,"checked":false})
			$(".disAvg").val("")
		}
		</script>
	</div>
</form:form>
</body>
</html>
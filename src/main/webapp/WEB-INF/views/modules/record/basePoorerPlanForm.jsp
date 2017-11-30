<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户建档立卡表管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
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
	<ul class="nav nav-tabs">	
		<li><a href="${ctx}/record/basePoorerRegCard/">建档立卡表列表</a></li>
		<%--<li><a href="${ctx}/record/basePoorerRegCard/">贫困户建档立卡表列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${basePoorerRegCard.id}">填表记录<shiro:hasPermission name="record:basePoorerRegCard:edit">${not empty basePoorerRegCard.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:basePoorerRegCard:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">填表记录</a>
	</div>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/record/basePoorerRegCard/form?id=${basePoorerRegCard.id}">基本情况</a></li>
			<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${basePoorerRegCard.id}">家庭成员</a></li>
			<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${basePoorerRegCard.id}">家庭成员</a></li>
			<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${basePoorerRegCard.id}">家庭成员受培训情况</a></li>
			<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${basePoorerRegCard.id}">家庭成员参保情况</a></li>
			<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${basePoorerRegCard.id}">生产生活条件</a></li>
			<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${basePoorerRegCard.id}">家庭经济情况</a></li>
			<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${basePoorerRegCard.id}">特色产业增收</a></li>
			<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${basePoorerRegCard.id}">帮扶需求</a></li>
			<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${basePoorerRegCard.id}">帮扶单位及责任人</a></li>
			<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${basePoorerRegCard.id}">家庭在校生受帮扶情况</a></li>
			<li class="active">填表记录</li>
		</ul>
		<div id="tab-1" class="content-detail">
	<form:form id="inputForm" modelAttribute="basePoorerRegCard" action="${ctx}/record/basePoorerRegCard/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="houseId"/>
		<sys:message content="${message}"/>
		<br/>
		<table style="border: 0px #FFFFFF;">
			<tbody>
			<tr>
				<td class="sec-td"><span>工作组负责人签名</span></td>
				<td class="sec-td bg-white">
					<form:input type="text" class="inp-left required" path="workGroupLeader"/>
				</td>
				<td class="sec-td"><span>填表时间</span></td>
				<td class="sec-td bg-white">
					<%--<form:input type="text" class="inp-right" path="fillFormTime"/>--%>
					<input id="fillFormTime" name="fillFormTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						   value="<fmt:formatDate value="${basePoorerRegCard.fillFormTime}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="width: 120px;background-color: #FFFFFF;"/>
				</td>
			</tr>
			<tr>
				<td class="sec-td"><span>填表人及联系方式</span></td>
				<td class="sec-td bg-white" colspan="3">
					<form:input type="text" class="inp-left" path="preparerAndMobile"/>
				</td>
			</tr>
			</tbody>
		</table>

		<div class="content-save">
			<shiro:hasPermission name="record:basePoorerRegCard:edit">
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
			</div>
		</div>
</body>
</html>
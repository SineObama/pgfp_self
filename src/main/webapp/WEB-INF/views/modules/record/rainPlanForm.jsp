<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>雨露计划管理</title>
	<meta name="decorator" content="default"/>


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



<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>


<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/countryBasic/">村 基本情况列表</a></li>
	<%--<li><a href="${ctx}/record/rainPlan/">雨露计划列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/rainPlan/form?id=${rainPlan.id}">雨露计划<shiro:hasPermission name="record:rainPlan:edit">${not empty rainPlan.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:rainPlan:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>




<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${rainPlan.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${rainPlan.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${rainPlan.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${rainPlan.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${rainPlan.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${rainPlan.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${rainPlan.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${rainPlan.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${rainPlan.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${rainPlan.countryBasicId}">贫困村信息化</a></li>
		<li class="active">雨露计划</li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${rainPlan.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${rainPlan.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${rainPlan.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${rainPlan.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${rainPlan.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${rainPlan.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${rainPlan.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${rainPlan.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${rainPlan.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-11" class="content-detail">
		<c:choose>
		<c:when test="${empty rainPlan.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="rainPlan" action="${ctx}/record/rainPlan/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="countryBasicId"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>
			<table>
				<tbody>
				<tr>
					<td class="fir-td"><span>B69 本村参加雨露计划的人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b69PlanNumber" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B70 通过雨露计划培训后实现就业的人数（人））</span></td>
					<td class="fou-td bg-white">
						<form:input path="b70GetJob" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其中：B69-1 大学本科教育补助人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b691EduAssist" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B71 初中毕业未能升学的新成长劳动力数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b71JunLabor" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B69-2 高职中职学历教育补助人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b692VocAssist" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="fir-td"><span>B71-1 已经参加雨露计划培训人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b711AlrNumber" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B69-3 短期技能培训人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b693ShoSkill" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="fir-td"><span>B72 高中毕业未能升学的新成长劳动力人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b72HighLabor" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B69-4 农民实用技术培训人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b694FarShill" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="fir-td"><span>B72-1 已经参加雨露计划培训人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b721AlrNumber" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				</tbody>
			</table>

			<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>

		</form:form>
		</c:otherwise>
		</c:choose>
	</div>
</div></body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>社会保障管理</title>
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
</head>
<body>



<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>



<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>



<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/countryBasic/">村 基本情况列表</a></li>
	<%--<li><a href="${ctx}/record/sociologyEnsure/">社会保障列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/sociologyEnsure/form?id=${sociologyEnsure.id}">社会保障<shiro:hasPermission name="record:sociologyEnsure:edit">${not empty sociologyEnsure.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:sociologyEnsure:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>



<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${sociologyEnsure.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${sociologyEnsure.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${sociologyEnsure.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${sociologyEnsure.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${sociologyEnsure.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${sociologyEnsure.countryBasicId}">住房情况</a></li>
		<li class="active">社会保障</li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${sociologyEnsure.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${sociologyEnsure.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${sociologyEnsure.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${sociologyEnsure.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${sociologyEnsure.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${sociologyEnsure.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${sociologyEnsure.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${sociologyEnsure.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${sociologyEnsure.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${sociologyEnsure.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${sociologyEnsure.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${sociologyEnsure.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${sociologyEnsure.countryBasicId}">两委班子情况</a></li>
	</ul>



	<div id="tab-7" class="content-detail">
		<c:choose>
		<c:when test="${empty sociologyEnsure.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="sociologyEnsure" action="${ctx}/record/sociologyEnsure/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="countryBasicId"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>
			<table>
				<tbody>
				<tr>
					<td class="fir-td"><span>B40 当年参加新型农村合作医疗人数（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b40MedPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B43 当年参加城乡居民基本养老保险人数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b43InsuPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B41 当年参加新型农村合作医疗的比例（%）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b41MedPro" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
					</td>
					<td class="thr-td"><span>B44 当年参加城乡居民基本养老保险的比例（%）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b44InsuPro" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B42 当年获得医疗救助人次（人次）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b42MedHelp" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="fir-td"><span></span></td>
					<td class="sec-td bg-white">	</td>
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
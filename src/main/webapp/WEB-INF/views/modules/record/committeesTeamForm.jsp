<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>基本公共服务管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();e
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
	<li class="active"><a href="${ctx}/record/countryBasic/form?id=${committeesTeam.countryBasicId}">村 基本情况<shiro:hasPermission name="record:countryBasic:edit">${not empty committeesTeam.countryBasicId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:countryBasic:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${committeesTeam.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${committeesTeam.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${committeesTeam.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${committeesTeam.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${committeesTeam.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${committeesTeam.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${committeesTeam.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${committeesTeam.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${committeesTeam.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${committeesTeam.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${committeesTeam.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${committeesTeam.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${committeesTeam.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${committeesTeam.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${committeesTeam.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${committeesTeam.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${committeesTeam.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${committeesTeam.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${committeesTeam.countryBasicId}">基本公共服务</a></li>
		<li class="active"><a>两委班子情况</a></li>
	</ul>
	<div id="tab-2" class="content-detail">
		<c:choose>
		<c:when test="${empty committeesTeam.countryBasicId}">
			<%--<c:when test="${drinkWater.countryBasicId !=null}">--%>
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="committeesTeam" action="${ctx}/record/committeesTeam/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="countryBasicId"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>
		<table>
			<tbody>
			<tr>
				<td class="fir-td"><span>有无涣散村党组织的情形</span></td>
				<td class="sec-td bg-white">
					<form:radiobuttons path="partyOrganizations" items="${fns:getDictList('yes_no')}" itemValue="value" itemlabel="label"/>
				</td>
				<td class="thr-td"><span>具体情况</span></td>
				<td class="fou-td bg-white">
					<form:input path="situation" htmlEscape="false" maxlength="11" class="input-xlarge"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>整顿情况</span></td>
				<td class="sec-td bg-white">
					<form:radiobuttons path="rectification" items="${fns:getDictList('committees_situation')}" itemValue="value" itemlabel="label"/>
				</td>
				<td class="thr-td"><span></span></td>
				<td class="fou-td bg-white">

				</td>
			</tr>
			</tbody>
		</table><div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>

		</form:form>
		</c:otherwise>
		</c:choose>




</body>
</html>
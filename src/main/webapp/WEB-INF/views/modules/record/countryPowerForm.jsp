<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>农村电力管理</title>
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
		<%--<li><a href="${ctx}/record/countryPower/">农村电力列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/countryPower/form?id=${countryPower.id}">农村电力<shiro:hasPermission name="record:countryPower:edit">${not empty countryPower.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:countryPower:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${countryPower.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${countryPower.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${countryPower.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${countryPower.countryBasicId}">饮水情况</a></li>
		<li class="active"><a>农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${countryPower.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${countryPower.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${countryPower.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${countryPower.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${countryPower.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${countryPower.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${countryPower.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${countryPower.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${countryPower.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${countryPower.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${countryPower.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${countryPower.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${countryPower.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${countryPower.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${countryPower.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-2" class="content-detail">
		<c:choose>
		<c:when test="${empty countryPower.countryBasicId}">
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
	<form:form id="inputForm" modelAttribute="countryPower" action="${ctx}/record/countryPower/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
	<table>
		<tbody>



		<tr>
			<td class="fir-td"><span>未通电的自然村（屯）</span></td>
			<td class="fir-td"><span>B34屯数（个）</span></td>
			<td class="fir-td"><span>B35户数（户）</span></td>
			<td class="fir-td"><span>B36涉及人口数（人）</span></td>
		</tr>
		<tr>
			<td class="fir-td"><span>其中：5户以下</span></td>
			<td class="bg-white">
				<form:input path="b341Village" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b351Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b361Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
		</tr>
		<tr>
			<td class="fir-td"><span>5-10户（含5户）</span></td>
			<td class="bg-white">
				<form:input path="b342Village" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b352Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b362Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
		</tr>
		<tr>
			<td class="fir-td"><span>10-20户（含10户）</span></td>
			<td class="bg-white">
				<form:input path="b343Village" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b353Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b363Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
		</tr>
		<tr>
			<td class="fir-td"><span>20户以上（含20户）</span></td>
			<td class="bg-white">
				<form:input path="b344Village" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b354Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b364Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
		</tr>
		<tr>
			<td class="fir-td"><span>合计</span></td>
			<td class="bg-white">
				<form:input path="b34CountVillage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b35CountHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b36CountPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
		</tr>
		<tr>
			<td class="fir-td"><span>已通电自然村（屯）数（个）</span></td>
			<td class="bg-white">
				<form:input path="b34ElectricityVillage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b35ElectricityHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
			<td class="bg-white">
				<form:input path="b36ElectricityPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</td>
		</tr>
		</tbody>
	</table>
	<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
	</form:form>
		</c:otherwise>
		</c:choose>
</body>
</html>
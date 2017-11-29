<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村民住房管理</title>
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
		<%--<li><a href="${ctx}/record/countryHouse/">村民住房列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/countryHouse/form?id=${countryHouse.id}">村民住房<shiro:hasPermission name="record:countryHouse:edit">${not empty countryHouse.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:countryHouse:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${countryHouse.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${countryHouse.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${countryHouse.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${countryHouse.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${countryHouse.countryBasicId}">农村电力保障</a></li>
		<li class="active">住房情况</li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${countryHouse.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${countryHouse.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${countryHouse.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${countryHouse.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${countryHouse.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${countryHouse.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${countryHouse.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${countryHouse.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${countryHouse.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${countryHouse.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${countryHouse.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${countryHouse.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${countryHouse.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${countryHouse.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-1" class="content-detail">
		<c:choose>
		<c:when test="${empty countryHouse.countryBasicId}">
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
	<form:form id="inputForm" modelAttribute="countryHouse" action="${ctx}/record/countryHouse/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<table>
			<tbody>
			<tr>
				<td class="fir-td"><span>B37 人均稳固住房面积 ：13平方米以下的户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b371Square" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B38 住危房户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b38Danger" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>13-20（含13）平方米的户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b372Square" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B39 无房户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b39Nohouse" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
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
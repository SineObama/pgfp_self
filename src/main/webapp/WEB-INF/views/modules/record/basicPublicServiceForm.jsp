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
	<li class="active"><a href="${ctx}/record/countryBasic/form?id=${basicPublicService.countryBasicId}">村 基本情况<shiro:hasPermission name="record:countryBasic:edit">${not empty basicPublicService.countryBasicId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:countryBasic:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${basicPublicService.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${basicPublicService.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${basicPublicService.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${basicPublicService.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${basicPublicService.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${basicPublicService.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${basicPublicService.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${basicPublicService.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${basicPublicService.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${basicPublicService.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${basicPublicService.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${basicPublicService.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${basicPublicService.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${basicPublicService.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${basicPublicService.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${basicPublicService.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${basicPublicService.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${basicPublicService.countryBasicId}">填表信息</a></li>
		<li class="active">基本公共服务</li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${basicPublicService.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-2" class="content-detail">
		<c:choose>
			<c:when test="${empty basicPublicService.countryBasicId}">
			<%--<c:when test="${drinkWater.countryBasicId !=null}">--%>
				<script>
					alert("请先填写基本情况！");
					window.history.back(-1);
				</script>
			</c:when>
			<c:otherwise>
				<form:form id="inputForm" modelAttribute="basicPublicService" action="${ctx}/record/basicPublicService/save" method="post" class="form-horizontal">
					<form:hidden path="id"/>
					<form:hidden path="countryBasicId"/>
					<form:hidden path="years"/>
					<sys:message content="${message}"/>
					<table>
						<tbody>
						<tr>
							<td class="fir-td"><span>公共服务设施</span></td>
							<td class="sec-td bg-white">
								<form:checkboxes path="serviceFacilitiesList" items="${fns:getDictList('service_facilities')}" itemValue="value" itemlabel="label"/>
							</td>
							<td class="thr-td"><span>其他服务设施</span></td>
							<td class="fou-td bg-white">
								<form:input path="otherFacilities" htmlEscape="false" maxlength="64" class="input-xlarge"/>
							</td>
						</tr>
						<tr>
							<td class="fir-td"><span>网络接通点</span></td>
							<td class="sec-td bg-white">
								<form:radiobuttons path="networkConnectionPoint" items="${fns:getDictList('network_place')}" itemValue="value" itemlabel="label"/>
							</td>
							<td class="thr-td"><span>养老保险参保率(%)</span></td>
							<td class="fou-td bg-white">
								<form:input path="endowmentInsurance" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
							</td>
						</tr>
						<tr>
							<td class="fir-td"><span>60周岁以上参保老年人享受养老保险待遇比例(%)</span></td>
							<td class="sec-td bg-white">
								<form:input path="sixtyYearPercent" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
							</td>
							<td class="thr-td"><span>符合当地农村低保条件的贫困户户数</span></td>
							<td class="fou-td bg-white">
								<form:input path="localLowInsurance" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
							</td>
						</tr>
						<tr>
							<td class="fir-td"><span>其中纳入农村低保的户数</span></td>
							<td class="sec-td bg-white">
								<form:input path="countryLowInsurance" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
							</td>
							<td class="thr-td"><span></span></td>
							<td class="fou-td bg-white">
								<%--<form:input path="" htmlEscape="false" maxlength="11" class="input-xlarge int"/>--%>
							</td>
						</tr>
						</tbody>
					</table><div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>

				</form:form>
			</c:otherwise>
		</c:choose>




</body>
</html>
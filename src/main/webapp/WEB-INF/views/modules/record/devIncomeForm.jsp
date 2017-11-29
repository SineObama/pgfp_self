<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>记录村民收入状况管理</title>
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
		<%--<li><a href="${ctx}/record/devIncome/">记录村民收入状况列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/devIncome/form?id=${devIncome.id}">记录村民收入状况<shiro:hasPermission name="record:devIncome:edit">${not empty devIncome.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:devIncome:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${devIncome.countryBasicId}">基本情况</a></li>
		<li class="active"><a>收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${devIncome.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${devIncome.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${devIncome.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${devIncome.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${devIncome.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${devIncome.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${devIncome.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${devIncome.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${devIncome.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${devIncome.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${devIncome.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${devIncome.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${devIncome.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${devIncome.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${devIncome.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${devIncome.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${devIncome.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${devIncome.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-2" class="content-detail">
		<c:choose>
		<c:when test="${empty devIncome.countryBasicId}">
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="devIncome" action="${ctx}/record/devIncome/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="countryBasicId"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>
		<table>
				<tbody>
				<tr>
					<td>B17 村民主要收入来源（多选）</td>
					<td class="sec-td bg-white">
						<form:checkboxes path="b17SouIncomeList" items="${fns:getDictList('income_sou')}" itemValue="value" itemlabel="label"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;B18-3 人均纯收入1000-2000元（含1000元）（户）</td>
					<td class="bg-white">
						<form:input path="b183Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;其他</td>
					<td class="bg-white">
						<form:input path="other" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;B18-4 人均纯收入1000元以下（户）</td>
					<td class="bg-white">
						<form:input path="b184Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td>B18 农民年人均纯收入（元）</td>
					<td class="bg-white">
						<input id="b18AveIncome" name="b18AveIncome" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${devIncome.b18AveIncome}" pattern="#0.##"/>" />
						<%--<form:input path="b18AveIncome" htmlEscape="false" class="input-xlarge decimal"/>--%>
					</td>
					<td>B19 村集体财产（多选）</td>
					<td class="bg-white">
						<form:checkboxes path="b19AllPropertyList" items="${fns:getDictList('income_sou')}" itemValue="value" itemlabel="label"/>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;其中：B18-1 人均纯收入2800元以上（含2800元）（户）</td>
					<td class="bg-white">
						<form:input path="b181Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;其他</td>
					<td class="bg-white">
						<form:input path="otherPro" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;B18-2 人均纯收入2000-2800元（含2000元）（户）</td>
					<td class="bg-white">
						<form:input path="b182Income" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td>B20 村集体经济收入（元）</td>
					<td class="bg-white">
						<input id="b20AllIncomel" name="b20AllIncomel" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${devIncome.b20AllIncomel}" pattern="#0.##"/>" />
						<%--<form:input path="b20AllIncomel" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>--%>
					</td>
				</tr>
				</tbody>
			</table>
			<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
		</form:form>
		</c:otherwise>
		</c:choose>
	</div>
	</div>
</body>
</html>
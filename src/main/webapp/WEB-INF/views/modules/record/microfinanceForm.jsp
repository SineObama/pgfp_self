<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫小额信贷管理</title>
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
	<%--<li><a href="${ctx}/record/microfinance/">扶贫小额信贷列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/microfinance/form?id=${microfinance.id}">扶贫小额信贷<shiro:hasPermission name="record:microfinance:edit">${not empty microfinance.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:microfinance:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>



<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${cmicrofinance.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${microfinance.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${microfinance.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${microfinance.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${microfinance.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${microfinance.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${microfinance.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${microfinance.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${microfinance.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${microfinance.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${microfinance.countryBasicId}">雨露计划</a></li>
		<li class="active">扶贫小额信贷</li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${microfinance.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${microfinance.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${microfinance.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${microfinance.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${microfinance.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${microfinance.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${microfinance.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${microfinance.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-12" class="content-detail">
		<c:choose>
		<c:when test="${empty microfinance.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="microfinance" action="${ctx}/record/microfinance/save" method="post" class="form-horizontal">		<table>
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
			<table>
			<tbody>
			<tr>
				<td class="fir-td"><span>B73 当年贷款户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b73LoanHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B74 逾期未还款户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="b74Overdue" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B73-1 批复的扶贫小额信贷户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b731Reply" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="thr-td"><span>B75 贷款余额（万元）</span></td>
				<td class="fou-td bg-white">
					<input id="b75LoanBalance" name="b75LoanBalance" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${microfinance.b75LoanBalance}" pattern="#0.##"/>" />
					<%--<form:input path="b75LoanBalance" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>--%>
				</td>
			</tr>
			</tbody>
		</table>
		<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
		</form:form>
			</table>
		</c:otherwise>
		</c:choose>
	</div>
</div></body>
</html>
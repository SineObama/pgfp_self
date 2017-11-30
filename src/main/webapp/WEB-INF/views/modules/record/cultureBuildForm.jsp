<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文化建设管理</title>
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
	<%--<li><a href="${ctx}/record/cultureBuild/">文化建设列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/cultureBuild/form?id=${cultureBuild.id}">文化建设<shiro:hasPermission name="record:cultureBuild:edit">${not empty cultureBuild.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:cultureBuild:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>



<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${cultureBuild.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${cultureBuild.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${cultureBuild.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${cultureBuild.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${cultureBuild.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${cultureBuild.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${cultureBuild.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${cultureBuild.countryBasicId}">卫生状况</a></li>
		<li class="active">文化建设</li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${cultureBuild.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${cultureBuild.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${cultureBuild.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${cultureBuild.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${cultureBuild.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${cultureBuild.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${cultureBuild.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${cultureBuild.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${cultureBuild.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${cultureBuild.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${cultureBuild.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-9" class="content-detail">
		<c:choose>
		<c:when test="${empty cultureBuild.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="cultureBuild" action="${ctx}/record/cultureBuild/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="countryBasicId"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>
			<table>
				<tbody>
				<tr>
					<td class="fir-td"><span>B55 行政村文化（图书）室个数（个）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b55LibraryNum" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B58 是否有村级文娱活动中心</span></td>
					<td class="fou-td bg-white">
						<form:radiobuttons path="b58CivCenter" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B56 是否有村级公共服务中心</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="b56PubService" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="int"/>
					</td>
					<td class="thr-td"><span>B59 未通广播电视的自然村（屯）数</span></td>
					<td class="fou-td bg-white">
						<form:input path="b59NotvVillage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B57 是否有篮球场</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="b57Basketball" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="int"/>
					</td>
					<td class="fir-td"><span>B60 未通广播电视户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b60NotvHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				</tbody>
			</table>
			<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>

		</form:form>
		</c:otherwise>
		</c:choose>
	</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>填表信息管理</title>
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
<script src="${ctxStatic}/ckeditor/adapters/jquery.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/additional-methods.js"></script>
<script src="${ctxStatic}/pgfp/js/jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/countryBasic/">村 基本情况列表</a></li>
	<%--<li><a href="${ctx}/record/tableInfo/">填表信息列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/tableInfo/form?id=${tableInfo.id}">填表信息<shiro:hasPermission name="record:tableInfo:edit">${not empty tableInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:tableInfo:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${tableInfo.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${tableInfo.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${tableInfo.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${tableInfo.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${tableInfo.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${tableInfo.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?icountryBasicId=${tableInfo.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${tableInfo.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${tableInfo.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${tableInfo.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${tableInfo.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${tableInfo.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${tableInfo.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${tableInfo.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${tableInfo.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${tableInfo.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${tableInfo.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li class="active"><a>填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${tableInfo.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${tableInfo.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-17" class="content-detail">
		<c:choose>
		<c:when test="${empty tableInfo.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="tableInfo" action="${ctx}/record/tableInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<form:hidden path="type" value="2"/>
		<sys:message content="${message}"/>
			<table>
				<tbody>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>村委会主任姓名</span></td>
					<td class="sec-td bg-white">
						<form:input path="name" htmlEscape="false" maxlength="50" class="input-xlarge" />
					</td>
					<td class="fir-td" style="text-align: center;"><span>村支书审核人姓名</span></td>
					<td class="sec-td bg-white">
						<form:input path="auditorName" htmlEscape="false" maxlength="50" class="input-xlarge"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>负责人联系电话</span></td>
					<td class="sec-td bg-white">
						<form:input path="moblie" htmlEscape="false" maxlength="20" class="input-xlarge phoneChange"/>
					</td>
					<td class="fir-td" style="text-align: center;"><span>审核人联系电话</span></td>
					<td class="sec-td bg-white">
						<form:input path="auditorMoblie" htmlEscape="false" maxlength="20" class="input-xlarge phoneChange"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>填报人姓名及联系电话</span></td>
					<td colspan="3" class="sec-td bg-white">
						<form:input path="nameMoblie" htmlEscape="false" maxlength="80" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>填表日期</span></td>
					<td colspan="3" class="sec-td bg-white">
						<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							   value="<fmt:formatDate value="${tableInfo.createTime}" pattern="yyyy-MM-dd"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>村民委员会自评意见</span></td>
					<td colspan="3" class="sec-td bg-white">
						<form:input path="selfComment" htmlEscape="false" maxlength="200" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>乡（镇）审核意见</span></td>
					<td colspan="3" class="sec-td bg-white">
						<form:input path="countryComment" htmlEscape="false" maxlength="200" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>县审定意见</span></td>
					<td colspan="3" class="sec-td bg-white">
						<form:input path="countyComment" htmlEscape="false" maxlength="200" class="input-xlarge "/>
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困村信息化管理</title>
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
	<%--<li><a href="${ctx}/record/villageInfo/">贫困村信息化列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/villageInfo/form?id=${villageInfo.id}">贫困村信息化<shiro:hasPermission name="record:villageInfo:edit">${not empty villageInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:villageInfo:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>



<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${villageInfo.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${villageInfo.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${villageInfo.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${villageInfo.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${villageInfo.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${villageInfo.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${villageInfo.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${villageInfo.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${villageInfo.countryBasicId}">文化建设</a></li>
		<li class="active">贫困村信息化</li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${villageInfo.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${villageInfo.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${villageInfo.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${villageInfo.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${villageInfo.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${villageInfo.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${villageInfo.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${villageInfo.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${villageInfo.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${villageInfo.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-10" class="content-detail">
		<c:choose>
		<c:when test="${empty villageInfo.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="villageInfo" action="${ctx}/record/villageInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
			<table>
				<tbody>
				<tr>
					<td class="fir-td"><span>B61 村委会所在地是否通宽带</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="b61BroComm" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</td>
					<td class="thr-td"><span>B65 未通宽带网络的自然村（屯）数（个）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b65NobroVillage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B62 能用手机上网的户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b62PhoHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="thr-td"><span>B66 未通固定电话的自然村（屯）数</span></td>
					<td class="fou-td bg-white">
						<form:input path="b66TelVillage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B63 通宽带的自然村（屯）数（个）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b63BroVillage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="fir-td"><span>B67 行政村信息员（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b67AdmMessage" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B64通宽带户数（户）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b64BroHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="fir-td"><span>B68是否有信息宣传专栏</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="b68InfoColumn" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
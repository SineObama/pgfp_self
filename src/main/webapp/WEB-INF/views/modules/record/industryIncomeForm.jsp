<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>特色产业增收管理</title>
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
	<%--<li><a href="${ctx}/record/industryIncome/">特色产业增收列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/industryIncome/form?id=${industryIncome.id}">特色产业增收<shiro:hasPermission name="record:industryIncome:edit">${not empty industryIncome.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:industryIncome:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>




<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${industryIncome.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${industryIncome.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${industryIncome.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${industryIncome.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${industryIncome.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${industryIncome.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${industryIncome.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${industryIncome.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${industryIncome.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${industryIncome.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${industryIncome.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${industryIncome.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${industryIncome.countryBasicId}">异地扶贫搬迁</a></li>
		<li class="active"><a>特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${industryIncome.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${industryIncome.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${industryIncome.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${industryIncome.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${industryIncome.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${industryIncome.countryBasicId}">两委班子情况</a></li>
	</ul>
	<div id="tab-14" class="content-detail">
		<c:choose>
		<c:when test="${empty industryIncome.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="industryIncome" action="${ctx}/record/industryIncome/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
			<table>
				<tbody>
				<tr>
					<td colspan="2" style="text-align: center;">特色产业类型</td>
					<td class="thr-td"><span>特色产业人均收入（元）</span></td>
					<td class="fou-td bg-white">
						<input id="b84Income" name="b84Income" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${industryIncome.b84Income}" pattern="#0.##"/>" />
						<%--<form:input path="b84Income" htmlEscape="false" class="input-xlarge decimal"/>--%>
					</td>
				</tr>
				<tr>
					<td class="fir-td td-w-100"><span>种植类</span></td>
					<td class="sec-td bg-white">
						<form:input path="b83Planted" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>特色产业农民专业合作社（个）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b85ProCooper" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>中药材类</span></td>
					<td class="sec-td bg-white">
						<form:input path="b83Herbal" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td class="thr-td" ><span>参加特色产业农民专业合作社贫困户数（户）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b86ProHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>养殖类</span></td>
					<td class="sec-td bg-white">
						<form:input path="b83Breed" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>开展乡村旅游的户数（户）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b87TouHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>水果类</span></td>
					<td class="sec-td bg-white">
						<form:input path="b83Fruit" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>乡村旅游从业人员数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b88TouPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>坚果类</span></td>
					<td class="sec-td bg-white">
						<form:input path="b83Nut" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>经营农家乐的户数（户））</span></td>
					<td class="fou-td bg-white">
						<form:input path="b89Agritain" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>其他类</span></td>
					<td class="sec-td bg-white">
						<form:input path="b83Other" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>经营农家乐户年均收入（元）</span></td>
					<td class="fou-td bg-white">
						<%--<input id="b90AveIncome" name="b90AveIncome" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${industryIncome.b90AveIncome}" pattern="#0.##"/>" />--%>
						<form:input path="b90AveIncome" htmlEscape="false" maxlength="11" class="input-xlarge decimal"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>村民合作社名称</span></td>
					<td class="sec-td bg-white">
						<form:input path="cooperativeName" htmlEscape="false" maxlength="64" class="input-xlarge"/>
					</td>
					<td class="thr-td"><span>村民合作社法人</span></td>
					<td class="fou-td bg-white">
							<%--<input id="b90AveIncome" name="b90AveIncome" htmlEscape="false" maxlength="11" class="input-xlarge decimal" style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${industryIncome.b90AveIncome}" pattern="#0.##"/>" />--%>
						<form:input path="cooperativeManage" htmlEscape="false" maxlength="64"  class="input-xlarge"/>
					</td>

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
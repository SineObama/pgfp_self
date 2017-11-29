<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>易地扶贫搬迁（生态移民搬迁）管理</title>


	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>

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




<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/countryBasic/">村 基本情况列表</a></li>
	<%--<li><a href="${ctx}/record/povertyRelocation/">异地扶贫搬迁（生态移民搬迁）列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${povertyRelocation.countryBasicId}">易地扶贫搬迁<shiro:hasPermission name="record:povertyRelocation:edit">${not empty povertyRelocation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:povertyRelocation:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>



<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${povertyRelocation.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${povertyRelocation.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${povertyRelocation.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${povertyRelocation.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${povertyRelocation.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${povertyRelocation.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${povertyRelocation.countryBasicId}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${povertyRelocation.countryBasicId}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${povertyRelocation.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${povertyRelocation.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${povertyRelocation.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${povertyRelocation.countryBasicId}">扶贫小额信贷</a></li>
		<li class="active"><a>易地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${povertyRelocation.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${povertyRelocation.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${povertyRelocation.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${povertyRelocation.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${povertyRelocation.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${povertyRelocation.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${povertyRelocation.countryBasicId}">两委班子情况</a></li>
	</ul>


	<div id="tab-13" class="content-detail">
		<c:choose>
		<c:when test="${empty povertyRelocation.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="povertyRelocation" action="${ctx}/record/povertyRelocation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="countryBasicId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<table>
			<tbody>
			<tr>
				<td class="fir-td"><span>B76 纳入异地扶贫搬迁规划户数（2011-2015）（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b76PlanRelo" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="sec-td"><span>B81 2016-2020年扶贫生态移民搬迁计划</span></td>
				<td class="sec-td" style="text-align: center;"><span>户数（户）</span></td>
				<td class="sec-td" style="text-align: center;"><span>涉及人数（人）</span></td>
			</tr>
			<tr>
				<td class="fir-td"><span>B77搬迁原因</span></td>
				<td class="sec-td bg-white">
					<%--<form:input path="b77ReloReason" htmlEscape="false" maxlength="100" class="input-xlarge"/>--%>
						<form:select path="b77ReloReason">
							<form:option value="" label="------------"/>
							<form:options items="${fns:getDictList('relocation_reasons')}" itemLabel="label" itemValue="value"/>
						</form:select>
				</td>
				<td class="sec-td"><span>贫困户</span></td>
				<td class="sec-td bg-white">
					<form:input path="b81PoorHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="sec-td bg-white">
					<form:input path="b81PoorPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B78 已搬迁户数（2011-2015年）（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b78AlrRelo" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="sec-td"><span> 非贫困户</span></td>
				<td class="sec-td bg-white">
					<form:input path="b81CommHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="sec-td bg-white">
					<form:input path="b81CommPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B79 安置地点</span></td>
				<td class="sec-td bg-white">
					<%--<form:input path="b79SetPlace" htmlEscape="false" maxlength="100" class="input-xlarge"/>--%>
					<form:select path="b79SetPlace">
						<form:option value="" label="------------"/>
						<form:options items="${fns:getDictList('place_of_resettlement')}" itemLabel="label" itemValue="value"/>
					</form:select>
				</td>
				<td class="sec-td"><span> 合计</span></td>
				<td class="sec-td bg-white">
					<form:input path="b81CountHou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="sec-td bg-white">
					<form:input path="b81CountPer" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B80 需整体搬迁的自然村（屯）数（个）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b80WholeRelo" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td class="sec-td"><span>B82 希望安置地点</span></td>
				<td colspan="2" class="sec-td bg-white">
					<%--<form:input path="b82HopePlace" htmlEscape="false" maxlength="100" class="input-xlarge"/>--%>
						<form:select path="b82HopePlace">
							<form:option value="" label="------------"/>
							<form:options items="${fns:getDictList('place_of_resettlement')}" itemLabel="label" itemValue="value"/>
						</form:select>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>B80-1 涉及户数（户）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b801Household" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td colspan="3" class="sec-td bg-white"></td>
			</tr>
			<tr>
				<td class="fir-td"><span>B80-2 涉及人数（人）</span></td>
				<td class="sec-td bg-white">
					<form:input path="b802Person" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
				</td>
				<td colspan="3" class="sec-td bg-white"></td>
			</tr>
			</tbody>
		</table>
		<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
	</div>
	</form:form>
	</c:otherwise>
	</c:choose>
</div>
</body>
</html>
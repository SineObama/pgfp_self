<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>卫生状况管理</title>
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
	<%--<li><a href="${ctx}/record/healthStatus/">卫生状况列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/healthStatus/form?id=${healthStatus.id}">卫生状况<shiro:hasPermission name="record:healthStatus:edit">${not empty healthStatus.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:healthStatus:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>



<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${healthStatus.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${healthStatus.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${healthStatus.countryBasicId}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${healthStatus.countryBasicId}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${healthStatus.countryBasicId}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${healthStatus.countryBasicId}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${healthStatus.countryBasicId}">社会保障</a></li>
		<li class="active">卫生状况</li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${healthStatus.countryBasicId}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${healthStatus.countryBasicId}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${healthStatus.countryBasicId}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${healthStatus.countryBasicId}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${healthStatus.countryBasicId}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${healthStatus.countryBasicId}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${healthStatus.countryBasicId}">驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${healthStatus.countryBasicId}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${healthStatus.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${healthStatus.countryBasicId}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${healthStatus.countryBasicId}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${healthStatus.countryBasicId}">两委班子情况</a></li>
	</ul>


	<div id="tab-8" class="content-detail">
		<c:choose>
		<c:when test="${empty healthStatus.countryBasicId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="healthStatus" action="${ctx}/record/healthStatus/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="countryBasicId"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>
			<table>
				<tbody>
				<tr>
					<td class="fir-td"><span>B45 是否修建政府标准化卫生室</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="b45Clinic" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
					</td>
					<td class="thr-td"colspan="2"style= "text-align:center" ><span>B52 是否配备乡村医生</span></td>
					<td class="fou-td bg-white">
						<form:radiobuttons path="b52CouPhys" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B46 是否配备诊疗设备</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="b46Equipment" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
					</td>
					<td class="thr-td"colspan="2" style= "text-align:center" ><span>B53 乡村医生人数（人）</span></td>
					<td class="fou-td bg-white">
						<form:input path="b53CouNum" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B47 行政村卫生室个数（个）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b47ClinicNum" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="sec-td"><span>B54 到最近就医点看病路程 </span></td>
					<td class="sec-td" style="text-align: center;"><span>户数（户）</span></td>
					<td class="sec-td" style="text-align: center;"><span>人数（人）</span></td>
				</tr>
				<tr>
					<td class="fir-td"><span>B48 行政村公共卫生厕所个数（个）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b48PubClinic" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="sec-td"><span> 5公里以下</span></td>
					<td class="sec-td bg-white">
						<%--<input id="b541Hou" name="b541Hou" htmlEscape="false" maxlength="11" class="input-xlarge decimal"--%>
							   <%--style="border: none;text-align: center;color: #555" value="<fmt:formatNumber value="${b541Hou.b25VtocLength}" pattern="#0.##"/>" />--%>
						<form:input path="b541Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="sec-td bg-white">
						<form:input path="b541Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B49 行政村生产生活垃圾集中堆放点个数（个）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b49TrashNum" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="sec-td"><span> 5-10公里（含5公里）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b542Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="sec-td bg-white">
						<form:input path="b542Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B50 是否配备执业（助理）医师</span></td>
					<td class="sec-td bg-white">
						<form:radiobuttons path="b50PraPhys" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
					</td>
					<td class="sec-td"><span> 10公里以上（含10公里）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b543Hou" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="sec-td bg-white">
						<form:input path="b543Per" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>B51 执业（助理）医师（人）</span></td>
					<td class="sec-td bg-white">
						<form:input path="b51PraNum" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
					</td>
					<td class="sec-td"><span></span></td>
					<td class="sec-td bg-white"></td>
					<td class="sec-td bg-white"></td>
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
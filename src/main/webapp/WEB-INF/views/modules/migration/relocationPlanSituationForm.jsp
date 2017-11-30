<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁情况管理</title>
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
		<li><a href="${ctx}/migration/countryMigrate/">基本情况列表</a></li>
		<%--<li><a href="${ctx}/migration/relocationPlanSituation/">移民搬迁情况列表</a></li>--%>
		<li class="active"><a href="${ctx}/migration/relocationPlanSituation/form?id=${relocationPlanSituation.id}">移民搬迁情况<shiro:hasPermission name="migration:relocationPlanSituation:edit">${not empty relocationPlanSituation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="migration:relocationPlanSituation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/migration/countryMigrate/form?id=${relocationPlanSituation.countryMigrateId}">基本情况</a></li>
		<li class="active">移民搬迁情况</li>
		<li><a href="${ctx}/migration/bNaturalVillageRelocationPlan/form?countryMigrateId=${relocationPlanSituation.countryMigrateId}">移民搬迁规划</a></li>
		<li><a href="${ctx}/migration/bRelocationFinishStatus/form?countryMigrateId=${relocationPlanSituation.countryMigrateId}">任务完成情况</a></li>
		<li><a href="${ctx}/migration/table/form?countryMigrateId=${relocationPlanSituation.countryMigrateId}">填表</a></li>
	</ul>
	<div id="tab-2" class="content-detail">
		<c:choose>
		<c:when test="${empty relocationPlanSituation.countryMigrateId}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
	 <form:form id="inputForm" modelAttribute="relocationPlanSituation" action="${ctx}/migration/relocationPlanSituation/save" method="post" class="form-horizontal">
		    <form:hidden path="id"/>
			<form:hidden path="years"/>
			<form:hidden path="countryMigrateId"/>
		    <sys:message content="${message}"/>

		<table>
			<tbody>
			<tr>
				<td colspan="3" style="text-align: center;font-weight: bold;background-color: #fff;" >
					纳入
					 <input name="beginDate" style="width: 10%;background-color: #fff"  type="text" readonly="readonly" maxlength="20" style="background-color: #fff" class="input-medium Wdate required " value="<fmt:formatDate value='${relocationPlanSituation.yearDate}' pattern='yyyy'/>" onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" /><b>—</b>
					 <input name="endDate" style="width: 10%;background-color: #fff"  type="text" readonly="readonly" maxlength="20" style="background-color: #fff" class="input-medium Wdate required " value="<fmt:formatDate value='${relocationPlanSituation.yearsDate}' pattern='yyyy'/>" onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" />
					年移民搬迁规划计划
			</tr>
			<tr>
				<td class="fir-td"rowspan="2"><span>规划迁入点</span></td>
				<td class="thr-td"><span>模拟安置点名称</span></td>
				<td class="fou-td bg-white"width="50%">
					<form:input path="siteName" htmlEscape="false" maxlength="40" class="input-xlarge required"/>
				</td>
			</tr>
			<tr>
				<td class="thr-td"><span>模拟安置点地址</span></td>
				<td class="fou-td bg-white">
					<form:input path="siteAddress" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"colspan="2"><span>是否整体搬迁</span></td>
				<td class="sec-td bg-white" style="text-align: center">
					<form:radiobuttons path="overallRelocation" items="${fns:getDictList('yes_no')}" itemValue="value" itemlabel="label" />
				</td>
			</tr>
			<tr>
				<td class="fir-td"colspan="2"><span>安置方式</span></td>
				<td class="sec-td bg-white" style="text-align: center">
					<%--<form:select path="siteWay" class="required">--%>
						<%--<form:option value="1">有地安置</form:option>--%>
						<%--<form:option value="2">无地安置</form:option>--%>
					<%--</form:select>--%>
					<%--<form:input path="siteWay" htmlEscape="false" maxlength="20" class="input-xlarge required"/>--%>
					<form:select path="siteWay">
						<form:option value="" label="-----------"/>
						<form:options items="${fns:getDictList('resettlement_type')}" itemLabel="label" itemValue="value"/>
					</form:select>
				</td>
			</tr>
			<tr>
				<td class="fir-td"colspan="2"><span>安置类型</span></td>
				<td class="sec-td bg-white" style="text-align: center">
					<%--<form:input path="siteType" htmlEscape="false" maxlength="20" class="input-xlarge required"/>--%>
					<%--<form:select path="siteType" class="required">--%>
						<%--<form:option value="1">集中安置</form:option>--%>
						<%--<form:option value="2">分散安置</form:option>--%>
					<%--</form:select>--%>
						<form:select path="siteType">
							<form:option value="" label="-----------"/>
							<form:options  items="${fns:getDictList('resettlement_type')}" itemLabel="label" itemValue="value"/>

						</form:select>
				</td>
			</tr>
			<tr>
				<td class="fir-td"colspan="2"><span>规划安置类型</span></td>
				<td class="sec-td bg-white" style="text-align: center">

						<form:select path="planSiteType">
							<form:option value="" label="-----------"/>
							<form:options  items="${fns:getDictList('place_of_resettlement')}" itemLabel="label" itemValue="value"/>

						</form:select>
				</td>
			</tr>
			<tr>
				<td class="fir-td"rowspan="4"><span>纳入规划总户数</span></td>
				<td class="thr-td"><span>总户数（户）</span></td>
				<td class="fou-td bg-white" style="text-align: center">
					<form:input path="planTotalHou" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
				</td>
			</tr>
			<tr>
				<td class="thr-td"><span>总人数（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="planTotalPer" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
				</td>
			</tr>
			<tr>
				<td class="thr-td"><span>其中建档立卡户（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="recordHou" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
				</td>
			</tr>
			<tr>
				<td class="thr-td"><span>其中建档立卡人数（人）</span></td>
				<td class="fou-td bg-white">
					<form:input path="recordPer" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
				</td>
			</tr>
		</table>

		<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
	</div>
	</form:form>
	</c:otherwise>
	</c:choose>
</body>
</html>
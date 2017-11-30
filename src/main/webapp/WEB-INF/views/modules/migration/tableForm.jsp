<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>填表管理</title>
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
	<%--<li><a href="${ctx}/migration/table/">填表列表</a></li>--%>
	<li class="active"><a href="${ctx}/migration/table/form?id=${tableInfo.id}">填表<shiro:hasPermission name="migration:table:edit">${not empty tableInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="migration:table:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/migration/countryMigrate/form?id=${tableInfo.countryMigrateId}">基本情况</a></li>
		<li><a href="${ctx}/migration/relocationPlanSituation/form?countryMigrateId=${tableInfo.countryMigrateId}">移民搬迁情况</a></li>
		<li><a href="${ctx}/migration/bNaturalVillageRelocationPlan/form?countryMigrateId=${tableInfo.countryMigrateId}">移民搬迁规划</a></li>
		<li><a href="${ctx}/migration/bRelocationFinishStatus/form?countryMigrateId=${tableInfo.countryMigrateId}">任务完成情况</a></li>
		<li class="active">填表</li>
	</ul>
	<div id="tab-5" class="content-detail">
		<c:choose>
			<c:when test="${empty tableInfo.countryMigrateId}">
				<script>
					alert("请先填写基本情况！");
					window.history.back(-1);
				</script>
			</c:when>
			<c:otherwise>
				<form:form id="inputForm" modelAttribute="tableInfo" action="${ctx}/migration/table/save" method="post" class="form-horizontal">
					<form:hidden path="id"/>
					<form:hidden path="years"/>
					<form:hidden path="type" value="1"/>
					<form:hidden path="countryMigrateId"/>
					<sys:message content="${message}"/>
					<table>
						<tbody>
						<tr>
							<td class="fir-td"width="10%"><span>负责人</span></td>
							<td class="fou-td bg-white" >
								<form:input path="name" htmlEscape="false" maxlength="20" class="input-xlarge required "/>
							</td>
							<td class="fir-td"width="10%"><span>负责人联系电话</span></td>
							<td class="fou-td bg-white" >
								<form:input path="moblie" htmlEscape="false" maxlength="20" class="input-xlarge required  phoneChange"/>
							</td>
						</tr>
						<tr>
							<td class="thr-td" width="10%"><span>审核人</span></td>
							<td class="fou-td bg-white" >
								<form:input path="auditorName" htmlEscape="false" maxlength="20" class="input-xlarge required "/>
							</td>
							<td class="thr-td" width="10%"><span>审核人联系电话</span></td>
							<td class="fou-td bg-white" >
								<form:input path="auditorMoblie" htmlEscape="false" maxlength="20" class="input-xlarge required  phoneChange"/>
							</td>
						</tr>
						<tr>
							<td class="fir-td"><span>填表人姓名及电话（可填写多个）</span></td>
							<td class="sec-td bg-white"colspan="3">
								<form:input path="nameMoblie" htmlEscape="false" maxlength="80" class="input-xlarge required "/>
							</td>
						</tr>
						<tr>
							<td class="fir-td"><span>填表日期</span></td>
							<td class="sec-td bg-white"colspan="3">
								<input name="createTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
									   value="<fmt:formatDate value='${tableInfo.createTime}' pattern='yyyy-MM-dd'/>"
									   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>

							</td>
						</tr>

					</table>

					<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
				</form:form>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</body>
</html>
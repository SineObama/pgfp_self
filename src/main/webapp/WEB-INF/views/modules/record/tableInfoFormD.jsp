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
		<li><a href="${ctx}/record/natureBaseCountryBasic/">自然村建档立卡基本情况列表</a></li>
	<%--<li><a href="${ctx}/record/tableInfo/">填表信息列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/tableInfo/formD?countryBasicId=${tableInfo.countryBasicId}">填表信息<shiro:hasPermission name="record:tableInfo:edit">${not empty tableInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:tableInfo:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/natureBaseCountryBasic/form?id=${tableInfo.countryBasicId}">基本情况</a></li>
		<li><a href="${ctx}/record/natureBaseDevIncome/form?countryBasicId=${tableInfo.countryBasicId}">收入状况</a></li>
		<li><a href="${ctx}/record/natureBaseIndustryIncome/form?countryBasicId=${tableInfo.countryBasicId}">产业状况</a></li>
		<li><a href="${ctx}/record/infrastructureSituation/form?countryBasicId=${tableInfo.countryBasicId}">基础设施状况</a></li>
		<li><a href="${ctx}/record/demandAndSituation/formD?countryBasicId=${tableInfo.countryBasicId}">帮扶需求及帮扶情况</a></li>
		<li class="active"><a>填表信息</a></li>
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
		<form:form id="inputForm" modelAttribute="tableInfo" action="${ctx}/record/tableInfo/saveD" method="post" class="form-horizontal">
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
							   value="<fmt:formatDate value="${tableInfo.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>自然村（屯）自评意见</span></td>
					<td colspan="3" class="sec-td bg-white">
						<form:input path="selfComment" htmlEscape="false" maxlength="200" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="fir-td" style="text-align: center;"><span>行政村审核意见</span></td>
					<td colspan="3" class="sec-td bg-white">
						<form:input path="countryComment" htmlEscape="false" maxlength="200" class="input-xlarge "/>
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
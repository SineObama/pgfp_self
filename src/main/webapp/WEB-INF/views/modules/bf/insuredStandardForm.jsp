<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>城乡居民参保标准管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bf/insuredStandard/">城乡居民参保标准</a></li>
		<li class="active"><a href="${ctx}/bf/insuredStandard/form?id=${insuredStandard.id}">城乡居民参保标准<shiro:hasPermission name="bf:insuredStandard:edit">${not empty insuredStandard.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:insuredStandard:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="insuredStandard" action="${ctx}/bf/insuredStandard/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="content-detail" style="float: none;min-height: 0;border-left: none">
			<table style="border: 0px #FFFFFF;">
				<tbody>
				<tr>
					<td class="fir-td"><span></span></td>
					<td class="sec-td">
						<span>金额标准</span>
					</td>
					<td class="thr-td"><span>报销比例标准(%)</span></td>
				</tr>
				<tr>
					<td class="fir-td"><span>城乡居民基本医疗保险</span></td>
					<td class="sec-td bg-white">
						<form:input path="medicalInsuranceMoney" htmlEscape="false" maxlength="20" class="input-xlarge number"/>
					</td>
					<td class="thr-td bg-white">
						<form:input path="medicalInsuranceRate" htmlEscape="false" maxlength="20" class="input-xlarge number"/>
					</td>
				</tr>
				<tr>
					<td class="fir-td"><span>城乡居民基本养老保险</span></td>
					<td class="sec-td bg-white">
						<form:input path="endowmentInsuranceMoney" htmlEscape="false" maxlength="20" class="input-xlarge number"/>
					</td>
					<td class="thr-td bg-white">
						<form:input path="endowmentInsuranceRate" htmlEscape="false" maxlength="20" class="input-xlarge number"/>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bf:insuredStandard:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶政策管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")){
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
		<li><a href="${ctx}/bf/bfSubsidyType/">帮扶政策列表</a></li>
		<li class="active"><a href="${ctx}/bf/bfSubsidyType/form?id=${bfSubsidyType.id}&parent.id=${bfSubsidyTypeparent.id}">帮扶政策<shiro:hasPermission name="bf:bfSubsidyType:edit">${not empty bfSubsidyType.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfSubsidyType:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bfSubsidyType" action="${ctx}/bf/bfSubsidyType/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">上级父类型:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${bfSubsidyType.parent.id}" labelName="parent.subsidyType" labelValue="${bfSubsidyType.parent.subsidyType}"
					title="父类型" url="/bf/bfSubsidyType/treeData" extId="${bfSubsidyType.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">编码:</label>
			<div class="controls">
				<form:input path="code" htmlEscape="false" maxlength="20" cssClass="input-month"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">补贴类型：</label>
			<div class="controls">
				<form:input path="subsidyType" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">责任部门：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${bfSubsidyType.office.id}" labelName="office.name" labelValue="${bfSubsidyType.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">补助对象或条件：</label>
			<div class="controls">
				<form:textarea path="subsidyCondition" htmlEscape="false" maxlength="512" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">补助标准或内容：</label>
			<div class="controls">
				<form:textarea path="subsidyContent" htmlEscape="false" maxlength="1024" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bf:bfSubsidyType:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
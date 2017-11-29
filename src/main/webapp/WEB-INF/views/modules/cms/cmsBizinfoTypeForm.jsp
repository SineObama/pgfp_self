<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产业信息类别管理管理</title>
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
		<li><a href="${ctx}/cms/cmsBizinfoType/">产业信息类别管理列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsBizinfoType/form?id=${cmsBizinfoType.id}&parent.id=${cmsBizinfoTypeparent.id}">产业信息类别管理<shiro:hasPermission name="cms:cmsBizinfoType:edit">${not empty cmsBizinfoType.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsBizinfoType:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmsBizinfoType" action="${ctx}/cms/cmsBizinfoType/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">类别名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">描述：</label>
			<div class="controls">
				<form:input path="description" htmlEscape="false" maxlength="128" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">排序（升序）：</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" class="input-xlarge  digits"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">上级父级编号:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${cmsBizinfoType.parent.id}" labelName="parent.name" labelValue="${cmsBizinfoType.parent.name}"
					title="父级编号" url="/cms/cmsBizinfoType/treeData" extId="${cmsBizinfoType.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">归属机构：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${cmsBizinfoType.office.id}" labelName="office.name" labelValue="${cmsBizinfoType.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:cmsBizinfoType:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
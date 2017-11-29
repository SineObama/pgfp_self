<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>行政、自然区划管理</title>
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
		<li><a href="${ctx}/record/country/">行政、自然区划列表</a></li>
		<li class="active"><a href="${ctx}/record/country/form?id=${country.id}&parent.id=${countryparent.id}">行政、自然区划<shiro:hasPermission name="record:country:edit">${not empty country.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:country:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="country" action="${ctx}/record/country/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级区域:</label>
			<div class="controls">
				<sys:treeselect id="parent" name="parent.id" value="${country.parent.id}" labelName="parent.name" labelValue="${country.parent.name}"
					title="上级行政区划" url="/record/country/treeData" extId="${country.id}" cssClass="" allowClear="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">名字：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="40" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">级别：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('contryType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">分类：</label>
			<div class="controls">
				<form:radiobuttons path="classify" items="${fns:getDictList('contryClassify')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<form:textarea id="introduce" htmlEscape="true" path="introduce" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="introduce" uploadPath="/cms/article" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge"/>
				<%--<span class="help-inline"><font color="red">*</font> </span>--%>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="record:country:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>apk管理管理</title>
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/sys/apkManage/">移动终端列表</a></li>
		<li class="active"><a href="${ctx}/sys/apkManage/form?id=${apkManage.id}">移动终端管理<shiro:hasPermission name="sys:apkManage:edit">${not empty apkManage.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="sys:apkManage:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="apkManage" action="${ctx}/sys/apkManage/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">类别：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('mt_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文件名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">下载地址：</label>
			<div class="controls">
				<form:input path="downloadHref" htmlEscape="false" maxlength="255" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">版本号：</label>
			<div class="controls">
				<form:input path="version" htmlEscape="true" maxlength="200" class="input-mini required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否需要强制更新:</label>
				<div class="controls">
					<form:radiobuttons path="forceUpdate" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
					<span class="help-inline"></span>
				</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否需要提示更新:</label>
			<div class="controls">
				<form:radiobuttons path="needUpdate" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">安装文件：</label>
			<div class="controls">
				<form:hidden id="appFile" path="appFile" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<sys:ckfinder input="appFile" type="files" uploadPath="/app/mt" selectMultiple="false"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">权重，越大越靠前：</label>
			<div class="controls">
				<form:input path="weight" htmlEscape="false" maxlength="200" class="input-mini required digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">权重期限：</label>
			<div class="controls">
				<input name="weightDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${apkManage.weightDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发布状态:</label>
			<div class="controls">
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:apkManage:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
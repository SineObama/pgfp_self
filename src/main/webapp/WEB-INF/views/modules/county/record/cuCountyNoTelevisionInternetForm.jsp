<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>县未有电视机且未有智能手机上网名单管理</title>
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
		<li><a href="${ctx}/record/cuCountyNoTelevisionInternet/">县未有电视机且未有智能手机上网名单列表</a></li>
		<li class="active"><a href="${ctx}/record/cuCountyNoTelevisionInternet/form?id=${cuCountyNoTelevisionInternet.id}">县未有电视机且未有智能手机上网名单<shiro:hasPermission name="record:cuCountyNoTelevisionInternet:edit">${not empty cuCountyNoTelevisionInternet.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:cuCountyNoTelevisionInternet:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cuCountyNoTelevisionInternet" action="${ctx}/record/cuCountyNoTelevisionInternet/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">关联档案表：</label>
			<div class="controls">
				<form:input path="cuTableId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">镇id：</label>
			<div class="controls">
				<form:input path="townId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">村id：</label>
			<div class="controls">
				<form:input path="villageId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">屯id：</label>
			<div class="controls">
				<form:input path="tunId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">没有电视机且没有电脑或者智能手机上网户主：</label>
			<div class="controls">
				<form:input path="householdName" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">家庭人口数：</label>
			<div class="controls">
				<form:input path="familyMember" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">未有原因：</label>
			<div class="controls">
				<form:input path="reason" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="record:cuCountyNoTelevisionInternet:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
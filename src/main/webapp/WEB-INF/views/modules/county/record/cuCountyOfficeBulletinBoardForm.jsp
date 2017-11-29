<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>县行政村办公成所、宣传栏情况表管理</title>
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
		<li><a href="${ctx}/record/cuCountyOfficeBulletinBoard/">县行政村办公成所、宣传栏情况表列表</a></li>
		<li class="active"><a href="${ctx}/record/cuCountyOfficeBulletinBoard/form?id=${cuCountyOfficeBulletinBoard.id}">县行政村办公成所、宣传栏情况表<shiro:hasPermission name="record:cuCountyOfficeBulletinBoard:edit">${not empty cuCountyOfficeBulletinBoard.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:cuCountyOfficeBulletinBoard:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cuCountyOfficeBulletinBoard" action="${ctx}/record/cuCountyOfficeBulletinBoard/save" method="post" class="form-horizontal">
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
			<label class="control-label">办公场地结构：</label>
			<div class="controls">
				<form:input path="officeStructure" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">办公场地面积：</label>
			<div class="controls">
				<form:input path="officeArea" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宣传栏数量：</label>
			<div class="controls">
				<form:input path="bulletinBoardNum" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宣传栏面积：</label>
			<div class="controls">
				<form:input path="bulletinBoardArea" htmlEscape="false" class="input-xlarge  number"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="record:cuCountyOfficeBulletinBoard:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
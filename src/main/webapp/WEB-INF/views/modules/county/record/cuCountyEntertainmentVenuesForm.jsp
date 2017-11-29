<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>县行政村有篮球场、文化室（农家书屋）或戏台情况表管理</title>
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
		<li><a href="${ctx}/record/cuCountyEntertainmentVenues/">县行政村有篮球场、文化室（农家书屋）或戏台情况表列表</a></li>
		<li class="active"><a href="${ctx}/record/cuCountyEntertainmentVenues/form?id=${cuCountyEntertainmentVenues.id}">县行政村有篮球场、文化室（农家书屋）或戏台情况表<shiro:hasPermission name="record:cuCountyEntertainmentVenues:edit">${not empty cuCountyEntertainmentVenues.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:cuCountyEntertainmentVenues:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cuCountyEntertainmentVenues" action="${ctx}/record/cuCountyEntertainmentVenues/save" method="post" class="form-horizontal">
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
			<label class="control-label">篮球场个数：</label>
			<div class="controls">
				<form:input path="basketballCourtNum" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">文化室个数：</label>
			<div class="controls">
				<form:input path="culturalRoomNum" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">农家书屋个数：</label>
			<div class="controls">
				<form:input path="ruralLibraryNum" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">戏台个数：</label>
			<div class="controls">
				<form:input path="stageNum" htmlEscape="false" maxlength="8" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="record:cuCountyEntertainmentVenues:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
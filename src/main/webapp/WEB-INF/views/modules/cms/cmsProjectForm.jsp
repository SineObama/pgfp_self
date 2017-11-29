<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目档案管理</title>
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
			<li><a href="${ctx}/cms/cmsProject/">项目信息列表</a></li>
			<li class="active"><a href="${ctx}/cms/cmsProject/form?id=${cmsProject.id}">项目信息<shiro:hasPermission name="cms:cmsProject:edit">${not empty cmsProject.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsProject:edit">查看</shiro:lacksPermission></a></li>
			<c:if test="${cmsProject ne null && cmsProject.id ne null && cmsProject.id ne ''}">
			<li class=""><a href="${ctx}/cms/cmsProject/print?id=${cmsProject.id}" target="_blank">打印扶贫项目信息</a></li>
			</c:if>
		</ul><br/>
	<form:form id="inputForm" modelAttribute="cmsProject" action="${ctx}/cms/cmsProject/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">监管单位：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${cmsProject.office.id}" labelName="office.name" labelValue="${cmsProject.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目类别：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('project_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">帮扶政策：</label>--%>
			<%--<div class="controls">--%>
			<%--<sys:treeselect id="subsidyType" name="subsidyType.id" value="${cmsProject.subsidyType.id}" labelName="subsidyType.subsidyType" labelValue="${cmsProject.subsidyType.subsidyType}"--%>
							<%--title="帮扶政策" url="/bf/bfSubsidyType/treeData" cssClass="input-large" allowClear="true" notAllowSelectParent="false"/>--%>
			<%--</div>--%>
		<%--</div>--%>
		<div class="control-group">
			<label class="control-label">项目名称：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">承建单位：</label>
			<div class="controls">
				<form:input path="constructionUnit" htmlEscape="false" maxlength="200" class="input-xlarge "/>
			</div>
		</div>


		<div class="control-group">
			<label class="control-label">建设地点：</label>
			<div class="controls">
				<%--<form:input path="address" htmlEscape="false" maxlength="1000" class="input-xlarge required"/>--%>
					<sys:treeselect id="address" name="address.id" value="${cmsProject.address.id}" labelName="address.name" labelValue="${cmsProject.address.name}"
									title="区域地点" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>
					<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">建设内容：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="6000" class="input-xxlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">投资估算：</label>
			<div class="controls">
				<form:input path="amount" htmlEscape="false" class="input-large required"/>
				<span class="help-inline"><font color="black">元</font><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划建设时间：</label>
			<div class="controls">
				<input name="scheduleTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${cmsProject.scheduleTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开工日期：</label>
			<div class="controls">
				<input name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${cmsProject.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">完成状态：</label>
			<div class="controls">
				<%--<form:input path="finishedState" htmlEscape="false" maxlength="1" class="input-xlarge required"/>--%>
				<form:radiobuttons path="finishedState" items="${fns:getDictList('finishedState')}" itemValue="value" itemLabel="label" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">验收结果：</label>
			<div class="controls">
					<%--<form:input path="checkFlag" htmlEscape="false" maxlength="1" class="input-xlarge "/>--%>
				<form:radiobuttons path="checkFlag" items="${fns:getDictList('checkFlag')}" itemValue="value" itemLabel="label"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">合同文件：</label>
			<div class="controls">
				<form:hidden id="contractPath" path="contractPath" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="contractPath" type="files" uploadPath="/cms/cmsProject" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">资金报帐资料文件：</label>
			<div class="controls">
				<form:hidden id="balancePath" path="balancePath" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="balancePath" type="files" uploadPath="/cms/cmsProject" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工程形象和照片展示：</label>
			<div class="controls">
					<%--<form:input path="finishedState" htmlEscape="false" maxlength="1" class="input-xlarge required"/>--%>
						<form:textarea id="articleDataContent" path="articleData.content" htmlEscape="false" rows="4" maxlength="200" class="input-large required"/>
						<sys:ckeditor replace="articleDataContent" uploadPath="/cms/cmsProject" />
			</div>
		</div>



		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:cmsProject:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<%--<input id="printCancel" type="button" class="btn btn-primary" value="返回预览"/>&nbsp;--%>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
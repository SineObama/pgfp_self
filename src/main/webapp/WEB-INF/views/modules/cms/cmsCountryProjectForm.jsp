<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫项目库清单管理</title>
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
   <%-- <style>
        form controls {
            height: 30px;
        }
    </style>--%>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/cms/cmsCountryProject/">扶贫项目库清单列表</a></li>
	<li class="active"><a href="${ctx}/cms/cmsCountryProject/form?id=${cmsCountryProject.id}">扶贫项目库清单<shiro:hasPermission name="cms:cmsCountryProject:edit">${not empty cmsCountryProject.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsCountryProject:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="cmsCountryProject" action="${ctx}/cms/cmsCountryProject/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<form:hidden path="cmsProjectId" />
	<div class="control-group">
		<label class="control-label">监管单位：</label>
		<div class="controls">
			<sys:treeselect id="office" name="cmsProject.office.id" value="${cmsCountryProject.cmsProject.office.id}" labelName="cmsProject.office.name"
							labelValue="${cmsCountryProject.cmsProject.office.name}" title="部门" url="/sys/office/treeData?type=2" cssClass="required"
							allowClear="true" notAllowSelectParent="true" />
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">项目类别：</label>
		<div class="controls">
			<form:select path="cmsProject.type" class="input-xlarge required">
				<form:option value="" label=""/>
				<form:options items="${fns:getDictList('project_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">项目名称：</label>
		<div class="controls">
			<form:input path="cmsProject.title" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">建设地点：</label>
		<div class="controls">
				<%--<form:input path="address" htmlEscape="false" maxlength="1000" class="input-xlarge required"/>--%>
			<sys:treeselect id="address" name="cmsProject.address.id" value="${cmsCountryProject.cmsProject.address.id}" labelName="address.name" labelValue="${cmsCountryProject.cmsProject.address.name}"
							title="区域地点" url="/sys/area/treeDataNatrue" extId="${area.id}" cssClass="" allowClear="true"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">建设内容：</label>
		<div class="controls">
			<form:textarea path="cmsProject.content" htmlEscape="false" rows="4" maxlength="6000" class="input-xxlarge required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<%--</div>--%>

	<div class="control-group">
		<label class="control-label">投资估算：</label>
		<div class="controls">
			<form:input path="cmsProject.amount" htmlEscape="false" class="input-large required"/>
			<span class="help-inline"><font color="black">元</font><font color="red">*</font> </span>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label">政府补助资金（万）：</label>
		<div class="controls">
			<form:input path="governmentSubsidy" htmlEscape="false" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">投资（补助）标准（万）：</label>
		<div class="controls">
			<form:input path="subsidyStandards" htmlEscape="false" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">资金性质：</label>
		<div class="controls">
			<form:input path="capitalNature" htmlEscape="false" maxlength="20" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">计划建设时间：</label>
		<div class="controls">
			<%--<input name="scheduleTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
				   value="<fmt:formatDate value="${cmsCountryProject.scheduleTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			<span class="help-inline"><font color="red">*</font> </span>--%>
			<form:input path="scheduleTime" htmlEscape="false" maxlength="20" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">受益村名（可填多个）：</label>
		<%--<div class="controls">
			<form:input path="benefitCountry" htmlEscape="false" maxlength="2000" class="input-xlarge "/>
		</div>--%>
		<div class="controls">
					<%--<form:input path="address" htmlEscape="false" maxlength="1000" class="input-xlarge required"/>--%>
			<sys:treeselect id="benefitCountry" name="address.id" value="${cmsCountryProject.address.id}" labelName="address.name" labelValue="${cmsCountryProject.address.name}"
				                title="区域地点" url="/sys/area/treeDataNatrue" extId="${area.id}" cssClass="required"  allowClear="true" checked="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">受益村数（个）：</label>
		<div class="controls">
			<form:input path="benefitCountryNumber" htmlEscape="false" maxlength="11" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">其中贫困村（个）：</label>
		<div class="controls">
			<form:input path="povertyCountryNumber" htmlEscape="false" maxlength="11" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">受益贫困户（户）：</label>
		<div class="controls">
			<form:input path="benefitPovertyHouse" htmlEscape="false" maxlength="11" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">受益贫困人口（人）：</label>
		<div class="controls">
			<form:input path="benefitPovertyPopulation" htmlEscape="false" maxlength="11" class="input-xlarge "/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">描述简况：</label>
		<div class="controls">
			<form:textarea path="describe" htmlEscape="false" rows="4" maxlength="6000" class="input-xxlarge required"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">完成状态：</label>
		<div class="controls">
			<form:radiobuttons path="cmsProject.finishedState" items="${fns:getDictList('finishedState')}" itemValue="value" itemLabel="label" class="required"/>
			<span class="help-inline"><font color="red">*</font> </span>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">验收结果：</label>
		<div class="controls">
			<form:radiobuttons path="cmsProject.checkFlag" items="${fns:getDictList('checkFlag')}" itemValue="value" itemLabel="label"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">合同文件：</label>
		<div class="controls">
			<form:hidden id="contractPath" path="cmsProject.contractPath" htmlEscape="false" maxlength="200" class="input-xlarge"/>
			<sys:ckfinder input="contractPath" type="files" uploadPath="/cms/cmsCountryProject" selectMultiple="true"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">资金报帐资料文件：</label>
		<div class="controls">
			<form:hidden id="balancePath" path="cmsProject.balancePath" htmlEscape="false" maxlength="200" class="input-xlarge"/>
			<sys:ckfinder input="balancePath" type="files" uploadPath="/cms/cmsCountryProject" selectMultiple="true"/>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">备注信息：</label>
		<div class="controls">
			<form:textarea path="cmsProject.remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
		</div>
	</div>
	<div class="form-actions">
		<shiro:hasPermission name="cms:cmsCountryProject:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>储备项目汇总表管理</title>
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
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<%--<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>--%>

	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/cmsReserveProject/">储备项目汇总表列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsReserveProject/form?id=${cmsReserveProject.id}">储备项目汇总表<shiro:hasPermission name="cms:cmsReserveProject:edit">${not empty cmsReserveProject.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsReserveProject:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmsProject" action="${ctx}/cms/cmsReserveProject/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="projectType" value="1"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">监管单位：</label>
			<div class="controls">
				<sys:treeselect id="office" name="office.id" value="${cmsProject.office.id}" labelName="office.name" labelValue="${cmsProject.office.name}"
								title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
				<span hidden="hidden" class="errorinfo" id="error2" style="color:red;">请输入主管部门信息</span>
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
				<span hidden="hidden" class="errorinfo" id="error3" style="color:red;">请输入项目类别信息</span>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">项目名称：</label>
			<div class="controls">
				<form:input path="reserve.title" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">实施地点（县乡村）：</label>

			<div class="controls">
				<sys:treeselect id="address" name="address.id" value="${cmsProject.address.id}" labelName="address.name" labelValue="${cmsProject.address.name}"
								title="区域地点" url="/sys/area/treeDataNatrue" extId="${area.id}" cssClass="required"  allowClear="true" checked="true" notAllowSelectParent="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
				<span hidden="hidden" class="errorinfo" id="error1" style="color:red;">请输入实施地点信息</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">建设内容：</label>
			<div class="controls">
				<form:input path="content" htmlEscape="false" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划总投资（万元）：</label>
			<div class="controls">
				<form:input path="reserve.totalMoney" cssStyle="width: 100px;" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">其中政府补助资金（万元）：</label>
			<div class="controls">
				<form:input path="reserve.subsidyMonry" cssStyle="width: 100px;" maxlength="11" htmlEscape="false" class="input-xlarge decimal"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">投资（补助）标准：</label>
			<div class="controls">
				<form:input path="reserve.subsidyStandard" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">资金性质：</label>
			<div class="controls">
				<form:input path="reserve.natureFunds" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">可研报告（描述简况/不涉及）：</label>
			<div class="controls">
				<form:input path="reserve.feasibilityStudy" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">初步设计（描述简况/不涉及）：</label>
			<div class="controls">
				<form:input path="reserve.preliminaryDesign" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">施工图设计（描述简况/不涉及）：</label>
			<div class="controls">
				<form:input path="reserve.constructionDesign" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用地落实（描述简况/不涉及）：</label>
			<div class="controls">
				<form:input path="reserve.landUse" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">环评审批（描述简况/不涉及）：</label>
			<div class="controls">
				<form:input path="reserve.eiaApproval" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">前期工作是否完成（是否）：</label>
			<div class="controls">
				<form:radiobuttons path="reserve.complete" items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计划实施年度：</label>
			<%--<div class="controls">--%>
				<%--<form:input path="reserve.planYear" htmlEscape="false" maxlength="10" class="input-xlarge "/>--%>
			<%--</div>--%>
			<div class="controls">
				<input name="reserve.planYear" id="planYear" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					   value="<fmt:formatDate value="${cmsProject.reserve.yearDate}" pattern="yyyy"/>"
					   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目建设状态：</label>
			<div class="controls">
				<form:radiobuttons  path="finishedState" items="${fns:getDictList('finishedState')}"
									itemLabel="label" itemValue="value"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">受益村名（可填多个）：</label>
			<div class="controls">
				<sys:treeselect id="benefitCountry" name="reserve.benefitCountry.id" value="${cmsProject.reserve.benefitCountry.id}" labelName="benefitCountry.name" labelValue="${cmsProject.reserve.benefitCountry.name}"
								title="区域地点" url="/sys/area/treeDataNatrue" extId="${area.id}"  allowClear="true" checked="true" notAllowSelectParent="true"/>
				<%--<form:textarea path="reserve.benefitCountry" htmlEscape="false" maxlength="2000" class="input-xlarge "/>--%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">受益村数（个）：</label>
			<div class="controls">
				<form:input path="reserve.benefitNumber" cssStyle="width:80px" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">其中贫困村（个）：</label>
			<div class="controls">
				<form:input path="reserve.poorNumber" cssStyle="width:80px" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">受益贫困户（户）：</label>
			<div class="controls">
				<form:input path="reserve.benefitPoorHou" cssStyle="width:80px" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">益贫困人口(人)：</label>
			<div class="controls">
				<form:input path="reserve.benefitPoorPer" cssStyle="width:80px" htmlEscape="false" maxlength="8" class="input-xlarge int"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目对对应的脱贫指标贡献情况（描述简况）：</label>
			<div class="controls">
				<form:textarea path="reserve.descriptionBrief" htmlEscape="false" maxlength="500" class="input-xxlarge " rows="4"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目编号：</label>
			<div class="controls">
				<form:input path="reserve.projectNumber" htmlEscape="false" maxlength="64" class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">入库时间：</label>
			<div class="controls">
				<input name="reserve.storageTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${cmsProject.reserve.timeTemp}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
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
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="cms:cmsReserveProject:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
<script>
	$(document).ready(function(){
		$("#inputForm").submit(function(){
			//获得表单值
			var address=$("#addressName").val();
			var type=$("#type").val();
			var officeName = $("#officeName").val();
			//如果表单为空，提示用户
			if(address==""){
				//显示错误提示信息
				//$("#address").addClass("redborder");
				$("#error1").show();
			}else{
				$("#error1").hide();
			}
            if(officeName == ""){
				//$("#type").addClass("redborder");
				$("#error2").show();
			}else{
				$("#error2").hide();
			}
			if(type==""){
				//$("#type").addClass("redborder");
				$("#error3").show();
			}else{
				$("#error3").hide();
			}
			return true;
		});
	});
</script>
</body>

</html>

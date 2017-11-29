<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业信息管理</title>
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
		
		top.mainFrame.companyIndustryAddOrDel = function(value){
			$("#companyIndustry").val(value);
		}
		
		function getCompanyIndustry(){
			top.$.jBox.open("iframe:${ctx}/bf/bfCompanyInfo/selectIndustryList", "添加行业",$(top.document).width()-720,$(top.document).height()-180,{
				buttons:{"确定":true}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bf/bfCompanyInfo/">企业信息列表</a></li>
		<li class="active"><a href="${ctx}/bf/bfCompanyInfo/form?id=${bfCompanyInfo.id}">企业信息<shiro:hasPermission name="bf:bfCompanyInfo:edit">${not empty bfCompanyInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfCompanyInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bfCompanyInfo" action="${ctx}/bf/bfCompanyInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">企业名称：</label>
			<div class="controls">
				<form:input path="companyName" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">行业：</label>
			<div class="controls">
				<form:input id="companyIndustry" path="companyIndustry" htmlEscape="false" maxlength="20" class="input-xlarge" readonly="true" onclick="getCompanyIndustry()"/>
				<!-- <a id="companyButton" href="javascript:" class="btn">添加行业</a> -->
				<%-- <form:select path="companyIndustry" class="input-xlarge">
					<form:option value="" label="    "/>
					<form:options items="${fns:getDictList('translate')}" itemValue="value" itemLabel="label"/>
				</form:select> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工商登记号：</label>
			<div class="controls">
				<form:input path="companyBusinessNo" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				<form:input path="companyEmail" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">地址：</label>
			<div class="controls">
				<form:input path="companyAddress" htmlEscape="false" maxlength="500" class="input-xlarge "/>
			</div>
		</div>
		<!-- 
			外资（欧美）
			外资（非欧美）
			合资、国企、民营公司、外企代表处、政府机关、事业单位、非盈利机构
		 -->
		<div class="control-group">
			<label class="control-label">性质：</label>
			<div class="controls">
				<form:select path="companyNature" class="input-xlarge">
					<form:option value="1" label="外资(欧美)"/>
					<form:option value="2" label="外资(非欧美)"/>
					<form:option value="3" label="合资"/>
					<form:option value="4" label="国企"/>
					<form:option value="5" label="民营公司"/>
					<form:option value="6" label="外企代表处"/>
					<form:option value="7" label="政府机关"/>
					<form:option value="8" label="事业单位"/>
					<form:option value="9" label="非盈利机构"/>
				</form:select>
			</div>
		</div>
		<!-- 
			少于50人
			50-150人
			150-500人、500-1000人、1000-5000人、5000-10000人、10000人以上
		 -->
		<div class="control-group">
			<label class="control-label">规模：</label>
			<div class="controls">
				<%-- <form:input path="companyScale" htmlEscape="false" maxlength="500" class="input-xlarge "/> --%>
				<!-- <select name="companyScale">
					<option></option>
					<option></option>
					<option></option>
				</select> -->
				<form:select path="companyScale" class="input-xlarge">
					<form:option value="1" label="少于50人"/>
					<form:option value="2" label="50-150人"/>
					<form:option value="3" label="150-500人"/>
					<form:option value="4" label="500-1000人"/>
					<form:option value="5" label="1000人以上"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">网站主页：</label>
			<div class="controls">
				<form:input path="companyWebsite" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">企业简介：</label>
			<div class="controls">
				<form:textarea id="companyDesc" path="companyDesc" htmlEscape="false" rows="4" class="input-xxlarge "/>
				<sys:ckeditor replace="companyDesc" uploadPath="/bf/company" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="218" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bf:bfCompanyInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
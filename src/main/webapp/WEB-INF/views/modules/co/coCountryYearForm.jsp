<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村和年表管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/style.css"/>
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
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/co/coCountryYear/">行政村档案清单列表</a></li>
		<li class="active"><a href="${ctx}/co/coCountryYear/form?id=${coCountryYear.id}">行政村档案<shiro:hasPermission name="co:coCountryYear:edit">${not empty coCountryYear.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="co:coCountryYear:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<%@ include file="/WEB-INF/views/include/coNav.jsp"%>
	<div id="tab-1" class="content-detail">
	<form:form id="inputForm" modelAttribute="coCountryYear" action="${ctx}/co/coCountryYear/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
	<div class="control-group" style="float: left">
		<label class="control-label">村名  <font color="red">*</font>:</label>
		<div class="controls">
			<sys:treeselect id="area" name="area.id" value="${coCountryYear.area.id}" labelName="area.name" labelValue="${coCountryYear.area.name}"
							title="上级行政区划" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true" />
		</div>
	</div>
	<div class="control-group" style="float: left">
		<label class="control-label" style="width:100px;">归属年度  <font color="red">*</font>:</label>
		<div class="controls" style="margin-left: 100px">
			<input name="years" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
				   value="<fmt:formatDate value="${coCountryYear.yearDate}" pattern="yyyy"/>"
				   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
		</div>
	</div>
	<br>
	<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
	</form:form>
	</div>
</div>
</body>
</html>
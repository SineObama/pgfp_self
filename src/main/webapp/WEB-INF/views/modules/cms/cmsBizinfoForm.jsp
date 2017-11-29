<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产业信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			if($("#link").val()){
                $('#linkBody').show();
                $('#url').attr("checked", true);
            }
			//$("#name").focus();
			$("#name").focus();
//			$("#inputForm").validate({
//				submitHandler: function(form){
////				if ($("#categoryId").val()==""){
////                        $("#categoryName").focus();
////                        top.$.jBox.tip('请选择归属栏目','warning');
////                    }else if (CKEDITOR.instances.content.getData()=="" && $("#link").val().trim()==""){
////                        top.$.jBox.tip('请填写正文','warning');
////                    }else if ($("#image").val()==""){
////                    	top.$.jBox.tip('请选择缩略图','warning');
////                    }
////                    else{
////                        loading('正在提交，请稍等...');
////                        form.submit();
////                    }
//				},
//				errorContainer: "#messageBox",
//				errorPlacement: function(error, element) {
//					$("#messageBox").text("输入有误，请先更正。");
//					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
//						error.appendTo(element.parent().parent());
//					} else {
//						error.insertAfter(element);
//					}
//				}
//			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/cmsBizinfo/">产业信息列表</a></li>
		<li class="active"><a href="${ctx}/cms/cmsBizinfo/form?id=${cmsBizinfo.id}">产业信息<shiro:hasPermission name="cms:cmsBizinfo:edit">${not empty cmsBizinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="cms:cmsBizinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="cmsBizinfo" action="${ctx}/cms/cmsBizinfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">产业类别：</label>
			<div class="controls">
				<form:select path="type" cssStyle="width:120px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('biz_type')}" itemLabel="label" itemValue="value"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">产业名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">计量单位：</label>
			<div class="controls">
				<form:input path="unit" htmlEscape="false" class="required"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" class=""/>
			</div>
		</div>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">产业类别：</label>--%>
			<%--<div class="controls">--%>
                <%--<sys:treeselect id="cmsBizinfoType" name="cmsBizinfoType.id" value="${cmsBizinfo.cmsBizinfoType.id}" labelName="cmsBizinfoType.name" labelValue="${cmsBizinfo.cmsBizinfoType.name}"--%>
					<%--title="产业类别" url="/cms/cmsBizinfoType/treeData" extId="${cmsBizinfoType.id}" cssClass="required" notAllowSelectParent="true"/>--%>
				<%--<span>--%>
                    <%--<input id="url" type="checkbox" onclick="if(this.checked){$('#linkBody').show()}else{$('#linkBody').hide()}$('#link').val()"><label for="url">外部链接</label>--%>
                <%--</span>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">标题：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:input path="title" htmlEscape="false" maxlength="255" class="input-xxlarge measure-input required"/>--%>
				<%--<span class="help-inline"><font color="red">*</font> </span>--%>
				<%--&nbsp;<label>颜色:</label>--%>
				<%--<form:select path="color" class="input-mini">--%>
					<%--<form:option value="" label="默认"/>--%>
					<%--<form:options items="${fns:getDictList('color')}" itemLabel="label" itemValue="value" htmlEscape="false" />--%>
				<%--</form:select>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div id="linkBody" class="control-group" style="display:none">--%>
            <%--<label class="control-label">外部链接:</label>--%>
            <%--<div class="controls">--%>
                <%--<form:input path="link" htmlEscape="false" maxlength="200" class="input-xlarge"/>--%>
                <%--<span class="help-inline">绝对或相对地址。</span>--%>
            <%--</div>--%>
        <%--</div>--%>
		<%--&lt;%&ndash; <div class="control-group">--%>
			<%--<label class="control-label">权重：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:input path="weight" htmlEscape="false" maxlength="11" class="input-xlarge "/>--%>
			<%--</div>--%>
		<%--</div> &ndash;%&gt;--%>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">关键字：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:input path="keywords" htmlEscape="false" maxlength="255" class="input-xlarge "/>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">摘要：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:textarea path="description" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">缩略图：</label>--%>
			<%--<div class="controls">--%>
				<%--<form:hidden id="image" path="image" htmlEscape="false" maxlength="255" class="input-xlarge required"/>--%>
				<%--<sys:ckfinder input="image" type="thumb" uploadPath="/cms/cmsBizinfo" selectMultiple="false"/>--%>
				<%--<span class="help-inline"><font color="red">*</font> </span>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">正文:</label>--%>
			<%--<div class="controls">--%>
				<%--<form:textarea id="content" htmlEscape="true" path="cmsBizinfoArtcledata.content" rows="4" maxlength="200" class="input-xxlarge"/>--%>
				<%--<sys:ckeditor replace="content" uploadPath="/cms/cmsBizinfo" />--%>
			<%--</div>--%>
		<%--</div>--%>
		<%----%>
		<%--<div class="control-group">--%>
			<%--<label class="control-label">发布时间:</label>--%>
			<%--<div class="controls">--%>
				<%--<input id="createDate" name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"--%>
					<%--value="<fmt:formatDate value="${cmsBizinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"--%>
					<%--onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>--%>
			<%--</div>--%>
		<%--</div>--%>
		<%----%>
		<div class="form-actions">
			<shiro:hasPermission name="cms:cmsBizinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训管理</title>
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
		<li><a href="${ctx}/bf/bfTrain/">培训列表</a></li>
		<li class="active"><a href="${ctx}/bf/bfTrain/form?id=${bfTrain.id}">培训<shiro:hasPermission name="bf:bfTrain:edit">${not empty bfTrain.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfTrain:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bfTrain" action="${ctx}/bf/bfTrain/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">培训标题：</label>
			<div class="controls">
				<form:input path="trainTitle" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">单位ID：</label>
			<div class="controls">
				<form:input path="insId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">单位:</label>
			<div class="controls">
                <sys:treeselect id="office" name="office.id" value="${bfTrain.office.id}" labelName="office.name" labelValue="${bfTrain.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="required" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">企业：</label>
			<div class="controls">
				<%-- <form:input path="companyId" htmlEscape="false" maxlength="64" class="input-xlarge "/> --%>
				<form:hidden id="articleDataCompany" path="companyId" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<ol id="companyInfoSelectList"></ol>
				<a id="companyButton" href="javascript:" class="btn">关联企业</a>
				<script type="text/javascript">
					var companyInfoSelect = [];
					function companyInfoSelectAddOrDel(id,title){
						var isExtents = false, index = 0;
						for (var i=0; i<companyInfoSelect.length; i++){
							if (companyInfoSelect[i][0]==id){
								isExtents = true;
								index = i;
							}
						}
						companyInfoSelect = [];
						if(isExtents){
							companyInfoSelect.splice(index,1);
						}else{
							companyInfoSelect.push([id,title]);
						}
						companyInfoSelectRefresh();
						top.mainFrame.companyInfoSelect = companyInfoSelect;
						
						$(".articleDelA").click();
					}
					top.mainFrame.companyInfoSelect = companyInfoSelect;
					top.mainFrame.companyInfoSelectAddOrDel = function (id,title){
						var isExtents = false, index = 0;
						for (var i=0; i<companyInfoSelect.length; i++){
							if (companyInfoSelect[i][0]==id){
								isExtents = true;
								index = i;
							}
						}
						companyInfoSelect = [];
						if(isExtents){
							companyInfoSelect.splice(index,1);
						}else{
							companyInfoSelect.push([id,title]);
						}
						companyInfoSelectRefresh();
						top.mainFrame.companyInfoSelect = companyInfoSelect;
						$(".articleDelA").click();
					}
					function companyInfoSelectRefresh(){
						$("#articleDataCompany").val("");
						$("#companyInfoSelectList").children().remove();
						for (var i=0; i<companyInfoSelect.length; i++){
							$("#companyInfoSelectList").append("<li>"+companyInfoSelect[i][1]+"&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"companyInfoSelectAddOrDel('"+companyInfoSelect[i][0]+"','"+companyInfoSelect[i][1]+"');\">×</a></li>");
							$("#articleDataCompany").val(companyInfoSelect[i][0]);
						}
					}
					$.getJSON("${ctx}/cms/article/findByCompanyId",{id:$("#articleDataCompany").val()},function(data){
						if(data!=null && data[0]){
							companyInfoSelect.push([data[0],data[1]]);
						}
						companyInfoSelectRefresh();
						top.mainFrame.companyInfoSelect = companyInfoSelect;
					});
					$("#companyButton").click(function(){
						top.$.jBox.open("iframe:${ctx}/bf/bfCompanyInfo/selectList?pageSize=10", "关联企业",$(top.document).width()-220,$(top.document).height()-180,{
							buttons:{"确定":true}, loaded:function(h){
								$(".jbox-content", top.document).css("overflow-y","hidden");
							}
						});
					});
				</script>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训开始时间：</label>
			<div class="controls">
				<%-- <form:input path="startTime" htmlEscape="false" maxlength="20" class="input-xlarge "/> --%>
				<input id="startTime" name="startTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="${bfTrain.startTime}"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训结束时间：</label>
			<div class="controls">
				<%-- <form:input path="endTime" htmlEscape="false" maxlength="20" class="input-xlarge "/> --%>
				<input id="endTime" name="endTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="${bfTrain.endTime}"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训地址：</label>
			<div class="controls">
				<form:input path="address" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训负责人：</label>
			<div class="controls">
				<form:input path="trainMgr" htmlEscape="false" maxlength="10" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">负责人电话：</label>
			<div class="controls">
				<form:input path="mgrPhone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">培训人数：</label>
			<div class="controls">
				<form:input path="trainPersonNum" htmlEscape="false" maxlength="5" class="input-xlarge " number="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发布时间：</label>
			<div class="controls">
				<%-- <form:input path="endTime" htmlEscape="false" maxlength="20" class="input-xlarge "/> --%>
				<input id="pubTime" name="pubTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${bfTrain.pubTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<%-- <form:textarea id="msgContents" htmlEscape="true" path="msgContent" rows="4" maxlength="200" class="input-xxlarge"/> --%>
				<textarea id="trainContent" name="trainContent">${bfTrain.trainContent}</textarea>
				<sys:ckeditor replace="trainContent" uploadPath="/bf/train" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="218" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bf:bfTrain:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
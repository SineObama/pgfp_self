<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训报名管理</title>
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
		<li><a href="${ctx}/bf/bfUserTrainInfo/">培训报名列表</a></li>
		<li class="active"><a href="${ctx}/bf/bfUserTrainInfo/form?id=${bfUserTrainInfo.id}">培训报名<shiro:hasPermission name="bf:bfUserTrainInfo:edit">${not empty bfUserTrainInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfUserTrainInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bfUserTrainInfo" action="${ctx}/bf/bfUserTrainInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">报名人：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号码：</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证号：</label>
			<div class="controls">
				<form:input path="idCard" htmlEscape="false" maxlength="18" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">培训ID：</label>
			<div class="controls">
				<form:input path="trainId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">培训内容：</label>
			<div class="controls">
				<form:hidden id="enrollTrain" path="trainId" htmlEscape="false" maxlength="200" class="input-xlarge required"/>
				<ol id="trainInfoSelectList"></ol>
				<a id="trainButton" href="javascript:" class="btn">关联培训</a>
				<script type="text/javascript">
					var trainInfoSelect = [];
					function trainInfoSelectAddOrDel(id,title){
						var isExtents = false, index = 0;
						for (var i=0; i<trainInfoSelect.length; i++){
							if (trainInfoSelect[i][0]==id){
								isExtents = true;
								index = i;
							}
						}
						trainInfoSelect = [];
						if(isExtents){
							trainInfoSelect.splice(index,1);
						}else{
							trainInfoSelect.push([id,title]);
						}
						trainInfoSelectRefresh();
						top.mainFrame.trainInfoSelect = trainInfoSelect;
						
					}
					top.mainFrame.trainInfoSelect = trainInfoSelect;
					top.mainFrame.trainInfoSelectAddOrDel = function (id,title){
						var isExtents = false, index = 0;
						for (var i=0; i<trainInfoSelect.length; i++){
							if (trainInfoSelect[i][0]==id){
								isExtents = true;
								index = i;
							}
						}
						trainInfoSelect = [];
						if(isExtents){
							trainInfoSelect.splice(index,1);
						}else{
							trainInfoSelect.push([id,title]);
						}
						trainInfoSelectRefresh();
						top.mainFrame.trainInfoSelect = trainInfoSelect;
					}
					function trainInfoSelectRefresh(){
						$("#enrollTrain").val("");
						$("#trainInfoSelectList").children().remove();
						for (var i=0; i<trainInfoSelect.length; i++){
							$("#trainInfoSelectList").append("<li>"+trainInfoSelect[i][1]+"&nbsp;&nbsp;<a href=\"javascript:\" onclick=\"trainInfoSelectAddOrDel('"+trainInfoSelect[i][0]+"','"+trainInfoSelect[i][1]+"');\">×</a></li>");
							$("#enrollTrain").val(trainInfoSelect[i][0]);
						}
					}
					$.getJSON("${ctx}/bf/bfTrain/findByTrainId",{id:$("#enrollTrain").val()},function(data){
						if(data!=null && data[0]){
							trainInfoSelect.push([data[0],data[1]]);
						}
						trainInfoSelectRefresh();
						top.mainFrame.trainInfoSelect = trainInfoSelect;
					});
					$("#trainButton").click(function(){
						top.$.jBox.open("iframe:${ctx}/bf/bfTrain/selectList?pageSize=10", "关联培训",$(top.document).width()-220,$(top.document).height()-180,{
							buttons:{"确定":true}, loaded:function(h){
								$(".jbox-content", top.document).css("overflow-y","hidden");
							}
						});
					});
				</script>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="bf:bfUserTrainInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招聘岗位管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			
			setRecruitWealVal();
			
			$("#inputForm").validate({
				ignore:"",
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
		
		//勾选福利
		function setRecruitWealVal(){
			var recruitWealVals = '${bfRecruitInfo.recruitWeal}';  
			if(recruitWealVals){
				$.each(recruitWealVals.split(','), function(i,item){  
					$("input[name=recruitWeal][value="+item+"]").attr("checked","checked");
				}); 
			}
		}
		
		top.mainFrame.recruitRoleAddOrDel = function(value){
			$("#recruitRole").val(value);
		}
		
		function getRecruitRole(){
			top.$.jBox.open("iframe:${ctx}/bf/bfRecruitInfo/selectRecruitRoleList", "添加职能",$(top.document).width()-720,$(top.document).height()-180,{
				buttons:{"确定":true}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bf/bfRecruitInfo/">招聘岗位列表</a></li>
		<li class="active"><a href="${ctx}/bf/bfRecruitInfo/form?id=${bfRecruitInfo.id}">招聘岗位<shiro:hasPermission name="bf:bfRecruitInfo:edit">${not empty bfRecruitInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:bfRecruitInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="bfRecruitInfo" action="${ctx}/bf/bfRecruitInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">职位名称：</label>
			<div class="controls">
				<form:input path="recruitName" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招聘人数：</label>
			<div class="controls">
				<form:input path="recruitNum" htmlEscape="false" maxlength="6" class="input-xlarge required digits" vlaue="0"/>
				0为若干
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">月薪：</label>
			<div class="controls">
				<form:input path="recruitPayBegin" htmlEscape="false" maxlength="10" class="digits required"/>
				到
				<form:input path="recruitPayEnd" htmlEscape="false" maxlength="10" class="digits required"/>
				元
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">年龄：</label>
			<div class="controls">
				<form:input path="recruitAgeBegin" htmlEscape="false" maxlength="2" class="digits required"/>
				到
				<form:input path="recruitAgeEnd" htmlEscape="false" maxlength="2" class="digits required"/>
				岁,0为不限
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职能：</label>
			<div class="controls">
				<form:input id="recruitRole" readonly="true" path="recruitRole" htmlEscape="false" maxlength="50" class="input-xlarge required" onclick="getRecruitRole()"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">上班地点：</label>
			<div class="controls">
				<form:input path="recruitAddress" htmlEscape="false" maxlength="50" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最低学历：</label>
			<div class="controls">
				<%-- <form:input path="recruitEdc" htmlEscape="false" maxlength="10" class="input-xlarge "/> --%>
				<form:select path="recruitEdc" class="input-xlarge">
					<form:option value="0" label="不限"/>
					<form:option value="1" label="大专"/>
					<form:option value="2" label="本科"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作年限：</label>
			<div class="controls">
				<%-- <form:input path="recruitTime" htmlEscape="false" maxlength="10" class="input-xlarge "/> --%>
				<form:select path="recruitTime" class="input-xlarge">
					<form:option value="0" label="不限"/>
					<form:option value="1" label="1-2年"/>
					<form:option value="2" label="2-3年"/>
					<form:option value="3" label="3年以上"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作性质：</label>
			<div class="controls">
				<%-- <form:input path="recruitTime" htmlEscape="false" maxlength="10" class="input-xlarge "/> --%>
				<form:select path="recruitNature" class="input-xlarge">
					<form:option value="0" label="全职"/>
					<form:option value="1" label="兼职"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">福利标签：</label>
			<div class="controls">
				<%-- <form:input path="recruitWeal" htmlEscape="false" maxlength="500" class="input-xlarge "/> --%>
				<input type="checkbox" value="五险一金" name="recruitWeal">五险一金
				<input type="checkbox" value="年终奖金" name="recruitWeal">年终奖金
				<input type="checkbox" value="餐饮补贴" name="recruitWeal">餐饮补贴
				<input type="checkbox" value="专业培训" name="recruitWeal">专业培训
				<input type="checkbox" value="通讯补贴" name="recruitWeal">通讯补贴
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
		
		<%-- <div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<form:textarea id="msgContents" htmlEscape="true" path="msgContent" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="msgContents" uploadPath="/bf/recruit" />
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">正文:</label>
			<div class="controls">
				<%-- <form:textarea id="msgContents" htmlEscape="true" path="msgContent" rows="4" maxlength="200" class="input-xxlarge"/> --%>
				<textarea id="msgContent" name="msgContent">${bfRecruitInfo.msgContent}</textarea>
				<sys:ckeditor replace="msgContent" uploadPath="/bf/recruit" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发布时间：</label>
			<div class="controls">
				<%-- <form:input path="pubTime" htmlEscape="false" maxlength="20" class="input-xlarge "/> --%>
				<input id="createDate" name="pubTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="${bfRecruitInfo.pubTime}"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">过期时间：</label>
			<div class="controls">
					<%-- <form:input path="pubTime" htmlEscape="false" maxlength="20" class="input-xlarge "/> --%>
				<input name="lastTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					   value="${bfRecruitInfo.lastTime}"
					   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="218" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bf:bfRecruitInfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>
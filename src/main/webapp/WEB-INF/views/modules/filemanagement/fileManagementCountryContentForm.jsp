<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>档案管理内容管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxState}/common/jeesite.min.css" type="text/css"/>
	<link href="${ctxState}/pgfp/css/bootstrap.min.css" type="text/css"/>
	<style>
		.edit{
			display: none;
		}
		.form-horizontal .control-label{
			width: auto;
		}
		.form-horizontal .controls{
			margin-left: 0;
		}
	</style>
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
			$(".editContent,.addContent").on("click",function(){
				$(".edit").show();
				$(".view").hide();
			})
            $(".can-btn").on("click",function(){
                $(".edit").hide();
                $(".view").show();
            })

		});
	</script>
</head>
<body>
<div class="form-horizontal">
	<div class="view">
		<c:if test="${fileManagementCountry != null and fileManagementCountry.content != null}"><br/>
			${contentText}
			<br/><br/>
			<div>
				<input type="button" class="btn editContent btn-primary" value="修改档案内容"/>
				<br/><br/>
			</div>
		</c:if>
		<c:if test="${fileManagementCountry == null || fileManagementCountry.content == null}">
			<div>
				<input type="button"class="btn addContent btn-primary" value="新增档案内容"/>
			</div>
		</c:if>
	</div>
	<div class="edit">
		<form:form modelAttribute="fileManagementCountry" action="${ctx}/filemanagement/fileManagementCountry/saveContent" method="post" >
			<input type="hidden" name="id" value="${fileManagementCountry.id}"/>
			<input type="hidden" name="content.id" value="${fileManagementCountry.content.id}"/>
			<form:textarea id="content" htmlEscape="false" path="content.content" rows="8" maxlength="200" class="input-xxlarge"/>
			<sys:ckeditor replace="content" uploadPath="/file/management" />
			<br/>
			<input type="submit" class="btn sub-btn btn-primary" value="提交"/>
			<input type="button" class="btn can-btn" value="取消编辑"/>
		</form:form>
	</div>
</div>
</body>
</html>
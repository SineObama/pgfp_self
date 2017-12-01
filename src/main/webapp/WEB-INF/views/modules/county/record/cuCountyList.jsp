<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>县扶贫档案管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
        $(document).ready(function () {
            $("#editSave").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        })
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/record/cuMain/list">年度扶贫档案列表</a></li>
		<shiro:hasPermission name="record:cuMain:view">
			<li><a data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">扶贫年度档案添加</a></li>
		</shiro:hasPermission>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>所属县</th>
				<th>档案时间(年)</th>
				<shiro:hasPermission name="record:cuMain:view"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="county">
			<tr>
				<%--<form:hidden path="${county.id}"/>--%>
				<td>${county.area}</td>
				<td><a href="${ctx}/record/cuCountySpecialtyIndustry/form?cuMainId=${county.id}&year=${county.year}&type=1">${county.year}</a></td>
				<shiro:hasPermission name="record:cuMain:view">
					<td>
						<a href="${ctx}/county/document/export?cuMainId=${county.id}">导出档案</a>
						<a href="${ctx}/record/cuCountySpecialtyIndustry/form?cuMainId=${county.id}&year=${county.year}&type=1">修改</a>
						<a href="${ctx}record/cuMain/delete?id=${county.id}" onclick="return confirmx('确认要删除该年度档案吗？', this.href)">删除</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<%-- 模态框（Modal） --%>
	<div class="modal fade"  style="display: none;width:400px;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title text-center" id="myModalLabel">扶贫年度档案归属年度</h4>
				</div>
				<form:form action="${ctx}/record/cuCountySpecialtyIndustry/form" id="editSave" modelAttribute="cuMain" method="post" >
					<div style="margin-top: 13px;text-align: center;">
						选择年度：<input name="year" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						            onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
						<input type="hidden" name="type" value="1">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="submit"  class="btn btn-primary">增加</button>
					</div>
				</form:form>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>


</body>
</html>
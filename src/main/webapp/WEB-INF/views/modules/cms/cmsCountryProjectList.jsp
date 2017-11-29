<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>扶贫项目库清单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $("#btnImport").click(function () {
                $.jBox($("#importBox").html(), {
                    title: "导入--数据", buttons: {"关闭": true},
                    bottomText: "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"
                });
            });
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div id="nav nav-tabs">
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/cmsCountryProject/">扶贫项目库清单列表</a></li>
		<shiro:hasPermission name="cms:cmsCountryProject:edit"><li><a href="${ctx}/cms/cmsCountryProject/form">扶贫项目库清单添加</a></li></shiro:hasPermission>
	</ul>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/cms/cmsCountryProject/import" method="post" enctype="multipart/form-data"
		      class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<%--<a href="${ctx}/record/workForceCadre/import/template">下载模板</a>--%>
		</form>
	</div>
	<form:form id="searchForm" modelAttribute="cmsCountryProject" action="${ctx}/cms/cmsCountryProject/" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<style type="text/css">
			.ul-form li{
				margin-bottom: 5px;
			}
		</style>
		<ul class="ul-form">
			<li><label style="width: auto">监管单位：</label>
				<sys:treeselect id="office" name="cmsProject.office.id" value="${cmsCountryProject.cmsProject.office.id}" labelName="cmsProject.office.name" labelValue="${cmsCountryProject.cmsProject.office.name}"
				                title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>


			<li><label style="width: auto">项目类别：</label>
				<form:select path="cmsProject.type" class="input-large">
					<form:option value="" label="       "/>
					<form:options items="${fns:getDictList('project_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
				<%-- <li><label>项目名称：</label>
					 <form:input path="cmsProject.title" htmlEscape="false" maxlength="255" class="input-medium"/>
				 </li>--%>
				<%--                <li><label>验收结果：</label>
										&lt;%&ndash;<form:radiobuttons path="checkFlag" items="${fns:getDictList('checkFlag')}" itemValue="value" itemLabel="label"/>&ndash;%&gt;
									<form:select path="cmsProject.checkFlag" cssClass="input-medium" cssStyle="width: 180px;">
										<form:option value="" label="       "/>
										<form:options items="${fns:getDictList('checkFlag')}" itemLabel="label" itemvalue="value"/>
									</form:select>
								</li>--%>
			<li><label style="width: auto">完成状态：</label>
					<%--<form:radiobuttons path="finishedState" items="${fns:getDictList('finishedState')}" itemValue="value" itemLabel="label"/>--%>
				<form:select path="cmsProject.finishedState" cssClass="input-medium" cssStyle="width: 180px;">
					<form:option value="" label="       "/>
					<form:options items="${fns:getDictList('finishedState')}" itemLabel="label" itemValue="value"  htmlEscape="false"/>
				</form:select>
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
			<li class="clearfix"></li>
		</ul>
		</form:form>
</div>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
                <th width="15%">项目名称</th>
                <th width="15%">项目类别</th>
                <th width="15%">监管单位</th>
                <th width="15%">建设地点</th>
                <th width="15%">投资估算（元）</th>
                <th width="15%">计划建设时间</th>
				<shiro:hasPermission name="cms:cmsCountryProject:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsCountryProject">
			<tr>
                <td><a href="${ctx}/cms/cmsCountryProject/form?id=${cmsCountryProject.id}">
                    ${cmsCountryProject.cmsProject["title"]}
                </a></td>
                <td> ${fns:getDictLabel(cmsCountryProject.cmsProject.type, 'project_type', '')}
                <td> ${cmsCountryProject.cmsProject.office.name}</td>
                <td> ${cmsCountryProject.cmsProject.address.name}</td>
                <td> ${cmsCountryProject.cmsProject.amount}</td>
				<td>${cmsCountryProject.scheduleTime}</td>
				<shiro:hasPermission name="cms:cmsCountryProject:edit"><td>
    				<a href="${ctx}/cms/cmsCountryProject/form?id=${cmsCountryProject.id}">修改</a>
					<a href="${ctx}/cms/cmsCountryProject/delete?id=${cmsCountryProject.id}" onclick="return confirmx('确认要删除该扶贫项目库清单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
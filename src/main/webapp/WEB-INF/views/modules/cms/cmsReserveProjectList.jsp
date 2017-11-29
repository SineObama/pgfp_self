<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>储备项目汇总表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
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
<div id="importBox" class="hide">
	<form id="importForm" action="${ctx}/cms/cmsReserveProject/import" method="post" enctype="multipart/form-data"
		  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　
		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
	</form>
</div>

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/cmsReserveProject/">储备项目汇总表列表</a></li>
		<shiro:hasPermission name="cms:cmsReserveProject:edit"><li><a href="${ctx}/cms/cmsReserveProject/form">储备项目汇总表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmsProject" action="${ctx}/cms/cmsReserveProject/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<%--<ul class="ul-form">--%>
			<%--<li><label>项目名称：</label>--%>
				<%--<form:input path="title" htmlEscape="false" maxlength="255" class="input-medium"/>--%>
			<%--</li>--%>
			<%--<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>--%>
			<%--<li class="clearfix"></li>--%>
		<%--</ul>--%>
		<li><label>监管单位：</label>
			<sys:treeselect id="office" name="office.id" value="${cmsProject.office.id}" labelName="office.name" labelValue="${cmsProject.office.name}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
		</li>


		<li><label>项目类别：</label>
			<form:select path="type" class="input-large">
				<form:option value="" label="       "/>
				<form:options items="${fns:getDictList('project_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</form:select>
		</li>
		<li><label>完成状态：</label>
			<form:select path="finishedState" cssClass="input-medium" cssStyle="width: 180px;">
				<form:option value="" label="       "/>
				<form:options items="${fns:getDictList('finishedState')}" itemLabel="label" itemValue="value"  htmlEscape="false"/>
			</form:select>
		</li>

		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="btns">
			<input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
		</li>
		<li class="clearfix"></li>
	</form:form>
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
				<shiro:hasPermission name="cms:cmsReserveProject:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsProject">
			<tr>
				<td>
					<a href="${ctx}/cms/cmsReserveProject/form?id=${cmsProject.id}">
						${cmsProject.reserve.title}
					</a>
				</td>
				<td>
					${fns:getDictLabel(cmsProject.type, 'project_type', '')}
				</td>
				<td>
					${cmsProject.office.name}
				</td>
				<td> ${cmsProject.address.name}</td>
				<td> ${cmsProject.amount}</td>
				<td>
					${cmsProject.reserve.planYear}
				</td>
				<shiro:hasPermission name="cms:cmsReserveProject:edit"><td>
    				<a href="${ctx}/cms/cmsReserveProject/form?id=${cmsProject.id}">修改</a>
					<a href="${ctx}/cms/cmsReserveProject/delete?id=${cmsProject.id}" onclick="return confirmx('确认要删除该储备项目汇总表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
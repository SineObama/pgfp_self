<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目档案管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
						top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
//							console.debug(v);
							if(v=="ok"){
//								console.debug(v);
								$("#searchForm").attr("action","${ctx}/cms/cmsProject/exportFile");
								$("#searchForm").submit();
							}
						});
					}
			);
			$("#btnSubmit").click(function(){
				$("#searchForm").attr("action","${ctx}/cms/cmsProject");
				$("#searchForm").submit();
			});
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
	<script type="application/javascript">
		function exportFile(){
			$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
		}
	</script>
</head>
<body>
<div id="importBox" class="hide">
	<form id="importForm" action="${ctx}/cms/cmsProject/import" method="post" enctype="multipart/form-data"
		  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		<a href="${ctx}/cms/cmsProject/import/template">下载模板</a>
	</form>
</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/cmsProject/">项目档案列表</a></li>
		<shiro:hasPermission name="cms:cmsProject:edit"><li><a href="${ctx}/cms/cmsProject/form">项目档案添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="cmsProject" action="${ctx}/cms/cmsProject/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<style type="text/css">
			.ul-form li{
				margin-bottom: 5px;
			}
		</style>
		<ul class="ul-form">
			<li><label>监管单位：</label>
				<sys:treeselect id="office" name="office.id" value="${cmsProject.office.id}" labelName="office.name" labelValue="${cmsProject.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<%--<li><label>帮扶政策：</label>--%>
				<%--<sys:treeselect id="subsidyType" name="subsidyType.id" value="${cmsProject.subsidyType.id}" labelName="subsidyType.subsidyType" labelValue="${cmsProject.subsidyType.subsidyType}"--%>
								<%--title="帮扶政策" url="/bf/bfSubsidyType/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="false"/>--%>
			<%--</li>--%>
			<li><label>项目类别：</label>
				<form:select path="type" class="input-large">
					<form:option value="" label="       "/>
					<form:options items="${fns:getDictList('project_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>项目名称：</label>
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>验收结果：</label>
				<%--<form:radiobuttons path="checkFlag" items="${fns:getDictList('checkFlag')}" itemValue="value" itemLabel="label"/>--%>
				<form:select path="checkFlag" cssClass="input-medium" cssStyle="width: 180px;">
					<form:option value="" label="       "/>
				<form:options items="${fns:getDictList('checkFlag')}" itemLabel="label" itemValue="value"/>
				</form:select>
			</li>
			<li><label>完成状态：</label>
				<%--<form:radiobuttons path="finishedState" items="${fns:getDictList('finishedState')}" itemValue="value" itemLabel="label"/>--%>
				<form:select path="finishedState" cssClass="input-medium" cssStyle="width: 180px;">
					<form:option value="" label="       "/>
					<form:options items="${fns:getDictList('finishedState')}" itemLabel="label" itemvalue="value"/>
				</form:select>
			</li>
			<li><label>承建单位：</label>
				<form:input path="constructionUnit" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="excel&nbsp;导出"/></li>
			<shiro:hasPermission name="cms:cmsProject:edit"><li class="btns"><input id="btnImport" class="btn btn-primary" type="button" value="excel&nbsp;导入"/></li></shiro:hasPermission>
			<li class="clearfix"></li>
		</ul>
	</form:form>

	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="12%">项目名称</th>
				<th width="10%">项目类别</th>
				<th width="10%">监管单位</th>
				<th width="10%">建设地点</th>
				<th width="10%">投资估算（元）</th>
				<th width="10%">计划建设时间</th>
				<th width="20%">建设内容</th>
				<th width="10%">承建单位</th>
				<%--<th>更新时间</th>--%>
				<%--<th>备注信息</th>--%>
				<shiro:hasPermission name="cms:cmsProject:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsProject">
			<tr>
				<td><a href="${ctx}/cms/cmsProject/form?id=${cmsProject.id}">
					${cmsProject.title}
				</a></td>
				<td>
					${fns:getDictLabel(cmsProject.type,'project_type','0')}
				</td>
				<td>
					${cmsProject.office.name}
				</td>
				<td>
					<%--<fmt:formatDate value="${cmsProject.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
					${cmsProject.address.name}
				</td>
				<td>
					<%--${cmsProject.remarks}--%>
					${cmsProject.amount}
				</td>
				<td>
					<fmt:formatDate value="${cmsProject.scheduleTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${fns:abbr(cmsProject.content,100)}
				</td>
				<td>
						${cmsProject.constructionUnit}
				</td>
				<shiro:hasPermission name="cms:cmsProject:edit"><td>
    				<a href="${ctx}/cms/cmsProject/form?id=${cmsProject.id}">修改</a>
					<a href="${ctx}/cms/cmsProject/print?id=${cmsProject.id}" target="_blank">打印</a>
					<a href="${ctx}/cms/cmsProject/delete?id=${cmsProject.id}" onclick="return confirmx('确认要删除该项目档案吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
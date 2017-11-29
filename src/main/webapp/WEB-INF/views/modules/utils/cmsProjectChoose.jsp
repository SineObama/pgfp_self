<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目档案管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			var data = ${fns:toJson(page.list)};

			$('.choose').click(function(){
				var id = $(this).attr('id');
				var len = data.length;
				for(var i = 0 ; i < len ; i++){
					if(id == data[i].id){
						window.opener.chooseProject(data[i]);
						window.close();
					}
				}
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        };
	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cmsProject" action="${ctx}/cms/cmsProject/proChoose" method="post" class="breadcrumb form-search">
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
				<form:select path="type" class="input-small">
					<form:option value="" label="       "/>
					<form:options items="${fns:getDictList('project_type')}"
								  itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>项目名称：</label>
				<form:input path="title" htmlEscape="false" maxlength="255" class="input-small"/>
			</li>
			<li><label>承建单位：</label>
				<form:input path="constructionUnit" htmlEscape="false" maxlength="255" class="input-small"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
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
				<th width="10%">计划建设时间</th>
				<th width="10%">承建单位</th>
				<th width="8%">操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsProject">
			<tr>
				<td><a class="choose" id="${cmsProject.id}">
					${cmsProject.title}
				</a></td>
				<td>
					${fns:getDictLabel(cmsProject.type,'project_type','0')}
				</td>
				<td>
					${cmsProject.office.name}
				</td>
				<td>
					${cmsProject.address.name}
				</td>
				<td>
					<fmt:formatDate value="${cmsProject.scheduleTime}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
						${cmsProject.constructionUnit}
				</td>
				<td>
    				<a class="choose" id="${cmsProject.id}">选择</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
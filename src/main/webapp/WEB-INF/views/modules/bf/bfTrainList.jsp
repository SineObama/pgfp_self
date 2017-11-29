<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bf/bfTrain/">培训列表</a></li>
		<shiro:hasPermission name="bf:bfTrain:edit"><li><a href="${ctx}/bf/bfTrain/form">培训添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfTrain" action="${ctx}/bf/bfTrain/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>培训标题：</label>
				<form:input path="trainTitle" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>培训地址：</label>
				<form:input path="address" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>培训负责人：</label>
				<form:input path="trainMgr" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>培训标题</th>
				<th>培训单位</th>
				<th>培训企业</th>
				<th>培训开始时间</th>
				<th>培训结束时间</th>
				<th>培训地址</th>
				<th>培训负责人</th>
				<th>负责人电话</th>
				<th>培训人数</th>
				<th>发布时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="bf:bfTrain:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfTrain">
			<tr>
				<td><a href="${ctx}/bf/bfTrain/form?id=${bfTrain.id}">
					${bfTrain.trainTitle}
				</a></td>
				<td>
					${bfTrain.office.name}
				</td>
				<td>
					${bfTrain.companyName}
				</td>
				<td>
					${bfTrain.startTime}
				</td>
				<td>
					${bfTrain.endTime}
				</td>
				<td>
					${bfTrain.address}
				</td>
				<td>
					${bfTrain.trainMgr}
				</td>
				<td>
					${bfTrain.mgrPhone}
				</td>
				<td>
					${bfTrain.trainPersonNum}
				</td>
				<td>
					<fmt:formatDate value="${bfTrain.pubTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${bfTrain.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bfTrain.remarks}
				</td>
				<shiro:hasPermission name="bf:bfTrain:edit"><td>
    				<a href="${ctx}/bf/bfTrain/form?id=${bfTrain.id}">修改</a>
					<a href="${ctx}/bf/bfTrain/delete?id=${bfTrain.id}" onclick="return confirmx('确认要删除该培训吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
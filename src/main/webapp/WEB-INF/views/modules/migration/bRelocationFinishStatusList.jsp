<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务完成情况管理</title>
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
		<%--<li class="active"><a href="${ctx}/migration/bRelocationFinishStatus/">任务完成情况列表</a></li>--%>
		<shiro:hasPermission name="migration:bRelocationFinishStatus:edit"><li><a href="${ctx}/migration/bRelocationFinishStatus/form">任务完成情况修改</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bRelocationFinishStatus" action="${ctx}/migration/bRelocationFinishStatus/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>年份：</label>
				<input name="particularYear" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${bRelocationFinishStatus.particularYear}" pattern="yyyy"/>"
					onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>未开工户数</th>
				<th>未开工人数</th>
				<th>主体工程已完工户数</th>
				<th>主体工程已完工人数</th>
				<th>正在建房户数</th>
				<th>正在建房人数</th>
				<th>已入住户数</th>
				<th>已入住人数</th>
				<th>年份</th>
				<shiro:hasPermission name="migration:bRelocationFinishStatus:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bRelocationFinishStatus">
			<tr>
				<td><a href="${ctx}/migration/bRelocationFinishStatus/form?id=${bRelocationFinishStatus.id}">
					${bRelocationFinishStatus.notStartedHouseholds}
				</a></td>
				<td>
					${bRelocationFinishStatus.notStartedPopulations}
				</td>
				<td>
					${bRelocationFinishStatus.startedHouseholds}
				</td>
				<td>
					${bRelocationFinishStatus.startedPopulations}
				</td>
				<td>
					${bRelocationFinishStatus.buildingHouseholds}
				</td>
				<td>
					${bRelocationFinishStatus.buildingPopulations}
				</td>
				<td>
					${bRelocationFinishStatus.stayHouseholds}
				</td>
				<td>
					${bRelocationFinishStatus.stayPopulations}
				</td>
				<td>
					${bRelocationFinishStatus.particularYear}
				</td>
				<shiro:hasPermission name="migration:bRelocationFinishStatus:edit"><td>
    				<a href="${ctx}/migration/bRelocationFinishStatus/form?id=${bRelocationFinishStatus.id}">修改</a>
					<a href="${ctx}/migration/bRelocationFinishStatus/delete?id=${bRelocationFinishStatus.id}" onclick="return confirmx('确认要删除该任务完成情况吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
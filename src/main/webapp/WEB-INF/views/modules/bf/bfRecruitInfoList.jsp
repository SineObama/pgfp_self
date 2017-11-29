<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招聘岗位管理</title>
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
		<li class="active"><a href="${ctx}/bf/bfRecruitInfo/">招聘岗位列表</a></li>
		<shiro:hasPermission name="bf:bfRecruitInfo:edit"><li><a href="${ctx}/bf/bfRecruitInfo/form">招聘岗位添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfRecruitInfo" action="${ctx}/bf/bfRecruitInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>职位名称：</label>
				<form:input path="recruitName" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>职位名称</th>
				<th>招聘人数</th>
				<th>上班地点</th>
				<th>最低学历</th>
				<th>工作年限</th>
				<th>工作性质</th>
				<th>职能</th>
				<th>福利标签</th>
				<th>发布时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="bf:bfRecruitInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfRecruitInfo">
			<tr>
				<td><a href="${ctx}/bf/bfRecruitInfo/form?id=${bfRecruitInfo.id}">
					${bfRecruitInfo.recruitName}
				</a></td>
				<td>
					${bfRecruitInfo.recruitNum}
				</td>
				<td>
					${bfRecruitInfo.recruitAddress}
				</td>
				<td>
					<c:if test="${bfRecruitInfo.recruitEdc eq '0'}">
						不限
					</c:if>
					<c:if test="${bfRecruitInfo.recruitEdc eq '1'}">
						大专
					</c:if>
					<c:if test="${bfRecruitInfo.recruitEdc eq '2'}">
						本科
					</c:if>
				</td>
				<td>
					<c:if test="${bfRecruitInfo.recruitTime eq '0'}">
						不限
					</c:if>
					<c:if test="${bfRecruitInfo.recruitTime eq '1'}">
						1-2年
					</c:if>
					<c:if test="${bfRecruitInfo.recruitTime eq '2'}">
						2-3年
					</c:if>
					<c:if test="${bfRecruitInfo.recruitTime eq '3'}">
						3年以上
					</c:if>
				</td>
				<td>
					<c:if test="${bfRecruitInfo.recruitNature eq '0'}">
						全职
					</c:if>
					<c:if test="${bfRecruitInfo.recruitNature eq '1'}">
						兼职
					</c:if>
				</td>
				<td>
					${bfRecruitInfo.recruitRole}
				</td>
				<td>
					${bfRecruitInfo.recruitWeal}
				</td>
				<td>
					${bfRecruitInfo.pubTime}
				</td>
				<td>
					<fmt:formatDate value="${bfRecruitInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bfRecruitInfo.remarks}
				</td>
				<shiro:hasPermission name="bf:bfRecruitInfo:edit"><td>
    				<a href="${ctx}/bf/bfRecruitInfo/form?id=${bfRecruitInfo.id}">修改</a>
					<a href="${ctx}/bf/bfRecruitInfo/delete?id=${bfRecruitInfo.id}" onclick="return confirmx('确认要删除该招聘岗位吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
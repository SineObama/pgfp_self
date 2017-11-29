<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招聘报名管理</title>
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
		<li class="active"><a href="${ctx}/bf/bfUserRecruitInfo/">招聘报名列表</a></li>
		
		<%-- <shiro:hasPermission name="bf:bfUserRecruitInfo:edit"><li><a href="${ctx}/bf/bfUserRecruitInfo/form">招聘报名添加</a></li></shiro:hasPermission>
	 --%>
	</ul>
	<form:form id="searchForm" modelAttribute="bfUserRecruitInfo" action="${ctx}/bf/bfUserRecruitInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<form:input path="userName" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号：</label>
				<form:input path="userPhone" htmlEscape="false" maxlength="13" class="input-medium"/>
			</li>
			<li><label>身份证号：</label>
				<form:input path="userIdNo" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>文化程度：</label>
				<form:input path="userDegree" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>用户选择的工作：</label>
				<form:input path="userSelectJob" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>地址：</label>
				<form:input path="userAddress" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>手机号</th>
				<th>身份证号</th>
				<th>文化程度</th>
				<th>受培训情况</th>
				<th>用户选择的工作</th>
				<th>地址</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="bf:bfUserRecruitInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfUserRecruitInfo">
			<tr>
				<td><a href="${ctx}/bf/bfUserRecruitInfo/form?id=${bfUserRecruitInfo.id}">
					${bfUserRecruitInfo.userName}
				</a></td>
				<td>
					${bfUserRecruitInfo.userPhone}
				</td>
				<td>
					${bfUserRecruitInfo.userIdNo}
				</td>
				<td>
					${bfUserRecruitInfo.userDegree}
				</td>
				<td>
					${bfUserRecruitInfo.userWorkExp}
				</td>
				<td>
					${bfUserRecruitInfo.userSelectJob}
				</td>
				<td>
					${bfUserRecruitInfo.userAddress}
				</td>
				<td>
					<fmt:formatDate value="${bfUserRecruitInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bfUserRecruitInfo.remarks}
				</td>
				<shiro:hasPermission name="bf:bfUserRecruitInfo:edit"><td>
    				<a href="${ctx}/bf/bfUserRecruitInfo/form?id=${bfUserRecruitInfo.id}">修改</a>
					<a href="${ctx}/bf/bfUserRecruitInfo/delete?id=${bfUserRecruitInfo.id}" onclick="return confirmx('确认要删除该招聘报名吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
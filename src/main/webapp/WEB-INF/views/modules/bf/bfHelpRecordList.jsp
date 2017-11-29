<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s,v){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#funcParam").val(v);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bf/bfHelpRecord/">帮扶记录列表</a></li>
		<%--<shiro:hasPermission name="bf:bfHelpRecord:edit"><li><a href="${ctx}/bf/bfHelpRecord/form">帮扶记录添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="bfHelpRecord" action="${ctx}/bf/bfHelpRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearTemp}"/>
		<ul class="ul-form">
			<li><label>户主姓名：</label>
				<form:input path="houseHolderName"/>
			</li>
			<%--<li><label>归属年度：</label>--%>
				<form:hidden path="year"/>
			<%--</li>--%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>

	<c:if test="${yearsList != null}">
		<ul class="nav nav-tabs nav-year">
			<c:forEach items="${yearsList}" var="year">
				<c:if test="${yearTemp == year}">
					<li class="active"><a href="${ctx}/bf/bfHelpRecord/list?year=${year}">${year}</a></li>
				</c:if>
				<c:if test="${yearTemp != year}">
					<li><a href="${ctx}/bf/bfHelpRecord?year=${year}">${year}</a></li>
				</c:if>
			</c:forEach>
		</ul>
	</c:if>

	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th style="width:10%;">户主姓名</th>
				<th style="width:10%;">归属年度</th>
				<th style="width:10%;">入户时间</th>
				<th style="width:60%;">内容</th>
				<shiro:hasPermission name="bf:bfHelpRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfHelpRecord">
			<tr>
				<td style="width:10%;">
					<a href="${ctx}/bf/bfHelpRecord/form?id=${bfHelpRecord.id}">
						${bfHelpRecord.houseHolderName}
					</a>
				</td>
				<td style="width:10%;">
					${bfHelpRecord.year}
				</td>
				<td style="width:10%;">
					<fmt:formatDate value="${bfHelpRecord.helpDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td style="width:60%; ">
					<%--<fmt:formatDate value="${bfHelpRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
					${bfHelpRecord.content}
				</td>
				<shiro:hasPermission name="bf:bfHelpRecord:edit"><td>
    				<%--<a href="${ctx}/bf/bfHelpRecord/form?regCardId=${bfHelpRecord.regCardId}">修改</a>--%>
					<a href="${ctx}/bf/bfHelpRecord/delete?id=${bfHelpRecord.id}&years=${bfHelpRecord.year}" onclick="return confirmx('确认要删除该帮扶记录吗？', this.href)">删除</a>
    				<%--<a href="${ctx}/bf/bfHelpRecord/exportPDF?regCardId=${bfHelpRecord.regCardId}">生成帮扶文档</a>--%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
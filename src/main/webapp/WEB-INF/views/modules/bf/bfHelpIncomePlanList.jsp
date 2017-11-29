<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>年度帮扶及收入计划管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
//			$(".nav-year li:first-child").addClass("active");
//			$(".nav-year li").click(function(){
//				$(".nav-year li").removeClass("active");
//				$(this).addClass("active");
//				console.log("run")
//			})
		});
		function page(n,s,v){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("funcParam").val(v);
			$("#searchForm").submit();
			return false;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bf/bfHelpIncomePlan/">年度帮扶及收入计划列表</a></li>
		<shiro:hasPermission name="bf:bfHelpIncomePlan:edit"><li><a href="${ctx}/bf/bfHelpIncomePlan/form">年度帮扶及收入计划添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfHelpIncomePlan" action="${ctx}/bf/bfHelpIncomePlan/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearTemp}"/>
		<ul class="ul-form">
			<li><label>户主姓名：</label>
				<form:input path="card.houseHolderName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<%--<li><label>年度：</label>--%>
				<form:hidden path="years" htmlEscape="false" maxlength="4" class="input-medium"/>
			<%--</li>--%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<c:if test="${yearsList != null}">
	<ul class="nav nav-tabs nav-year">
		<c:forEach items="${yearsList}" var="year">
			<c:if test="${yearTemp == year}">
			<li class="active"><a href="${ctx}/bf/bfHelpIncomePlan/list?years=${year}">${year}</a></li>
			</c:if>
			<c:if test="${yearTemp != year}">
			<li><a href="${ctx}/bf/bfHelpIncomePlan/list?years=${year}">${year}</a></li>
			</c:if>
		</c:forEach>
	</ul>
	</c:if>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>户主姓名</th>
				<th>年度</th>
				<th>地址</th>
				<th>更新日期</th>
				<shiro:hasPermission name="bf:bfHelpIncomePlan:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfHelpIncomePlan">
			<tr>
				<td><a href="${ctx}/bf/bfHelpIncomePlan/form?card.id=${bfHelpIncomePlan.card.id}">
						${bfHelpIncomePlan.card.houseHolderName}
				</a></td>
				<td>
					${bfHelpIncomePlan.years}
				</td>
				<td>${bfHelpIncomePlan.card.address}</td>
				<td>
					<fmt:formatDate value="${bfHelpIncomePlan.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="bf:bfHelpIncomePlan:edit"><td>
    				<a href="${ctx}/bf/bfHelpIncomePlan/form?card.id=${bfHelpIncomePlan.card.id}">修改</a>
					<a href="${ctx}/bf/bfHelpIncomePlan/delete?id=${bfHelpIncomePlan.id}" onclick="return confirmx('确认要删除该年度帮扶及收入计划吗？', this.href)">删除</a>
					<a href="${ctx}/bf/bfHelpIncomePlan/exportPDF?card.id=${bfHelpIncomePlan.card.id}">生成帮扶手册</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
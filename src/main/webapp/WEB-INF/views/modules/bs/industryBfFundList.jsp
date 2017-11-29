<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产业发展帮扶申请表管理</title>
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
	<li class="active"><a href="${ctx}/bs/industryAssistanceApplication/industryBfFundList">扶贫产业帮扶资金发放汇总列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="countryIndustrybfCollect" action="" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label style="width: auto">乡镇：</label>
			<form:input path="county" htmlEscape="false" maxlength="50" class="input-medium"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th  width="80%">乡镇</th>
		<shiro:hasPermission name="bs:industryAssistanceApplication:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="str">
		<tr>
			<td>${str.county}</td>
			<shiro:hasPermission name="bs:industryAssistanceApplication:edit"><td>
				<a href="${ctx}/bs/industryAssistanceApplication/industryBfFundFrom?county=${str.county}">查看</a>
				<a href="${ctx}/bs/industryAssistanceApplication/exportSummary?countyName=${str.county}">镇资金汇总表</a>
			</td></shiro:hasPermission>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>

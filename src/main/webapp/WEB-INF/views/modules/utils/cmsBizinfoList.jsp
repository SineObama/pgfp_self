<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>产业信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			var data = ${fns:toJson(page.list)};

			$('.choose').click(function(){
				var id = $(this).attr('id');
				var len = data.length;
				for(var i = 0 ; i < len ; i++){
					if(id == data[i].id){
						window.opener.chooseBiz(data[i]);
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
        }

	</script>
</head>
<body>
	<form:form id="searchForm" modelAttribute="cmsBizinfo" action="${ctx}/cms/cmsBizinfo/chooseBiz" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>产业名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>产业名称</th>
				<th>产业类别</th>
				<th>最新更新者</th>
				<th>更新时间</th>
				
				<shiro:hasPermission name="cms:cmsBizinfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="cmsBizinfo">
			<tr>
				<td><a class="choose" id="${cmsBizinfo.id}">
					${cmsBizinfo.name}
				</a></td>
				<td>
					${fns:getDictLabel(cmsBizinfo.type , 'biz_type' , '')}
				</td>
				<td>${cmsBizinfo.updateBy.name}</td>
				<td>
					<fmt:formatDate value="${cmsBizinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<a class="choose" id="${cmsBizinfo.id}">选择</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
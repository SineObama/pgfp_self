<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业信息管理</title>
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
		<li class="active"><a href="${ctx}/bf/bfCompanyInfo/">企业信息列表</a></li>
		<shiro:hasPermission name="bf:bfCompanyInfo:edit"><li><a href="${ctx}/bf/bfCompanyInfo/form">企业信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfCompanyInfo" action="${ctx}/bf/bfCompanyInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>企业名称：</label>
				<form:input path="companyName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>企业名称</th>
				<th>行业</th>
				<th>工商登记号</th>
				<%--<th>企业简介</th>--%>
				<th>邮箱</th>
				<th>地址</th>
				<th>性质</th>
				<th>规模</th>
				<th>主页</th>
				<!-- <th>创建人</th>
				<th>创建时间</th>
				<th>更新人</th>
				<th>更新时间</th> -->
				<th>备注</th>
				<shiro:hasPermission name="bf:bfCompanyInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfCompanyInfo">
			<tr>
				<td><a href="${ctx}/bf/bfCompanyInfo/form?id=${bfCompanyInfo.id}">
					${bfCompanyInfo.companyName}
				</a></td>
				<td>
					${bfCompanyInfo.companyIndustry}
				</td>
				<td>
					${bfCompanyInfo.companyBusinessNo}
				</td>
				<%--<td>--%>
					<%--${bfCompanyInfo.companyDesc}--%>
				<%--</td>--%>
				<td>
					${bfCompanyInfo.companyEmail}
				</td>
				<td>
					${bfCompanyInfo.companyAddress}
				</td>
				<td>
					<c:if test="${bfCompanyInfo.companyNature eq '1'}">
						外资(欧美)
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '2'}">
						外资(非欧美)
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '3'}">
						合资
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '4'}">
						国企
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '5'}">
						民营公司
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '6'}">
						外企代表处
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '7'}">
						政府机关
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '8'}">
						事业单位
					</c:if>
					<c:if test="${bfCompanyInfo.companyNature eq '9'}">
						非盈利机构
					</c:if>
				</td>
				<td>
					
					<c:if test="${bfCompanyInfo.companyScale eq '1'}">
						少于50人
					</c:if>
					<c:if test="${bfCompanyInfo.companyScale eq '2'}">
						50-150人
					</c:if>
					<c:if test="${bfCompanyInfo.companyScale eq '3'}">
						150-500人
					</c:if>
					<c:if test="${bfCompanyInfo.companyScale eq '4'}">
						500-1000人
					</c:if>
					<c:if test="${bfCompanyInfo.companyScale eq '5'}">
						1000人以上
					</c:if>
				</td>
				<td>
					${bfCompanyInfo.companyWebsite}
				</td>
				<%-- <td>
					${bfCompanyInfo.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${bfCompanyInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bfCompanyInfo.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${bfCompanyInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td> --%>
				<td>
					${bfCompanyInfo.remarks}
				</td>
				<shiro:hasPermission name="bf:bfCompanyInfo:edit"><td>
    				<a href="${ctx}/bf/bfCompanyInfo/form?id=${bfCompanyInfo.id}">修改</a>
					<a href="${ctx}/bf/bfCompanyInfo/delete?id=${bfCompanyInfo.id}" onclick="return confirmx('确认要删除该企业信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>村 基本情况管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
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
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/filemanagement/fileManagementCountry/countryList?type=${areaFileManagement.type}">${areaFileManagement.countryLevel}档案管理列表</a></li>
		<li><a  href="" class="addCadre" data-toggle="modal" data-target="#myModal" id="addFileManagement">${areaFileManagement.countryLevel}档案管理增加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="areaFileManagement" action="${ctx}/filemanagement/fileManagementCountry/countryList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearNow}"/>
		<ul class="ul-form">
			<form:hidden path="type"/>
			<div class="control-group" style="float:left;padding-top: 2px">
				<label class="control-label">${areaFileManagement.countryLevel}:</label>
					<sys:treeselect id="area" name="area.id" value="${areaFileManagement.area.id}" labelName="area.name" labelValue="${areaFileManagement.area.name}"
									title="村" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>
			</div>

			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<c:if test="${years != null}">
		<ul class="nav nav-tabs nav-year">
			<c:forEach items="${years}" var="year">
				<c:if test="${year == areaFileManagement.years}">
					<li class="active"><a href="${ctx}/filemanagement/fileManagementCountry/countryList?years=${year}&type=${areaFileManagement.type}">&nbsp;${year}&nbsp;</a></li>
				</c:if>
				<c:if test="${year != areaFileManagement.years}">
					<li><a href="${ctx}/filemanagement/fileManagementCountry/countryList?years=${year}&type=${areaFileManagement.type}">&nbsp;${year}&nbsp;</a></li>
				</c:if>
			</c:forEach>
		</ul>
	</c:if>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>村名</th>
				<th>归属年度</th>
				<shiro:hasPermission name="record:countryBasic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="mem">
			<tr>
				<td>
					${mem.area.name}
				</td>
				<td>
					${mem.years}
				</td>
				<td>
					&nbsp;&nbsp;
					<a href="${ctx}/filemanagement/fileManagementCountry/form?id=${mem.id}&type=${mem.type}">
						查看档案详情
					</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>



<!-- 模态框（Modal） -->
<div class="modal fade" style="display: none;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	 aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title text-center" id="myModalLabel">添加${countryLevel}档案</h4>
			</div>
			<form:form action="${ctx}/filemanagement/fileManagementCountry/saveAreaFileManagement" id="editSave" modelAttribute="areaFileManagement" method="post">
				<div class="modal-body">
					<table class="table table-bordered">
						<form:hidden path="type"/>
						<tr>
							<td width="90">
								选择${countryLevel} ：
							</td>
							<td>
								<sys:treeselect id="area1" name="area.id" value="${areaFileManagement.area.id}" labelName="area.name" labelValue="${areaFileManagement.area.name}"
												title="村" url="/sys/area/treeData" extId="${area.id}" allowClear="true"/>
							</td>
						</tr>
						<tr>
							<td>
								选择年度 ：
							</td>
							<td>
								<input id="years" name="years" type="text" readonly="readonly"
									   maxlength="20" class="input-medium Wdate required"
									   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"
									   value="<fmt:formatDate value="${areaFileManagement.yearsDate}" pattern="yyyy"/>"
									   style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary">提交更改</button>
				</div>
			</form:form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->

</body>
</html>
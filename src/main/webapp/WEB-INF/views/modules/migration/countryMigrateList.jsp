<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁登记管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			return false;
		}
	</script>
</head>
<body>
<div id="importBox" class="hide">
	<form id="importForm" action="${ctx}/migration/countryMigrate/import" method="post" enctype="multipart/form-data"
		  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>
		<div class="control-group" style="margin-bottom: 5px;">
			<label class="control-label" style="width: 55px;">归属年份:</label>
			<input style="width: 60px" name="years" id="years" type="text" maxlength="20" class="input-medium Wdate required valid" required onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" data-original-title="" title="">
		</div>　　
		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
		<%--<a href="${ctx}/sys/user/import/template">下载模板</a>--%>
	</form>
</div>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/migration/countryMigrate/">基本情况列表</a></li>
	<shiro:hasPermission name="migration:countryMigrate:edit"><li><a href="${ctx}/migration/countryMigrate/form">基本情况添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="countryMigrate" action="${ctx}/migration/countryMigrate/" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li class="control-group">
			<label class="control-label">村名:</label>
		<li class="controls">
		<sys:treeselect id="area" name="area.id" value="${countryMigrate.area.id}" labelName="area.name" labelValue="${countryMigrate.area.name}"
						title="村名" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>
	</li>
		</li>


		<li><label style ="width: 60px">归属年度：</label>
			<form:input path="years" htmlEscape="false" maxlength="11" class="input-medium"/>
		</li>
		<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			<input id="btnMexport"class="btn btn-primary" type="button"value="导出"/>
			<input id="btnImport" class="btn btn-primary" type="button" value="导入">
		</li>

		<li class="clearfix">
		</li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>村名</th>
		<th>搬迁原因</th>
		<th>意愿搬迁年度</th>
		<th>归属年度</th>
		<shiro:hasPermission name="migration:countryMigrate:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="countryMigrate">
		<tr>
			<td><a href="${ctx}/migration/countryMigrate/form?id=${countryMigrate.id}">
					${countryMigrate.area.name}
			</a></td>
			<td>
					${fns:getDictLabel(countryMigrate.relocationReason,'relocation_reasons','' )}
			</td>
			<td>
					${countryMigrate.wishYear}
			</td>
			<td>
					${countryMigrate.years}
			</td>
			<shiro:hasPermission name="migration:countryMigrate:edit"><td>
				<a href="${ctx}/migration/countryMigrate/form?id=${countryMigrate.id}">修改</a>
				<a href="${ctx}/migration/countryMigrate/delete?id=${countryMigrate.id}&years=${countryMigrate.years}" onclick="return confirmx('确认要删除该移民搬迁登记吗？', this.href)">删除</a>
			</td></shiro:hasPermission>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>
<script type="text/javascript">
	$(document).ready(function() {
		$("#btnMexport").click(function(){
			top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
				if(v=="ok"){
					$("#searchForm").attr("action","${ctx}/migration/countryMigrate/export");
					$("#searchForm").submit();
					$("#searchForm").attr("action","${ctx}/migration/countryMigrate/list");
				}
			},{buttonsFocus:1});
			top.$('.jbox-body .jbox-icon').css('top','55px');
		});
		$("#btnImport").click(function(){
			$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
		});
	});
</script>
</body>
</html>
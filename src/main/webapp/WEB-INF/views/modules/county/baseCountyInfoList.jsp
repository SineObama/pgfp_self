<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>基本情况管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function () {
//				console.debug('sd');
                top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
//                    console.debug(v);
                    if (v == "ok") {
//						console.debug('asdfasf');
                        $("#searchForm").attr("action", "${ctx}/county/baseCountyInfo/export");
                        $("#searchForm").submit();
                    }
                }, {buttonsFocus: 1});
//				top.$('.jbox-body .jbox-icon').css('top','55px');
            });
            $('#btnSubmit').click(function () {
                $("#searchForm").attr("action", "${ctx}/county/baseCountyInfo/");
                page( 1 ,30);
            });
            $("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
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
	
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/county/baseCountyInfo/import" method="post" enctype="multipart/form-data"
			  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>
			<div class="control-group" style="margin-bottom: 5px;">
				<label class="control-label" style="width: 55px;">年份:</label>
					<input style="width: 60px" name="years" id="years" type="text" maxlength="20" class="input-medium Wdate required valid" required onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" data-original-title="" title="">
			</div>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<%--<a href="${ctx}/sys/user/import/template">下载模板</a>--%>
		</form>
	</div>

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/county/baseCountyInfo/">基本情况列表</a></li>
		<shiro:hasPermission name="county:baseCountyInfo:edit"><li><a href="${ctx}/county/baseCountyInfo/form">基本情况添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseCountyInfo" action="${ctx}/county/baseCountyInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label style="width: 60px">归属年度：</label>
				<form:input path="years" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
				<input id="btnImport" class="btn btn-primary" type="button" value="导入">
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>区（县）名</th>
				<th>县属性</th>
				<th>归属年度</th>
				<%--<th>更新时间</th>--%>
				<%--<th>备注</th>--%>
				<shiro:hasPermission name="county:baseCountyInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseCountyInfo">
			<tr>
				<td>
					${baseCountyInfo.area.name}
				</td>
				<td>${fns:getDictLabel(baseCountyInfo.countyAttribute, 'county_attribute', '')}</td>
				<td><a href="${ctx}/county/baseCountyInfo/form?id=${baseCountyInfo.id}">${baseCountyInfo.years}</a></td>
				<%--<td>--%>
					<%--${baseCountyInfo.remarks}--%>
				<%--</td>--%>
				<shiro:hasPermission name="county:baseCountyInfo:edit"><td>
    				<a href="${ctx}/county/baseCountyInfo/form?id=${baseCountyInfo.id}">修改</a>
					<a href="${ctx}/county/baseCountyInfo/delete?id=${baseCountyInfo.id}&years=${baseCountyInfo.years}" onclick="return confirmx('确认要删除该基本情况吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
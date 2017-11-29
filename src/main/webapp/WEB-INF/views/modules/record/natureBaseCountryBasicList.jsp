<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自然村建档立卡基本情况管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function () {
//				console.debug('sd');
                top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
//                    console.debug(v);
                    if (v == "ok") {
//						console.debug('asdfasf');
                        $("#searchForm").attr("action", "${ctx}/record/natureBaseCountryBasic/export");
                        $("#searchForm").submit();
                    }
                }, {buttonsFocus: 1});
//				top.$('.jbox-body .jbox-icon').css('top','55px');
            });
			
			$('#btnSubmit').click(function () {
                $("#searchForm").attr("action", "${ctx}/record/natureBaseCountryBasic/");
                page( 1 ,30);
            });
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
				bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			
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

	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/record/natureBaseCountryBasic/import" method="post" enctype="multipart/form-data"
			  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>
			<div class="control-group" style="margin-bottom: 5px;">
				<label class="control-label" style="width: 55px;">年份:</label>
					<input style="width: 60px" name="years" id="years" type="text" maxlength="20" class="input-medium Wdate required valid" required onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" data-original-title="" title="">
			</div>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctx}/sys/user/import/template">下载模板</a>
		</form>
	</div>

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/record/natureBaseCountryBasic/">自然村建档立卡基本情况列表</a></li>
		<shiro:hasPermission name="record:natureBaseCountryBasic:edit"><li><a href="${ctx}/record/natureBaseCountryBasic/form">自然村建档立卡基本情况添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="countryBasic" action="${ctx}/record/natureBaseCountryBasic/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearNow}"/>
		<ul class="ul-form">

			<div class="control-group" style="float:left;padding-top: 2px">
				<label class="control-label">村名:</label>

				<sys:treeselect id="area" name="area.id" value="${area.id}" labelName="area.name" labelValue="${countryBasic.area.name}"
								title="自然村" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>

			</div>

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
	<c:if test="${years != null}">
		<ul class="nav nav-tabs nav-year">
			<c:forEach items="${years}" var="year">
				<c:if test="${year == yearNow}">
					<li class="active"><a href="${ctx}/record/natureBaseCountryBasic/list?years=${year}">&nbsp;${year}&nbsp;</a></li>
				</c:if>
				<c:if test="${year != yearNow}">
					<li><a href="${ctx}/record/natureBaseCountryBasic?years=${year}">&nbsp;${year}&nbsp;</a></li>
				</c:if>
			</c:forEach>
		</ul>
	</c:if>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>村名</th>
				<th>归属年度</th>
				<th>更新时间</th>
				<shiro:hasPermission name="record:natureBaseCountryBasic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="countryBasic">
			<tr>
				<td><a href="${ctx}/record/natureBaseCountryBasic/form?id=${countryBasic.id}">
					${countryBasic.area.name}
					</a>
				</td>
				<td>
						${countryBasic.years}
				</td>
				<td>
					<fmt:formatDate value="${countryBasic.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="record:natureBaseCountryBasic:edit"><td>
    				<a href="${ctx}/record/natureBaseCountryBasic/form?id=${countryBasic.id}">修改</a>
					<a href="${ctx}/record/natureBaseCountryBasic/delete?id=${countryBasic.id}&years=${countryBasic.years}" onclick="return confirmx('确认要删除该自然村建档立卡基本情况吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>
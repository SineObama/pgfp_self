<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人补贴登记管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#btnExport').click(function(){
				top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
//					console.debug("1"+v);
					if (v == "ok") {
						$("#searchForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/export?year=${bfPoorstudentsFeecollection.years}");
						$("#searchForm").submit();
					}
				});
			});

			$('#btnSubmit').click(function () {
				$("#searchForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/list1");
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
			$("#funcParam").val(v);
			$("#searchForm").submit();
			return false;
		}
	</script>
</head>
<body>

<div id="importBox" class="hide">
	<form id="importForm" action="${ctx}/bt/bfPoorstudentsFeecollection/importFees" method="post" enctype="multipart/form-data"
		  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　
		　
		<input id="years" name="years" type="text" readonly="readonly" maxlength="20"
			   class="input-medium Wdate required"
			   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"
			   style="width: 120px;background-color: #FFFFFF;"/>

		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="导入"/>
		<%--<a href="${ctx}/sys/user/import/template">下载模板</a>--%>
	</form>
</div>

<ul class="nav nav-tabs">
	<li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/list1">个人补贴登记列表</a></li>
	<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><li><a data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">个人补贴登记添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="bfPoorstudentsFeecollection"
		   action="${ctx}/bt/bfPoorstudentsFeecollection/list1" method="post" class="breadcrumb form-search">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<input id="funcParam" name="funcParam" type="hidden" value="${page.funcParam}"/>
	<ul class="ul-form">
		<li>
			<label>填报单位：</label>
			<sys:treeselect id="office" name="office.id" value="${bfPoorstudentsFeecollection.office.id}" labelName="office.name" labelValue="${bfPoorstudentsFeecollection.office.name}"
							title="父类型" url="/sys/office/treeData" extId="${bfSubsidyType.id}" cssClass="" allowClear="true"/>

		</li>
			<%--<li><label>填报年份：</label>--%>
			<%--&lt;%&ndash;<form:input path="year" htmlEscape="false" maxlength="64" class="input-medium"/>&ndash;%&gt;--%>
			<%--<input id="years" name="years" type="text" readonly="readonly" maxlength="20"--%>
			<%--class="input-medium Wdate required" value="${bfPoorstudentsFeecollection.years}"--%>
			<%--onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"--%>
			<%--style="width: 120px;background-color: #FFFFFF;"/>--%>

			<%--</li>--%>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/></li>
		<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
		<li class="btns"><input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<ul class="nav nav-tabs">
	<%--<li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/">个人补贴登记列表</a></li>--%>
	<c:if test="${years != null}">
		<c:forEach items="${years}" var="year">
			<c:if test="${yearNow == year}">
				<li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/list1?years=${year}">${year}</a></li>
			</c:if>
			<c:if test="${yearNow != year}">
				<li><a href="${ctx}/bt/bfPoorstudentsFeecollection/list1?years=${year}">${year}</a></li>
			</c:if>
		</c:forEach>
	</c:if>
</ul>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>受帮扶人姓名</th>
		<th>身份证号码</th>
		<th>填报单位</th>
		<th>填报干部</th>
		<th>填报年份</th>
		<th>资助项目</th>
		<th>资助金额（元）</th>
		<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="bfPoorstudentsFeecollection">
		<tr>
			<td>
				<a href="${ctx}/bt/bfPoorstudentsFeecollection/edit1?id=${bfPoorstudentsFeecollection.id}">
						${bfPoorstudentsFeecollection.student.name}
				</a>
			</td>
			<td>
					${bfPoorstudentsFeecollection.student.idNumber}
			</td>
			<td>
					${bfPoorstudentsFeecollection.office.name}
			</td>
			<td>
					${bfPoorstudentsFeecollection.createBy.name}
			</td>
			<td>
					${bfPoorstudentsFeecollection.years}
			</td>
			<td>
					${bfPoorstudentsFeecollection.subsidyType.subsidyType}
			</td>
			<td>
					<fmt:formatNumber value="${bfPoorstudentsFeecollection.capital}" pattern="#0.##"/>
			</td>
			<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><td>
				<a href="${ctx}/bt/bfPoorstudentsFeecollection/edit1?id=${bfPoorstudentsFeecollection.id}">修改</a>
				<a href="${ctx}/bt/bfPoorstudentsFeecollection/delete1?id=${bfPoorstudentsFeecollection.id}" onclick="return confirmx('确认要删除该个人补贴登记吗？', this.href)">删除</a>
			</td></shiro:hasPermission>
		</tr>
	</c:forEach>
	</tbody>
</table>
<div class="pagination">${page}</div>

<%-- 模态框（Modal） --%>
<div class="modal fade"  style="display: none;width:400px;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title text-center" id="myModalLabel">个人补贴登记年份</h4>
			</div>
			<form:form action="${ctx}/bt/bfPoorstudentsFeecollection/form1" id="editSave" modelAttribute="bfPoorstudentsFeecollection" method="post" >
				<%-- <input type="hidden" id="office.id" name="office.id" value="${bfPoorstudentsFeecollection.office.id}"/> --%>
				<div style="margin-top: 13px;text-align: center;">
					选择年度：<input name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
								value="<fmt:formatDate value="${bfPoorstudentsFeecollection.yearDate}" pattern="yyyy"/>"
								onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="submit"  class="btn btn-primary">增加</button>
				</div>
			</form:form>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>

</body>

</html>
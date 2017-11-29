<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学前保教费免除登记列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#btnExport').click(function(){
				top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
//					console.debug("1"+v);
					if (v == "ok") {
						$("#searchForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/export");
						$("#searchForm").submit();
					}
				});
			});

			$("#btnExcel1").click(function(){
				top.$.jBox.confirm("确认要导出学前汇总表吗？", "系统提示", function (v, h, f) {
					if (v == "ok") {
						$("#searchForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/bfExport1?year=${bfPoorstudentsFeecollection.years}&&ss=1");
						$("#searchForm").submit();
					}
				});
			});

			$("#btnExcel2").click(function(){
				top.$.jBox.confirm("确认要导出普高汇总表吗？", "系统提示", function (v, h, f) {
					if (v == "ok") {
						$("#searchForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/bfExport1?year=${bfPoorstudentsFeecollection.years}&&ss=2");
						$("#searchForm").submit();
					}
				});
			});

			$('#btnSubmit').click(function () {
				$("#searchForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/");
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
	<form id="importForm" action="${ctx}/bt/bfPoorstudentsFeecollection/importBFFees" method="post" enctype="multipart/form-data"
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
	<li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/">学前保教费免除登记列表</a></li>
	<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><li><a data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">学前保教费免除登记添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="bfPoorstudentsFeecollection"
		   action="${ctx}/bt/bfPoorstudentsFeecollection/" method="post" class="breadcrumb form-search">
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
		<%--<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>--%>
		<li class="btns"><input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
		<li class="btns"><input id="btnExcel1" class="btn btn-primary" type="button" value="导出学前汇总表"/></li>
		<li class="btns"><input id="btnExcel2" class="btn btn-primary" type="button" value="导出普高汇总表"/></li>

		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<ul class="nav nav-tabs">
	<%--<li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/">个人补贴登记列表</a></li>--%>
	<c:if test="${years != null}">
		<c:forEach items="${years}" var="year">
			<c:if test="${yearNow == year}">
				<li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/list?years=${year}">${year}</a></li>
			</c:if>
			<c:if test="${yearNow != year}">
				<li><a href="${ctx}/bt/bfPoorstudentsFeecollection/list?years=${year}">${year}</a></li>
			</c:if>
		</c:forEach>
	</c:if>
</ul>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th style="text-align: center;">学生姓名</th>
		<th style="text-align: center;">身份证号码</th>
		<th style="text-align: center;">填报单位</th>
		<th style="text-align: center;">填报干部</th>
		<th style="text-align: center;">入学日期</th>
		<th style="text-align: center;">幼儿园保教费（元/学期）</th>
		<th style="text-align: center;">自治区拨款（元）</th>
		<th style="text-align: center;">市、县区拨款（元）</th>
		<th style="text-align: center;">是否为非本县户籍学生（是填1，否填0）</th>
		<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><th style="text-align: center;">操作</th></shiro:hasPermission>
	</tr>
	<tr>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="bfPoorstudentsFeecollection">
		<tr>
			<td style="text-align: center;">
				<a href="${ctx}/bt/bfPoorstudentsFeecollection/edit?id=${bfPoorstudentsFeecollection.id}">
						${bfPoorstudentsFeecollection.student.name}
				</a>
			</td>
			<td style="text-align: center;">
					${bfPoorstudentsFeecollection.student.idNumber}
			</td>
			<td style="text-align: center;">
					${bfPoorstudentsFeecollection.office.name}
			</td>
			<td style="text-align: center;">
					${bfPoorstudentsFeecollection.createBy.name}
			</td>
			<td style="text-align: center;">
				<fmt:formatDate value="${bfPoorstudentsFeecollection.studentHelpInfo.entranceDate}" pattern="yyyy-MM-dd"/>
			</td>
			<td style="text-align: center;">
					${bfPoorstudentsFeecollection.studentHelpInfo.tuition}
			</td>
			<td style="text-align: center;">
					${bfPoorstudentsFeecollection.municipatityAppropriation}
			</td>
			<td>
					${bfPoorstudentsFeecollection.cityCountyAppropriation}
			</td>
			<td style="text-align: center;">
					${bfPoorstudentsFeecollection.studentHelpInfo.isLocalStudent}
			</td>
			<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><td style="text-align: center;">
				<a href="${ctx}/bt/bfPoorstudentsFeecollection/edit?id=${bfPoorstudentsFeecollection.id}">修改</a>
				<a href="${ctx}/bt/bfPoorstudentsFeecollection/delete?id=${bfPoorstudentsFeecollection.id}" onclick="return confirmx('确认要删除该个人补贴登记吗？', this.href)">删除</a>
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
			<form:form action="${ctx}/bt/bfPoorstudentsFeecollection/form" id="editSave" modelAttribute="bfPoorstudentsFeecollection" method="post" >
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
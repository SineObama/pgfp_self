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
			$("funcParam").val(v);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>

<body>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctx}/record/countryBasic/import" method="post" enctype="multipart/form-data"
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
		<li class="active"><a href="${ctx}/record/countryBasic/">村 基本情况列表</a></li>
		<shiro:hasPermission name="record:countryBasic:edit"><li><a href="${ctx}/record/countryBasic/form">村 基本情况添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="countryBasic" action="${ctx}/record/countryBasic/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="funcParam" name="funcParam" type="hidden" value="${yearNow}"/>
		<ul class="ul-form">

			<div class="control-group" style="float:left;padding-top: 2px">
				<label class="control-label">村名:</label>

					<sys:treeselect id="area" name="area.id" value="${area.id}" labelName="area.name" labelValue="${countryBasic.area.name}"
									title="村" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>

			</div>

			<%--<li><label style="width: 60px">归属年度：</label>--%>
				<%--<form:input path="years" htmlEscape="false" maxlength="64" class="input-medium"/>--%>
			<%--</li>--%>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出">
				<input id="btnImport" class="btn btn-primary" type="button" value="导入">
				<%--<input id="mybtnExport" class="btn btn-primary" type="button" value="my导出">--%>
				<%--<a  data-toggle="modal" data-target="#myModal" id="addNewRecord" class="btn btn-primary addNewRecord">--%>
					<%--培训合格按年导出--%>
				<%--</a>--%>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<c:if test="${years != null}">
		<ul class="nav nav-tabs nav-year">
			<c:forEach items="${years}" var="year">
				<c:if test="${year == yearNow}">
					<li class="active"><a href="${ctx}/record/countryBasic/list?years=${year}">&nbsp;${year}&nbsp;</a></li>
				</c:if>
				<c:if test="${year != yearNow}">
					<li><a href="${ctx}/record/countryBasic?years=${year}">&nbsp;${year}&nbsp;</a></li>
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
				<shiro:hasPermission name="record:countryBasic:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="countryBasic">
			<tr>
				<td><a href="${ctx}/record/countryBasic/form?id=${countryBasic.id}">
					${countryBasic.area.name}
					</a>
				</td>
				<td>
						${countryBasic.years}
				</td>
				<td>
					<fmt:formatDate value="${countryBasic.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="record:countryBasic:edit"><td>
    				<a href="${ctx}/record/countryBasic/form?id=${countryBasic.id}">修改</a>
					<a href="${ctx}/record/countryBasic/delete?id=${countryBasic.id}&years=${countryBasic.years}" onclick="return confirmx('确认要删除该村 基本情况吗？', this.href)">删除</a>
					<a href="${ctx}/record/countryBasic/exportDoc1?countryId=${countryBasic.area.id}&years=${countryBasic.years}&countryName=${countryBasic.area.name}">导出外出务工详情</a>
					<a href="${ctx}/record/countryBasic/exportDoc?countryId=${countryBasic.area.id}&years=${countryBasic.years}">导出doc</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<div class="modal fade"  style="display: none;width:400px;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title text-center" id="myModalLabel">年度信息</h4>
				</div>
				<form:form action="${ctx}/bt/bfPoorstudentsFeecollection/myexport3" id="editSave"  method="post" >
					<%--<input type="hidden" id="oldId" name="id"/>--%>
					<!-- <input type="hidden" id="type" name="type" value="2"/> -->
					<div style="margin-top: 13px;text-align: center;">
						年度选择：<input name="years" type="text" readonly="readonly" maxlength="20" value="${fns:getDate("yyyy")}" class="input-medium Wdate required"
									onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="submit" id="dc"  class="btn btn-primary">导出</button>
					</div>
				</form:form>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/record/countryBasic/export");
						$("#searchForm").submit();
						$("#searchForm").attr("action","${ctx}/record/countryBasic/list");
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
			$("#mybtnExport").click(function(){
				top.$.jBox.confirm("确认要导出my用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctx}/bt/bfPoorstudentsFeecollection/myexport2");
						$("#searchForm").submit();
						$("#searchForm").attr("action","${ctx}/record/countryBasic/list");
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			//导出--平桂区参加扶贫移民职业技能培训合格人员名单表--按年条件--隐藏
			$("#dc").click(function(){
				$(this).parents(".modal-dialog").find(".close").trigger("click");
			});
		});
	</script>
</body>
</html>
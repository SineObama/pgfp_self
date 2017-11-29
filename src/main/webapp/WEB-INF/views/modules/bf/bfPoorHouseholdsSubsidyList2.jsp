<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户惠农补贴管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#btnExport').click(function(){
				top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
//					console.debug("1"+v);
					if (v == "ok") {
						$("#searchForm").attr("action", "${ctx}/bf/bfPoorHouseholdsSubsidy/exportNormal");
						$("#searchForm").submit();
					}
				});
			});

			$('#btnSubmit').click(function () {
				$("#searchForm").attr("action", "${ctx}/bf/bfPoorHouseholdsSubsidy/list2");
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
	<form id="importForm" action="${ctx}/bf/bfPoorHouseholdsSubsidy/importNormal" method="post" enctype="multipart/form-data"
		  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　
		　
		<%--<input id="years" name="years" type="text" readonly="readonly" maxlength="20"--%>
		<%--class="input-medium Wdate required"--%>
		<%--onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"--%>
		<%--style="width: 120px;background-color: #FFFFFF;"/>--%>
		<input type="hidden" name="type" value="1" />
		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="导入"/>
		<%--<a href="${ctx}/sys/user/import/template">下载模板</a>--%>
	</form>
</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list2">贫困户惠农补贴列表</a></li>
		<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">
			<li>
				<%--<a href="${ctx}/bf/bfPoorHouseholdsSubsidy/form">--%>
				<a  data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">
					贫困户惠农补贴添加
				</a>
			</li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfPoorHouseholdsSubsidy" action="${ctx}/bf/bfPoorHouseholdsSubsidy/list2" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.funcParam}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<input type="hidden" name="type" value="1" />
				<form:input path="regCard.houseHolderName" htmlEscape="false" maxlength="512" class="input-medium"/>
			</li>

			<%--<li><label>年度：</label>--%>
					<%--&lt;%&ndash;<form:input path="years" htmlEscape="false" maxlength="512" class="input-medium"/>&ndash;%&gt;--%>
				<%--<input name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"--%>
					   <%--value="${bfPoorHouseholdsSubsidy.years}"--%>
					   <%--onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"--%>
					   <%--style="background-color: #FFFFFF;border:1px solid #ccc;"/>--%>

			<%--</li>--%>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/></li>
			<li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="btns"><input id="btnImport" class="btn btn-primary" type="button" value="导入"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<ul class="nav nav-tabs">
		<c:if test="${years != null}">
			<c:forEach items="${years}" var="year">
				<c:if test="${yearNow == year}">
					<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list2?years=${year}">${year}</a></li>
				</c:if>
				<c:if test="${yearNow != year}">
					<li><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list2?years=${year}">${year}</a></li>
				</c:if>
			</c:forEach>
		</c:if>
	</ul>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名或组织名称</th>
				<th>身份证号或组织机构代码证号</th>
				<th>地址</th>
				<th>补贴政策</th>
				<th>归属年度</th>
				<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfPoorHouseholdsSubsidy">
			<tr>
				<td><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/view?id=${bfPoorHouseholdsSubsidy.id}">
					${bfPoorHouseholdsSubsidy.regCard.houseHolderName}
					</a>
				</td>
				<td>${bfPoorHouseholdsSubsidy.member.idNumber}</td>
				<td>${bfPoorHouseholdsSubsidy.regCard.address}</td>
				<%--<td>农机购置</td>--%>
				<td>
					${bfPoorHouseholdsSubsidy.subType.subsidyType}
				</td>
				<td>
					<%--<fmt:formatDate value="${bfPoorHouseholdsSubsidy.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
					${bfPoorHouseholdsSubsidy.years}
				</td>
				<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit"><td>
    				<a href="${ctx}/bf/bfPoorHouseholdsSubsidy/view?id=${bfPoorHouseholdsSubsidy.id}">修改</a>
					<a href="${ctx}/bf/bfPoorHouseholdsSubsidy/delete?id=${bfPoorHouseholdsSubsidy.id}" onclick="return confirmx('确认要删除该贫困户惠农补贴吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>

	<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">
		<%-- 模态框（Modal） --%>
		<div class="modal fade"  style="display: none;width:400px;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title text-center" id="myModalLabel">添加户年度信息</h4>
					</div>
					<form:form action="${ctx}/bf/bfPoorHouseholdsSubsidy/form" id="editSave" modelAttribute="bfPoorHouseholdsSubsidyModel" method="post" >
						<%--<input type="hidden" id="oldId" name="id"/>--%>
						<input type="hidden" id="type" name="type" value="1"/>
						<div style="margin-top: 13px;text-align: center;">
							新增年度：<input name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
										pattern="yyyy"
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
	</shiro:hasPermission>
</body>
</html>
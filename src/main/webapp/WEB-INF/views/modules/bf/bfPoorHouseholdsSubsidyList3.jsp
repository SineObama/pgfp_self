<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>农村危房改造管理</title>
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
				$("#searchForm").attr("action", "${ctx}/bf/bfPoorHouseholdsSubsidy/list3");
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
	<form id="importForm" action="${ctx}/bf/bfPoorHouseholdsSubsidy/importNormal" method="post" enctype="multipart/form-data"
		  class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
		<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　
		　
		<%--<input id="years" name="years" type="text" readonly="readonly" maxlength="20"--%>
			   <%--class="input-medium Wdate required"--%>
			   <%--onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"--%>
			   <%--style="width: 120px;background-color: #FFFFFF;"/>--%>
		<input type="hidden" name="type" value="0" />
		<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="导入"/>
		<%--<a href="${ctx}/sys/user/import/template">下载模板</a>--%>
	</form>
</div>

	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list3">农村危房改造列表</a></li>
		<%--<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit"><li><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/form">贫困户补贴添加</a></li></shiro:hasPermission>--%>
		<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit">
			<li>
				<a  data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">
					农村危房改造按年添加
				</a>
			</li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bfPoorHouseholdsSubsidy" action="${ctx}/bf/bfPoorHouseholdsSubsidy/list1" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<input type="hidden" name="type" value="0" />
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
	<c:if test="${yearnow!=null}">
		<ul class="nav nav-tabs">
			<c:forEach items="${yearsList}" var="years">
				<c:if test="${yearnow==years}">
					<li class="active"><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list3?years=${years}">${years}</a></li>
				</c:if>
				<c:if test="${yearnow!=years}">
					<li ><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/list3?years=${years}">${years}</a></li>
				</c:if>
				
			</c:forEach>
		</ul>
	</c:if>
	
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>村民小组</th>
				<th>姓名</th>
				<th>身份证号</th>
				<!-- <th>户口本号</th> -->
				<th>农民贫困类型</th>
				<!-- <th>补贴总量/面积</th> -->
				<th>补贴金额</th>
				<!-- <th>兑付时间</th> -->
				<th>归属年度</th>
				<shiro:hasPermission name="bf:bfPoorHouseholdsSubsidy:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfPoorHouseholdsSubsidy">
			<tr>
				<td>${bfPoorHouseholdsSubsidy.regCard.country.name}</td>
				<td><a href="${ctx}/bf/bfPoorHouseholdsSubsidy/view?id=${bfPoorHouseholdsSubsidy.id}">
					${bfPoorHouseholdsSubsidy.regCard.houseHolderName}
					</a>
				</td>
				<td>${bfPoorHouseholdsSubsidy.member.idNumber}</td>
				<%-- <td>${bfPoorHouseholdsSubsidy.regCard.residenceBookletNumber}</td> --%>
				<td>${bfPoorHouseholdsSubsidy.subType.subsidyType}</td>
				<%-- <td>${bfPoorHouseholdsSubsidy.sbMountArea}</td> --%>
				<td>${bfPoorHouseholdsSubsidy.sbAmount}</td>
				<%-- <td><fmt:formatDate value="${bfPoorHouseholdsSubsidy.honourTime}" pattern="yyyy-MM-dd"/> </td> --%>

				<td>
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
						<input type="hidden" id="type" name="type" value="2"/>
						<div style="margin-top: 13px;text-align: center;">
							新增年度：<input name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>培训信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("input[name=id]").each(function(){
				var trainInfoSelect = null;
				if (top.mainFrame.cmsMainFrame){
					trainInfoSelect = top.mainFrame.cmsMainFrame.trainInfoSelect;
				}else{
					trainInfoSelect = top.mainFrame.trainInfoSelect;
				}
				for (var i=0; i<trainInfoSelect.length; i++){
					if (trainInfoSelect[i][0]==$(this).val()){
						this.checked = true;
					}
				}
				$(this).click(function(){
					var id = $(this).val(), title = $(this).attr("title");
					if (top.mainFrame.cmsMainFrame){
						top.mainFrame.cmsMainFrame.trainInfoSelectAddOrDel(id, title);
					}else{
						top.mainFrame.trainInfoSelectAddOrDel(id, title);
					}
				});
			});
		});
		function view(href){
			top.$.jBox.open('iframe:'+href,'查看培训',$(top.document).width()-220,$(top.document).height()-120,{
				buttons:{"关闭":true},
				loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
					$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
				}
			});
			return false;
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
<div style="margin:10px;">
	<form:form id="searchForm" modelAttribute="bfTrain" action="${ctx}/bf/bfTrain/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>培训名称：</label>
				<form:input path="trainTitle" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>选择</th>
				<th>培训标题</th>
				<th>培训单位</th>
				<th>培训企业</th>
				<th>培训开始时间</th>
				<th>培训结束时间</th>
				<th>培训地址</th>
				<th>培训负责人</th>
				<th>负责人电话</th>
				<th>培训人数</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfTrain">
			<tr>
				<td style="text-align:center;">
					<%-- <input type="checkbox" name="id" value="${bfTrain.id}" title="${fns:abbr(article.title,40)}" /> --%>
					<input type="radio" name="id" value="${bfTrain.id}" title="${fns:abbr(bfTrain.trainTitle,40)}" />
				</td>
				
				<td><a href="${ctx}/bf/bfTrain/form?id=${bfTrain.id}">
					${bfTrain.trainTitle}
				</a></td>
				<td>
					${bfTrain.office.name}
				</td>
				<td>
					${bfTrain.companyName}
				</td>
				<td>
					${bfTrain.startTime}
				</td>
				<td>
					${bfTrain.endTime}
				</td>
				<td>
					${bfTrain.address}
				</td>
				<td>
					${bfTrain.trainMgr}
				</td>
				<td>
					${bfTrain.mgrPhone}
				</td>
				<td>
					${bfTrain.trainPersonNum}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>企业信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("input[name=id]").each(function(){
				var companyInfoSelect = null;
				if (top.mainFrame.cmsMainFrame){
					companyInfoSelect = top.mainFrame.cmsMainFrame.companyInfoSelect;
				}else{
					companyInfoSelect = top.mainFrame.companyInfoSelect;
				}
				for (var i=0; i<companyInfoSelect.length; i++){
					if (companyInfoSelect[i][0]==$(this).val()){
						this.checked = true;
					}
				}
				$(this).click(function(){
					var id = $(this).val(), title = $(this).attr("title");
					if (top.mainFrame.cmsMainFrame){
						top.mainFrame.cmsMainFrame.companyInfoSelectAddOrDel(id, title);
					}else{
						top.mainFrame.companyInfoSelectAddOrDel(id, title);
					}
				});
			});
		});
		function view(href){
			top.$.jBox.open('iframe:'+href,'查看企业',$(top.document).width()-220,$(top.document).height()-120,{
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
	<form:form id="searchForm" modelAttribute="bfCompanyInfo" action="${ctx}/bf/bfCompanyInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>企业名称：</label>
				<form:input path="companyName" htmlEscape="false" maxlength="100" class="input-medium"/>
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
				<th>企业名称</th>
				<th>行业</th>
				<th>工商登记号</th>
				<th>企业简介</th>
				<th>创建人</th>
				<th>创建时间</th>
				<th>更新人</th>
				<th>更新时间</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bfCompanyInfo">
			<tr>
				<td style="text-align:center;">
					<%-- <input type="checkbox" name="id" value="${bfCompanyInfo.id}" title="${fns:abbr(article.title,40)}" /> --%>
					<input type="radio" name="id" value="${bfCompanyInfo.id}" title="${fns:abbr(bfCompanyInfo.companyName,40)}" />
				</td>
				
				<td><a href="${ctx}/bf/bfCompanyInfo/form?id=${bfCompanyInfo.id}">
					${bfCompanyInfo.companyName}
				</a></td>
				<td>
					${bfCompanyInfo.companyIndustry}
				</td>
				<td>
					${bfCompanyInfo.companyBusinessNo}
				</td>
				<td>
					${bfCompanyInfo.companyDesc}
				</td>
				<td>
					${bfCompanyInfo.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${bfCompanyInfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bfCompanyInfo.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${bfCompanyInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bfCompanyInfo.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁规划管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/migration/countryMigrate/">基本情况列表</a></li>
 <%--<li><a href="${ctx}/migration/bNaturalVillageRelocationPlan/">移民搬迁规划列表</a></li>--%>
	<li class="active"><a href="${ctx}/migration/bNaturalVillageRelocationPlan/form?id=${bNaturalVillageRelocationPlan.id}">移民搬迁规划<shiro:hasPermission name="migration:bNaturalVillageRelocationPlan:edit">${not empty bNaturalVillageRelocationPlan.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="migration:bNaturalVillageRelocationPlan:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/migration/countryMigrate/form?id=${bNaturalVillageRelocationPlan.countryMigrateId}">基本情况</a></li>
		<li><a href="${ctx}/migration/relocationPlanSituation/form?countryMigrateId=${bNaturalVillageRelocationPlan.countryMigrateId}">移民搬迁情况</a></li>
		<li class="active"><a>移民搬迁规划</a></li>
		<li><a href="${ctx}/migration/bRelocationFinishStatus/form?countryMigrateId=${bNaturalVillageRelocationPlan.countryMigrateId}">任务完成情况</a></li>
		<li><a href="${ctx}/migration/table/form?countryMigrateId=${bNaturalVillageRelocationPlan.countryMigrateId}">填表</a></li>
	</ul>
	<div id="tab-3" class="content-detail">
		<c:choose>
		<c:when test="${empty bNaturalVillageRelocationPlan.countryMigrateId}">
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
		 <form:form id="inputForm" modelAttribute="countryMigrate" action="${ctx}/migration/bNaturalVillageRelocationPlan/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			 <form:hidden path="years"/>
			<%--<form:hidden path="countryMigrateId"/>--%>
			<sys:message content="${message}"/>
		<table class="tab3-table">
			<tbody id="accpitem" class="tbody" >
			<tr>
				<td class="thr-td "colspan="4" style="text-align: center">
					纳入移民搬迁年度规划
				</td>
			</tr>
			</tbody>
			  <c:if test="${countryMigrate.bNaturalVillageRelocationPlans != null && !countryMigrate.bNaturalVillageRelocationPlans.isEmpty()}">
				<c:forEach items="${countryMigrate.bNaturalVillageRelocationPlans}" var="bNaturalVillageRelocationPlan" varStatus="status">
					<tbody id="accpitem" class="tbody" >
					<tr>
						<input type="hidden" id="bNaturalVillageRelocationPlans[${status.index}].id" name="bNaturalVillageRelocationPlans[${status.index}].id" value="${bNaturalVillageRelocationPlan.id}"class="id"/>
						<input type="hidden" id="bNaturalVillageRelocationPlans[${status.index}].countryMigrateId" name="bNaturalVillageRelocationPlans[${status.index}].countryMigrateId" value="${bNaturalVillageRelocationPlan.countryMigrateId}" class="countryMigrateId"/>
						<td class="fir-td bg-white"rowspan="2"style="padding: 0">
							<input name="bNaturalVillageRelocationPlans[${status.index}].particularYear" style="background-color: #fff" type="text" readonly="readonly" maxlength="20" class="particularYear input-medium Wdate  required"
								   value="<fmt:formatDate value="${countryMigrate.bNaturalVillageRelocationPlans[status.index].yearDate}" pattern="yyyy"/>"
								   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
						</td>
						<td class="thr-td">
							<span>纳入移民搬迁规划户数（户）</span>
						</td>
						<td class="fou-td bg-white">
								<form:input path="bNaturalVillageRelocationPlans[${status.index}].households" htmlEscape="false" maxlength="11" class="households input-xlarge required int"/>
						</td>
						<td rowspan="2" style="text-align: center;cursor: pointer;">
							<span class="del-thisTbody-btn">删除</span>
						</td>
					</tr>
					<tr>
						<td class="thr-td">
							<span>纳入移民搬迁规划人数（人）</span>
						</td>
						<td class="fou-td bg-white">
							<form:input path="bNaturalVillageRelocationPlans[${status.index}].peoplePopulations" htmlEscape="false" maxlength="11" class="peoplePopulations input-xlarge required int"/>
						</td>
					</tr>
					</tbody>
				</c:forEach>
			</c:if>
		</table>
		<p ></p>
			<div class="content-save"><input type="button" value="添 加" class="save-btn addPlus-btn" style="margin-right: 20px">
			<input type="submit" value="保 存" class="save-btn"></div>
		</form:form>
		</c:otherwise>
		</c:choose>
		<script>
			$(function () {
//					  $('.tabs').tabslet({
//						  animation: true,
//						  active: 2
//					  });
				$(".content-nav li").each(function () {
					$(this).click(function () {
						$(".header-rt").text($(this).text())
					})
				});
				$(".addPlus-btn").on('click', function(event) {
					var _len=$(".tbody").length -1 ;
//					console.debug('_len = '+ _len);
					var tbodyHtml = "<tbody class='tbody'>" +
							"<tr>" +
							"<td class='fir-td bg-white' rowspan='2' style='padding: 0'>" +
							"<input name='bNaturalVillageRelocationPlans["+_len+"].particularYear' type='text' style='background-color:#fff' readonly='readonly' maxlength='20' class='particularYear input-medium Wdate  required' value=''  onclick='WdatePicker({dateFmt:\"yyyy\",isShowClear:false});'>" +
							"</td>" +
							"<td class='thr-td'>" + "<span>纳入移民搬迁规划户数（户）</span>" +
							"</td>" +
							"<td class='fou-td bg-white'>" +
							"<input type='text' class='households input-xlarge  required int' name='bNaturalVillageRelocationPlans["+_len+"].households'>" +
							"</td>" +
							"<td rowspan='2' style='text-align: center;cursor: pointer;'>" +
							"<span class='del-thisTbody-btn'>删除</span></td>" +
							"</tr>" +
							"<tr>" +
							"<td class='thr-td'><span>纳入移民搬迁规划人数（人)</span></td>" +
							"<td class='fou-td bg-white'>" +
							"<input type='text' class='peoplePopulations input-xlarge  required int' name='bNaturalVillageRelocationPlans["+_len+"].peoplePopulations'>" +
							"</td>" +
							"</tr>" +
							"</tbody>";
//					console.log("test!")
					$("#tab-3 table:last").append(tbodyHtml);
					rename();
				});
				$("#tab-3").delegate('.del-thisTbody-btn','click', function(event) {
					$(this).parents("tbody").remove();
					rename();
				});
				function rename() {
					var i = -1;
					$('.tbody').each(function () {
//						console.debug("i = "+i);
						$(this).children('tr').children('td').children('.particularYear').attr('name', 'bNaturalVillageRelocationPlans[' + i + '].particularYear');
						$(this).children('tr').children('td').children('.households').attr('name', 'bNaturalVillageRelocationPlans[' + i + '].households');
						$(this).children('tr').children('td').children('.peoplePopulations').attr('name', 'bNaturalVillageRelocationPlans[' + i + '].peoplePopulations');
						i++;
					});
				};
			});
		</script>
</div>
	</div>
</body>
</html>
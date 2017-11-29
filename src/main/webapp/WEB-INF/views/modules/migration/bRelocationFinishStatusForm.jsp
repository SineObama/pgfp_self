<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务完成情况管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/style.css"/>
	<style>
		.content-detail td{
			min-width: 0!important;
		}
		.bg-white input{
			border: none;
		}
	</style>
	<script type="text/javascript">
		<%-- 添加按钮js--%>
		$(document).ready(function() {
			$(".addPlus-btn").click(function(){
//		tbody
				var _len=$("#accpitem tbody").length ;
//				console.debug("_len = " + _len);
				var trHtml ="<tbody>"
						+"<tr class='fir-td bg-white' style='border: 0'>"
						+"<td class='fir-td'colspan='2'style='border: 0'>"
						+"<span></span>"
						+"</td>"
						+"<td class='fir-td bg-white'style='border: 0'>"
						+"<span >"
						+"<input name='bRelocationFinishStatuses["+_len+"].particularYear' type='text' readonly='readonly' maxlength='20' style='background-color: #fff' class=' particularYear input-medium Wdate required ' value='' onclick='WdatePicker({dateFmt:\"yyyy\",isShowClear:false});' />"
						+"</span>"
						+"</td>"
						+"<td class='fir-td'colspan='2' style='border: 0'>"
						+"<span style='font-weight:bold;'>年度移民任务完成情况</span>"
						+"</td>"
						+"<td style='text-align: center;border: 0;cursor: pointer'>"
						+"<b class='del-thistd-btn'>[删除]</b></td>"
						+"</tr>"
						+"<tr width='50%'>"
						+"<td class='fir-td' rowspan='2'><span>未开工</span></td>"
						+"<td class='thr-td'><span>户数（户）</span></td>"
						+"<td class='fou-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].notStartedHouseholds' htmlEscape='false' maxlength='11' class=' int notStartedHouseholds'/>"
						+"</td>"
						+"<td class='fir-td' rowspan='2' ><span>正在建房</span></td>"
						+"<td class='thr-td'><span>户数（户）</span></td>"
						+"<td class='fou-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].buildingHouseholds' htmlEscape='false' maxlength='11' class=' int buildingHouseholds'/>"
						+"</td>"
						+"</tr>"
						+"<tr>"
						+"<td class='fir-td'><span>人数（人）</span>"
						+"</td>"
						+"<td class='sec-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].notStartedPopulations' htmlEscape='false' maxlength='11' class=' int notStartedPopulations'/>"
						+"</td>"
						+"<td class='fir-td'><span>人数（人）</span>"
						+"</td>"
						+"<td class='sec-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].buildingPopulations' htmlEscape='false' maxlength='11' class=' int buildingPopulations'/>"
						+"</td>"
						+"</tr>"
						+"<tr>"
						+"<td class='fir-td' rowspan='2'><span>主体工程已完工</span></td>"
						+"<td class='thr-td'><span>户数（户）</span></td>"
						+"<td class='fou-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].startedHouseholds' htmlEscape='false' maxlength='11' class=' int startedHouseholds'/>"
						+"</td>"
						+"<td class='fir-td'rowspan='2'><span>已入住</span></td>"
						+"<td class='thr-td'><span>户数（户）</span></td>"
						+"<td class='fou-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].stayHouseholds' htmlEscape='false' maxlength='11' class=' int stayHouseholds'/>"
						+"</td>"
						+"</tr>"
						+"<tr>"
						+"<td class='fir-td'><span>人数（人）</span></td>"
						+"<td class='sec-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].startedPopulations' htmlEscape='false' maxlength='11' class='startedPopulations  int'/>"
						+"</td>"
						+"<td class='fir-td'><span>人数（人）</span></td>"
						+"<td class='sec-td bg-white'>"
						+"<input name='bRelocationFinishStatuses["+_len+"].stayPopulations' htmlEscape='false' maxlength='11' class='stayPopulations int'/>"
						+"</td>"
						+"</tr>"
						+"</tbody>";
//				$(this).append(trHtml);
				//$(this).append(trHtml);
				$("#tab-4 table:last").append(trHtml);
				rename();
			//	rename();
			})
			$("#tab-4").delegate(".del-thistd-btn","click",function(){
//				console.log("test")
				$(this).parents("tbody").remove();
				rename();
			});

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

		function rename() {
//			console.debug("renamedfg");
			var i =-1;
			$('#accpitem tbody').each(function () {
//				console.debug("i = "+i);
				$(this).find('.id').attr('name','bRelocationFinishStatuses['+i+'].id');
				$(this).find('.countryMigrateId').attr('name','bRelocationFinishStatuses['+i+'].countryMigrateId');
				$(this).find('.particularYear').attr('name','bRelocationFinishStatuses['+i+'].particularYear');
				$(this).find('.notStartedHouseholds').attr('name', 'bRelocationFinishStatuses['+i+'].notStartedHouseholds');
				$(this).find('.buildingHouseholds').attr('name', 'bRelocationFinishStatuses['+i+'].buildingHouseholds');
				$(this).find('.notStartedPopulations').attr('name', 'bRelocationFinishStatuses['+i+'].notStartedPopulations');
				$(this).find('.buildingPopulations').attr('name', 'bRelocationFinishStatuses['+i+'].buildingPopulations');
				$(this).find('.startedHouseholds').attr('name', 'bRelocationFinishStatuses['+i+'].startedHouseholds');
				$(this).find('.stayHouseholds').attr('name', 'bRelocationFinishStatuses['+i+'].stayHouseholds');
				$(this).find('.startedPopulations').attr('name', 'bRelocationFinishStatuses['+i+'].startedPopulations');
				$(this).find('.stayPopulations').attr('name', 'bRelocationFinishStatuses['+i+'].stayPopulations');
				i++;
			});
		};
	</script>
</head>
<body>
<script src="${ctxStatic}/ckeditor/adapters/jquery.js"></script>
<script src="${ctxStatic}/pgfp/js/jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/migration/countryMigrate/">基本情况列表</a></li>
   <%--<li><a href="${ctx}/migration/bRelocationFinishStatus/">任务完成情况列表</a></li>--%>
	<li class="active"><a href="${ctx}/migration/bRelocationFinishStatus/form?id=${bRelocationFinishStatus.id}">任务完成情况<shiro:hasPermission name="migration:bRelocationFinishStatus:edit">${not empty bRelocationFinishStatus.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="migration:bRelocationFinishStatus:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/migration/countryMigrate/form?id=${bRelocationFinishStatus.countryMigrateId}">基本情况</a></li>
		<li><a href="${ctx}/migration/relocationPlanSituation/form?countryMigrateId=${bRelocationFinishStatus.countryMigrateId}">移民搬迁情况</a></li>
		<li><a href="${ctx}/migration/bNaturalVillageRelocationPlan/form?countryMigrateId=${bRelocationFinishStatus.countryMigrateId}">移民搬迁规划</a></li>
		<li class="active"><a>任务完成情况</a></li>
		<li><a href="${ctx}/migration/table/form?countryMigrateId=${bRelocationFinishStatus.countryMigrateId}">填表</a></li>
	</ul>
	<div id="tab-4" class="content-detail">
		<c:choose>
		<c:when test="${empty bRelocationFinishStatus.countryMigrateId}">
		<script>
			alert("请先填写基本情况！");
			window.history.back(-1);
		</script>
		</c:when>
		<c:otherwise>
		  <form:form id="inputForm" modelAttribute="countryMigrate" action="${ctx}/migration/bRelocationFinishStatus/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="years"/>
			<form:hidden path="countryMigrateId"/>
			<sys:message content="${message}"/>
		<table id="accpitem">
			<tr>
				<td class="thr-td "colspan="6" style="text-align: center">
					移民搬迁任务完成情况
				</td>
			</tr>
			<c:if test="${countryMigrate.bRelocationFinishStatuses != null && !countryMigrate.bRelocationFinishStatuses.isEmpty()}">
			<c:forEach items="${countryMigrate.bRelocationFinishStatuses}" var="bRelocationFinishStatus" varStatus="status">
				<tbody  class="tbody" >
			<%--任务完成标题--%>
			<%--<input type="hidden" name="bRelocationFinishStatuses[${status.index}].id"/>--%>
				<%--<input type="hidden" name="bRelocationFinishStatuses[${status.index}].countryMigrateId"/>--%>

                   <tr class="fir-td bg-white" style="border: 0">
			               <input type="hidden" id="bRelocationFinishStatuses[${status.index}].id" name="bRelocationFinishStatuses[${status.index}].id" value="${bRelocationFinishStatus.id}" class="id"/>
						   <input type="hidden" id="bRelocationFinishStatuses[${status.index}].countryMigrateId" name="bRelocationFinishStatuses[${status.index}].countryMigrateId" value="${bRelocationFinishStatus.countryMigrateId}" class="countryMigrateId"/>
                    <td class="fir-td"colspan="2"style="border: 0"><span></span></td>
                    <td class="fir-td bg-white"style="border: 0">
                    <span >
                        <input name="bRelocationFinishStatuses[${status.index}].particularYear" type="text" readonly="readonly" maxlength="20" style="background-color: #fff" class=" particularYear input-medium Wdate required "
                               value="<fmt:formatDate value='${countryMigrate.bRelocationFinishStatuses[status.index].yearDate}' pattern='yyyy'/>"
                               onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" />
                    </span>
                    </td>
                    <td class="fir-td"colspan="2" style="border: 0"><span style="font-weight:bold;">年度移民任务完成情况</span></td>
                    <td style="text-align: center;border: 0;cursor: pointer"><b class="del-thistd-btn">[删除]</b></td>
                </tr>
                <%--任务完成表--%>
			<tr>
				<td class="fir-td"rowspan="2" ><span>未开工</span></td>
				<td class="thr-td"><span>户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="bRelocationFinishStatuses[${status.index}].notStartedHouseholds" htmlEscape="false" maxlength="11" class="notStartedHouseholds required int "/>
				</td>
				<td class="fir-td"rowspan="2" width="16.8%"><span>正在建房</span></td>
				<td class="thr-td" ><span>户数（户）</span></td>
				<td class="fou-td bg-white" width="16.8%">
					<form:input path="bRelocationFinishStatuses[${status.index}].buildingHouseholds" htmlEscape="false" maxlength="11" class="buildingHouseholds required int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>人数（人）</span></td>
				<td class="sec-td bg-white">
					<form:input path="bRelocationFinishStatuses[${status.index}].notStartedPopulations" htmlEscape="false" maxlength="11" class=" notStartedPopulations input-xlarge required int"/>
				</td>
				<td class="fir-td"><span>人数（人）</span></td>
				<td class="sec-td bg-white">

					<form:input path="bRelocationFinishStatuses[${status.index}].buildingPopulations" htmlEscape="false" maxlength="11" class="buildingPopulations input-xlarge required int "/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"rowspan="2"><span>主体工程已完工</span></td>
				<td class="thr-td"><span>户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="bRelocationFinishStatuses[${status.index}].startedHouseholds" htmlEscape="false" maxlength="11" class="startedHouseholds input-xlarge required int "/>
				</td>
				<td class="fir-td"rowspan="2"><span>已入住</span></td>
				<td class="thr-td"><span>户数（户）</span></td>
				<td class="fou-td bg-white">
					<form:input path="bRelocationFinishStatuses[${status.index}].stayHouseholds" htmlEscape="false" maxlength="11" class="  stayHouseholds input-xlarge required int"/>
				</td>
			</tr>
			<tr>
				<td class="fir-td"><span>人数（人）</span></td>
				<td class="sec-td bg-white">
					<form:input path="bRelocationFinishStatuses[${status.index}].startedPopulations" htmlEscape="false" maxlength="11" class="startedPopulations input-xlarge required int "/>
				</td>
				<td class="fir-td"><span>人数（人）</span></td>
				<td class="sec-td bg-white">
					<form:input path="bRelocationFinishStatuses[${status.index}].stayPopulations" htmlEscape="false" maxlength="11" class=" stayPopulations input-xlarge required int"/>
				</td>
			</tr>
			</tbody>
			</c:forEach>
			</c:if>
		</table>
		<div class="content-save">
			<input type="button" value="添 加" class="save-btn addPlus-btn" style="margin-right: 20px">
			<input type="submit" value="保 存" class="save-btn">
		</div>
			  </div>
		</form:form>
	    </c:otherwise>
		</c:choose>
	</div>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>驻村工作队情况_干部表管理</title>
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
	<li><a href="${ctx}/record/countryBasic/">村 基本情况列表</a></li>
		<%--<li><a href="${ctx}/record/workForceOffice/">驻村工作队情况_干部表列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/workForceOffice/form?countryBasicId=${countryBasic.id}">驻村单位<shiro:hasPermission name="record:workForceOffice:edit">${not empty workForceOffice.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:workForceOffice:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/countryBasic/form?id=${countryBasic.id}">基本情况</a></li>
		<li><a href="${ctx}/record/devIncome/form?countryBasicId=${countryBasic.id}">收入状况</a></li>
		<li><a href="${ctx}/record/roadConditon/form?countryBasicId=${countryBasic.id}">村级道路情况</a></li>
		<li><a href="${ctx}/record/drinkWater/form?countryBasicId=${countryBasic.id}">饮水情况</a></li>
		<li><a href="${ctx}/record/countryPower/form?countryBasicId=${countryBasic.id}">农村电力保障</a></li>
		<li><a href="${ctx}/record/countryHouse/form?countryBasicId=${countryBasic.id}">住房情况</a></li>
		<li><a href="${ctx}/record/sociologyEnsure/form?countryBasicId=${countryBasic.id}">社会保障</a></li>
		<li><a href="${ctx}/record/healthStatus/form?countryBasicId=${countryBasic.id}">卫生状况</a></li>
		<li><a href="${ctx}/record/cultureBuild/form?countryBasicId=${countryBasic.id}">文化建设</a></li>
		<li><a href="${ctx}/record/villageInfo/form?countryBasicId=${countryBasic.id}">贫困村信息化</a></li>
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${countryBasic.id}">雨露计划</a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${countryBasic.id}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${countryBasic.id}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${countryBasic.id}">特色产业增收</a></li>
		<li class="active"><a>驻村单位</a></li>
		<li><a href="${ctx}/record/cadreCountryInfo/form?countryId=${countryBasic.id}">驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${countryBasic.id}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${countryBasic.id}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${countryBasic.id}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${countryBasic.id}">两委班子情况</a></li>
	</ul>
	<div id="tab-15" class="content-detail">
		<c:choose>
		<c:when test="${empty countryBasic.id}">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>
		<form:form id="inputForm" modelAttribute="countryBasic" action="${ctx}/record/workForceOffice/save" method="post" class="form-horizontal">
			<sys:message content="${message}"/>
			<form:hidden path="id"/>
			<form:hidden path="years"/>
			<table>
				<tbody id="accpitem">
				<tr>
					<td width="127">B91-1单位名称</td>
					<td width="127">B91-4联系电话</td>
					<td width="128">B91-2联系人</td>
					<td width="128">B91-5帮扶时间</td>
					<td width="128">B91-3单位隶属关系</td>
					<td style="text-align: center;cursor: pointer;width: 132px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
				</tr>
				<c:if test="${countryBasic.workForceOffices != null && !countryBasic.workForceOffices.isEmpty()}">
				<c:forEach items="${countryBasic.workForceOffices}" var="workForceOffice" varStatus="status">
				<tr>
					<td class="bg-white">
						<input type="hidden" name="workForceOffices[${status.index}].id" value="${workForceOffice.id}" class="id"/>
						<input type="hidden" name="workForceOffices[${status.index}].countryBasicId" class="countryBasicId" value="${workForceOffice.countryBasicId}"/>
						<form:input path="workForceOffices[${status.index}].b911OfficeId" htmlEscape="false" maxlength="255" class="b911OfficeId input-xlarge "/>
					</td>
					<td class="bg-white">
						<form:input path="workForceOffices[${status.index}].b914Phone" htmlEscape="false" maxlength="64" class="b914Phone input-xlarge phoneChange"/>
					</td>
					<td class="bg-white">
						<form:input path="workForceOffices[${status.index}].b912Contacts" htmlEscape="false" maxlength="64" class="b912Contacts input-xlarge "/>
					</td>
					<td class="bg-white">
						<input name="workForceOffices[${status.index}].b915AssistDate" type="text" readonly="readonly" maxlength="20" class="b915AssistDate input-medium Wdate"
							   value="<fmt:formatDate value="${countryBasic.workForceOffices[status.index].b915AssistDate}" pattern="yyyy-MM-dd"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</td>
					<td class="bg-white">
						<%--<form:input path="workForceOffices[${status.index}].b913Relation" htmlEscape="false" maxlength="255" class="b913Relation input-xlarge "/>--%>
						<form:select path="workForceOffices[${status.index}].b913Relation" class="b913Relation"
									 items="${fns:getDictList('affiliation')}" itemLabel="label" itemValue="value"/>
					</td>
					<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
					</c:forEach>
					</c:if>
				</tr>
				</tbody>
			</table>
			<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
       </form:form>
		</c:otherwise>
		</c:choose>
</div>
		<script>
			$(function () {
				$(".content-nav li").each(function () {
					$(this).click(function () {
						$(".header-rt").text($(this).text())
					})
				})
				$(".add-tr-btn").click(function(){
					var _len=$("#accpitem tr").length - 1;
					var trHtml = '<tr>' +
							'<td class="bg-white">' +
							'<input type="hidden" name="workForceOffices['+_len+'].id"  class="id">'+
							'<input type="hidden" name="workForceOffices['+_len+'].countryBasicId" class="countryBasicId" >'+
							'<input id="workForceOffices'+_len+'.b911OfficeId" name="workForceOffices['+_len+'].b911OfficeId" class="b911OfficeId input-mini required " type="text"  maxlength="10">'+
							'</td><td class="bg-white">' +
							'<input id="workForceOffices'+_len+'.b914Phone" name="workForceOffices['+_len+'].b914Phone" class="b914Phone mobile" type="text" >'+
							'</td><td class="bg-white">' +
							'<input id="workForceOffices'+_len+'.b912Contacts" name="workForceOffices['+_len+'].b912Contacts" class="b912Contacts" type="text" >'+
							'</td><td class="bg-white">' +
							'<input id="b915AssistDate" name="workForceOffices['+_len+'].b915AssistDate" type="text" readonly="readonly" maxlength="20" class="b915AssistDate input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
							'</td>' +
							'<td class="bg-white">'+
							'<select id="workForceOffices'+_len+'.b913Relation" name="workForceOffices['+_len+'].b913Relation" class="b913Relation select2-offscreen" tabindex="-1">'+
							'<option>-----------</option>'+
							'<option value="1">中央</option>'+
							'<option value="2">省</option>'+
							'<option value="3">市</option>'+
							'<option value="4">县</option>'+
							'<option value="5">乡镇</option>'+
							'<option value="6">部队</option>'+
							'<option value="99">其他</option>'+
							'</select>'+
							'</td>'+
							'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';
					$(this).parents("tbody").append(trHtml);
					$("select").select2();
					rename();
				})
				$("#tab-15").delegate(".del-thistd-btn","click",function(){
					$(this).parents("tr").remove();
					rename();
				});
				function rename() {
					var i = -1;
					$('#accpitem tr').each(function () {
//						console.debug("i = "+i);
						$(this).children('td').children('.id').attr('name', 'workForceOffices[' + i + '].id');
						$(this).children('td').children('.countryBasicId').attr('name', 'workForceOffices[' + i + '].countryBasicId');
						$(this).children('td').children('.b911OfficeId').attr('name', 'workForceOffices[' + i + '].b911OfficeId');
						$(this).children('td').children('.b914Phone').attr('name', 'workForceOffices[' + i + '].b914Phone');
						$(this).children('td').children('.b912Contacts').attr('name', 'workForceOffices[' + i + '].b912Contacts');
						$(this).children('td').children('.b915AssistDate').attr('name', 'workForceOffices[' + i + '].b915AssistDate');
						$(this).children('td').children('.b913Relation').attr('name', 'workForceOffices[' + i + '].b913Relation');
						i++;
					});
				};
			});
		</script>
</div></body>
</html>
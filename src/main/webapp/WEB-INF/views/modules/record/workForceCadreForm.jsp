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
	<%--<li><a href="${ctx}/record/workForceCadre/">驻村工作队情况_干部表列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/workForceCadre/form?id=${workForceCadre.id}">驻村工作队情况_干部表<shiro:hasPermission name="record:workForceCadre:edit">${not empty workForceCadre.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:workForceCadre:edit">查看</shiro:lacksPermission></a></li>
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
		<li><a href="${ctx}/record/rainPlan/form?countryBasicId=${countryBasic.id}">雨露计划 </a></li>
		<li><a href="${ctx}/record/microfinance/form?countryBasicId=${countryBasic.id}">扶贫小额信贷</a></li>
		<li><a href="${ctx}/record/povertyRelocation/form?countryBasicId=${countryBasic.id}">异地扶贫搬迁</a></li>
		<li><a href="${ctx}/record/industryIncome/form?countryBasicId=${countryBasic.id}">特色产业增收</a></li>
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${countryBasic.id}">驻村单位</a></li>
		<li class="active"><a>驻村干部</a></li>
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
		<form:form id="inputForm" modelAttribute="countryBasic" action="${ctx}/record/workForceCadre/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<sys:message content="${message}"/>
		<table style="margin-top: 20px;">
			<tbody id="accpitem">
			<tr>
				<td>B92-1姓名</td>
				<td>B92-2单位姓名</td>
				<td>B92-3职务</td>
				<td>B92-4单位隶属关系</td>
				<td>B92-5联系电话</td>
				<td>B92-6驻村时间</td>
				<td>政治面貌</td>
				<td>证件号码</td>
				<td>是否队长</td>
				<td>是否第一书记</td>
				<td>驻村开始时间</td>
				<td>驻村结束时间</td>
				<td style="text-align: center;cursor: pointer;width: 132px;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${countryBasic.workForceCadres != null && !countryBasic.workForceCadres.isEmpty()}">
			<c:forEach items="${countryBasic.workForceCadres}" var="workForceCadre" varStatus="status">
			<tr class="bg-white">
				<td>
					<input type="hidden" name="workForceCadres[${status.index}].id" value="${workForceCadre.id}" class="id"/>
					<input type="hidden" name="workForceCadres[${status.index}].countryBasicId" class="countryBasicId" value="${workForceCadre.countryBasicId}"/>
					<form:input path="workForceCadres[${status.index}].b921Name" htmlEscape="false" maxlength="200" class="b921Name input-xlarge"/>
				</td>
				<td>
					<form:input path="workForceCadres[${status.index}].b922OfficeId" htmlEscape="false" maxlength="64" class="b922OfficeId input-xlarge"/>
				</td>
				<td>
					<form:input path="workForceCadres[${status.index}].b923Position" htmlEscape="false" maxlength="255" class="b923Position input-xlarge"/>
				</td>
				<td>
					<form:select path="workForceCadres[${status.index}].b924Relation" class="b924Relation"
								 items="${fns:getDictList('affiliation')}" itemLabel="label" itemValue="value"/>
					<%--<form:input path="workForceCadres[${status.index}].b924Relation" htmlEscape="false" maxlength="255" class="b924Relation input-xlarge"/>--%>
				</td>
				<td>
					<form:input path="workForceCadres[${status.index}].b925Phone" htmlEscape="false" maxlength="200" class="b925Phone input-xlarge mobile"/>
				</td>
				<td>
					<input name="workForceCadres[${status.index}].b926ResidentDate" type="text" readonly="readonly" maxlength="20" class="b926ResidentDate input-medium Wdate"
						   value="<fmt:formatDate value="${countryBasic.workForceCadres[status.index].b926ResidentDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</td>
				<td>
					<form:select path="workForceCadres[${status.index}].political" class="political"
								 items="${fns:getDictList('political_outlook')}" itemLabel="label" itemValue="value"/>
					<%--<form:input path="workForceCadres[${status.index}].political" htmlEscape="false" maxlength="200" class="political input-xlarge"/>--%>
				</td>
				<td>
					<form:input path="workForceCadres[${status.index}].idNumber" htmlEscape="false" maxlength="200" class="idNumber input-xlarge"/>
				</td>
				<td>
					<form:radiobuttons path="workForceCadres[${status.index}].isLeader" class="isLeader" items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
				</td>
				<td>
					<form:radiobuttons path="workForceCadres[${status.index}].isFirstSecretary" class="isFirstSecretary" items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
				</td>
				<td>
					<input name="workForceCadres[${status.index}].beginResidentDate" type="text" readonly="readonly" maxlength="20" class="beginResidentDate input-medium Wdate"
						   value="<fmt:formatDate value="${countryBasic.workForceCadres[status.index].beginResidentDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
				</td>
				<td>
					<input name="workForceCadres[${status.index}].endResidentDate" type="text" readonly="readonly" maxlength="20" class="endResidentDate input-medium Wdate"
						   value="<fmt:formatDate value="${countryBasic.workForceCadres[status.index].endResidentDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
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
			<script>
				$(function (){
					$(".add-tr-btn").click(function(){
						var _len=$("#accpitem tr").length - 1;
						var trHtml = '<tr>' +
								'<td class="bg-white">' +
								'<input type="hidden" name="workForceCadres['+_len+'].id"  class="id">'+
								'<input type="hidden" name="workForceCadres['+_len+'].countryBasicId" class="countryBasicId" >'+
								'<input id="workForceCadres'+_len+'.b921Name" name="workForceCadres['+_len+'].b921Name" class="b921Name input-mini required " type="text"  maxlength="10">'+
								'</td><td class="bg-white">' +
								'<input id="workForceCadres'+_len+'.b922OfficeId" name="workForceCadres['+_len+'].b922OfficeId" class="b922OfficeId" type="text" >'+
								'</td><td class="bg-white">' +
								'<input id="workForceCadres'+_len+'.b923Position" name="workForceCadres['+_len+'].b923Position" class="b923Position" type="text" >'+
								'</td>' +
								'<td class="bg-white">'+
								'<select id="workForceCadres'+_len+'.b924Relation" name="workForceCadres['+_len+'].b924Relation" class="b924Relation select2-offscreen" tabindex="-1">'+
								'<option value="01">中央</option>'+
								'<option value="02">省</option>'+
								'<option value="03">市</option>'+
								'<option value="04">县</option>'+
								'<option value="05">乡镇</option>'+
								'<option value="06">部队</option>'+
								'<option value="99">其他</option>'+
								'</select>'+
								'</td>'+
								'<td class="bg-white">' +
								'<input id="workForceCadres'+_len+'.b925Phone" name="workForceCadres['+_len+'].b925Phone" class="b925Phone mobile" type="text" >'+
								'</td><td class="bg-white">' +
								'<input id="workForceCadres" name="workForceCadres['+_len+'].b926ResidentDate" type="text" readonly="readonly" maxlength="20" class="b926ResidentDate input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
								'</td>' +
								'<td class="bg-white">'+
								'<div class="select2-container" id="s2id_members'+_len+'.politicalStatus">' +
								'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen3">' +
								'<div class="select2-drop select2-display-none select2-with-searchbox">' +
								'<div class="select2-search">' +
								'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
								'</div>' +
								'<ul class="select2-results">' +
								'</ul>' +
								'</div>' +
								'</div>' +
								'<select id="workForceCadres'+_len+'.political" name="workForceCadres['+_len+'].political" tabindex="-1" class="select2-offscreen political">' +
								'<option value="01" selected="selected">中共党员</option>' +
								'<option value="02">中共预备党员</option>' +
								'<option value="03">共青团员</option>' +
								'<option value="04">民革会员</option>' +
								'<option value="05">民盟盟员</option>' +
								'<option value="06">民建会员</option>' +
								'<option value="07">民进会员</option>' +
								'<option value="08">农工党党员</option>' +
								'<option value="09">致公党党员</option>' +
								'<option value="10">九三学社社员</option>' +
								'<option value="11">台盟盟员</option>' +
								'<option value="12">无党派民主人士</option>' +
								'<option value="13">群众</option>' +
								'</select>'+
								'</td>'+
								'<td class="bg-white">' +
								'<input id="workForceCadres'+_len+'.idNumber" name="workForceCadres['+_len+'].idNumber" class="idNumber" type="text" >'+
								'</td><td class="bg-white">' +
								'<span>' +
								'<input id="workForceCadres'+_len+'.isLeader1" name="workForceCadres['+_len+'].isLeader" class="isLeader" type="radio" value="1">' +
								'<label for="workForceCadres'+_len+'.isLeader1">是</label>' +
								'</span>' +
								'<span>' +
								'<input id="workForceCadres'+_len+'.isLeader2" name="workForceCadres['+_len+'].isLeader" class="isLeader" type="radio" value="0" checked="checked">' +
								'<label for="workForceCadres'+_len+'.isLeader2">否</label>' +
								'</span>'+
								'</td><td class="bg-white">' +
								'<span>' +
								'<input id="workForceCadres'+_len+'.isFirstSecretary1" name="workForceCadres['+_len+'].isFirstSecretary" class="isFirstSecretary" type="radio" value="1">' +
								'<label for="workForceCadres'+_len+'.isFirstSecretary1">是</label>' +
								'</span>' +
								'<span>' +
								'<input id="workForceCadres'+_len+'.isFirstSecretary2" name="workForceCadres['+_len+'].isFirstSecretary" class="isFirstSecretary" type="radio" value="0" checked="checked">' +
								'<label for="workForceCadres'+_len+'.isFirstSecretary2">否</label>' +
								'</span>'+
								'</td><td class="bg-white">' +
								'<input id="workForceCadres" name="workForceCadres['+_len+'].beginResidentDate" type="text" readonly="readonly" maxlength="20" class="beginResidentDate input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
								'</td><td class="bg-white">' +
								'<input id="workForceCadres" name="workForceCadres['+_len+'].endResidentDate" type="text" readonly="readonly" maxlength="20" class="endResidentDate input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
								'</td><td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';
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
							$(this).children('td').children('.id').attr('name', 'workForceCadres[' + i + '].id');
							$(this).children('td').children('.countryBasicId').attr('name', 'workForceCadres[' + i + '].countryBasicId');
							$(this).children('td').children('.b921Name').attr('name', 'workForceCadres[' + i + '].b921Name');
							$(this).children('td').children('.b922OfficeId').attr('name', 'workForceCadres[' + i + '].b922OfficeId');
							$(this).children('td').children('.b923Position').attr('name', 'workForceCadres[' + i + '].b923Position');
							$(this).children('td').children('.b924Relation').attr('name', 'workForceCadres[' + i + '].b924Relation');
							$(this).children('td').children('.b925Phone').attr('name', 'workForceCadres[' + i + '].b925Phone');
							$(this).children('td').children('.b926ResidentDate').attr('name', 'workForceCadres[' + i + '].b926ResidentDate');
							$(this).children('td').children('.political').attr('name', 'workForceCadres[' + i + '].political');
							$(this).children('td').children('.idNumber').attr('name', 'workForceCadres[' + i + '].idNumber');
							$(this).children('td').children('span').children('.isLeader').attr('name', 'workForceCadres[' + i + '].isLeader');
							$(this).children('td').children('span').children('.isFirstSecretary').attr('name', 'workForceCadres[' + i + '].isFirstSecretary');
							$(this).children('td').children('.beginResidentDate').attr('name', 'workForceCadres[' + i + '].beginResidentDate');
							$(this).children('td').children('.endResidentDate').attr('name', 'workForceCadres[' + i + '].endResidentDate');
							i++;
						});
					};
				});
		</script>
</body>
</html>
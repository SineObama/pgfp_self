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
	<%--<li><a href="${ctx}/record/workForceCadre/">驻村工作队情况_干部表列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/cadreCountryInfo/form?countryId=${countryBasic.id}">驻村干部<shiro:hasPermission name="record:workForceCadre:edit">${not empty workForceCadre.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:workForceCadre:edit">查看</shiro:lacksPermission></a></li>
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
		<li><a href="${ctx}/record/workForceOffice/form?countryBasicId=${countryBasic.id}">驻村单位</a></li>
		<li class="active"><a>驻村干部</a></li>
		<li><a href="${ctx}/record/demandAndSituation/form?countryBasicId=${countryBasic.id}">帮扶需求及帮扶情况</a></li>
		<li><a href="${ctx}/record/tableInfo/form?countryBasicId=${countryBasic.id}">填表信息</a></li>
		<li><a href="${ctx}/record/basicPublicService/form?countryBasicId=${countryBasic.id}">基本公共服务</a></li>
		<li><a href="${ctx}/record/committeesTeam/form?countryBasicId=${countryBasic.id}">两委班子情况</a></li>
	</ul>
	<div id="tab-15" class="content-detail">
		<form:form id="inputForm" modelAttribute="countryBasic" action="${ctx}/record/cadreCountryInfo/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="years"/>
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
			<c:if test="${countryBasic.cadreInfos != null && !countryBasic.cadreInfos.isEmpty()}">
			<c:forEach items="${countryBasic.cadreInfos}" var="cadreInfo" varStatus="status">
			<tr>
				<td class="bg-white">
					<input type="hidden" name="cadreInfos[${status.index}].cadre.id" class="cadreId" value="${cadreInfo.cadre.id}"/>
					<%--<input type="hidden" name="cadreInfos[${status.index}].id" value="${cadre.id}" class="id"/>--%>
					<input type="hidden" name="cadreInfos[${status.index}].countryId" class="countryId" value="${cadreInfo.countryId}"/>
					<input type="hidden" name="cadreInfos[${status.index}].id" class="id" value="${cadreInfo.id}"/>
					<form:input path="cadreInfos[${status.index}].cadre.b921Name" htmlEscape="false" maxlength="200" class="b921Name required input-xlarge"/>
				</td>
				<td>
					<form:input path="cadreInfos[${status.index}].cadre.office.name" disabled="true" htmlEscape="false" class="officeName"/>
				</td>
				<td>
					<form:input path="cadreInfos[${status.index}].cadre.b923Position" disabled="true" htmlEscape="false" class="b923Position"/>
				</td>
				<td>
					<form:select path="cadreInfos[${status.index}].cadre.office.b924Relation" disabled="true" class="b924Relation"
								 items="${fns:getDictList('affiliation')}" itemLabel="label" itemValue="value"/>
					<%--<form:input path="cadreInfos[${status.index}].cadre.office.B924Relation" htmlEscape="false" class="B924Relation"/>--%>
				</td>
				<td>
					<form:input path="cadreInfos[${status.index}].cadre.b925Phone" disabled="true" class="b925Phone"/>
				</td>
				<td class="bg-white">
					<input name="cadreInfos[${status.index}].helpTime" type="text" readonly="readonly" maxlength="20" class="helpTime input-medium Wdate "
					value="<fmt:formatDate value="${cadreInfo.helpTime}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #fff;"/>
				</td>
				<td>
					<form:select path="cadreInfos[${status.index}].cadre.political" disabled="true" class="political"
							items="${fns:getDictList('political_outlook')}" itemLabel="label" itemValue="value"/>
				</td>
				<td>
					<form:input path="cadreInfos[${status.index}].cadre.idNumber" disabled="true" class="idNumber"/>
				</td>
				<td>
					<form:radiobuttons path="cadreInfos[${status.index}].cadre.isLeader" disabled="true" class="isLeader"
					   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</td>
				<td><form:radiobuttons path="cadreInfos[${status.index}].cadre.isFirstSecretary" class="isFirstSecretary" disabled="true"
						items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/></td>
				<td class="bg-white"><input name="cadreInfos[${status.index}].startHelpTime" type="text" readonly="readonly" maxlength="20" class="startHelpTime input-medium Wdate "
						   value="<fmt:formatDate value="${cadreInfo.startHelpTime}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"  style="background-color: #fff;"/></td>
				<td class="bg-white"><input name="cadreInfos[${status.index}].overHelpTime" type="text" readonly="readonly" maxlength="20" class="endHelpTime input-medium Wdate "
						   value="<fmt:formatDate value="${cadreInfo.overHelpTime}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #fff;"/></td>
				<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
				</c:forEach>
				</c:if>
			</tr>
			</tbody>
		</table>
		<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
		</form:form>
		<script>

			var tr;
			//本函数作为接收返回值并且将值设置入对应的输入框中
			function choose(cadre){
//				console.debug(cadre);
//				//姓名
				tr.children("td").children(".b921Name").val(cadre.b921Name);
//				//政治面貌
				tr.children("td").children(".political").val(cadre.political);
//				//干部id
				tr.children("td").children(".cadreId").val(cadre.id);
//				//证件号码
				tr.children("td").children(".idNumber").val(cadre.idNumber);
//				//性别
//				radioChecked(tr.children("td") ,".a63Sex" , cadre.sex );
//				//单位
				tr.children("td").children(".officeName").val(cadre.office.name);
//				//职务
				tr.children("td").children(".b923Position").val(cadre.b923Position);
//				//手机号码
				tr.children("td").children(".b925Phone").val(cadre.b925Phone);
//				//单位地址
//				tr.children("td").children(".unitAddress").val(cadre.office.address);
				//单位隶属关系
				tr.children("td").children(".b924Relation").val(cadre.office.b924Relation);
				//是否队长
				radioChecked(tr, 'isLeader' , cadre.isLeader);
				//是否第一书记
				radioChecked(tr , 'isFirstSecretary' ,cadre.isFirstSecretary);
				$("select").select2();
			}
			//根据传入的单选name属性和需要set的值
			function radioChecked(obj , name , value){
//			console.log(type);
				var radios = obj.find(name);
//			console.log(radios);
				for(i = 0 ; i< radios.length ; i++){
					if(radios[i].value == value){
						radios.eq(i).attr("checked",true);
					}
				}
			}
			//弹出干部信息窗口
			$(function () {
				$("#accpitem").delegate(".b921Name",'click',function(){
//					console.debug("asdfasdfasdf");
					tr = $(this).parents("tr");
					var iWidth = 900;
					var iHeight = 500;
					var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
					var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
					var win = window.open("${ctx}/record/workForceCadre/cadreChoose", "选择干部", "width=" + iWidth +
					", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
					",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
					"status=no,alwaysRaised=yes,depended=yes");
				});
			});

			$(function () {
				$(".add-tr-btn").click(function () {
					var _len = $("#accpitem tr").length - 1;
					var trHtml = '<tr>' +
							'<td class="bg-white">' +
							'<input type="hidden" name="cadreInfos[' + _len + '].id"  class="id">' +
							'<input type="hidden" name="cadreInfos[' + _len + '].cadre.id"  class="cadreId">' +
							'<input type="hidden" name="cadreInfos[' + _len + '].countryId" class="countryId" >' +
							'<input id="cadreInfos' + _len + '.cadre.b921Name" name="cadreInfos[' + _len + '].cadre.b921Name" class="b921Name required input-mini " type="text"  maxlength="10">' +
							'</td><td>' +
							'<input id="cadreInfos' + _len + '.cadre.office.name" disabled="true" name="cadreInfos[' + _len + '].cadre.office.name" class="officeName" type="text" >' +
							'</td><td>' +
							'<input id="cadreInfos' + _len + '.cadre.b923Position" disabled="disable" name="cadreInfos[' + _len + '].cadre.b923Position" class="b923Position" type="text" >' +
							'</td>' +
							'<td>' +
							'<select id="cadreInfos' + _len + '.cadre.office.b924Relation" disabled="disable" name="cadreInfos[' + _len + '].cadre.office.B924Relation" class="b924Relation select2-offscreen" tabindex="-1">' +
							'<option value="01">中央</option>' +
							'<option value="02">省</option>' +
							'<option value="03">市</option>' +
							'<option value="04">县</option>' +
							'<option value="05">乡镇</option>' +
							'<option value="06">部队</option>' +
							'<option value="99">其他</option>' +
							'</select>' +
							'</td>' +
							'<td>' +
							'<input id="cadreInfos' + _len + '.cadre.b925Phone" disabled="disable" name="cadreInfos[' + _len + '].cadre.b925Phone" class="b925Phone mobile" type="text" >' +
							'</td>' +
							'<td class="bg-white">' +
							'<input id="cadreInfos" style="background-color:#fff;" name="cadreInfos[' + _len + '].helpTime" type="text" readonly="readonly" maxlength="20" class="helpTime input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">' +
							'</td>' +
							'<td>' +
							'<div class="select2-container" id="s2id_members' + _len + '.cadre.political">' +
							'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen3">' +
							'<div class="select2-drop select2-display-none select2-with-searchbox">' +
							'<div class="select2-search">' +
							'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
							'</div>' +
							'<ul class="select2-results">' +
							'</ul>' +
							'</div>' +
							'</div>' +
							'<select id="cadreInfos' + _len + '.cadre.political" disabled="disable" name="cadreInfos[' + _len + '].cadre.political" tabindex="-1" class="select2-offscreen political">' +
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
							'</select>' +
							'</td>' +
							'<td>' +
							'<input id="cadreInfos' + _len + '.cadre.idNumber" disabled="disable" name="cadreInfos[' + _len + '].cadre.idNumber" class="idNumber" type="text" >' +
							'</td><td>' +
							'<span>' +
							'<input id="cadreInfos' + _len + '.cadre.isLeader1" disabled="disable" name="cadreInfos[' + _len + '].cadre.isLeader" class="isLeader" type="radio" value="1">' +
							'<label for="cadreInfos' + _len + '.cadre.isLeader1">是</label>' +
							'</span>' +
							'<span>' +
							'<input id="cadreInfos' + _len + '.cadre.isLeader2" disabled="disable" name="cadreInfos[' + _len + '].cadre.isLeader" class="isLeader" type="radio" value="0" checked="checked">' +
							'<label for="cadreInfos' + _len + '.cadre.isLeader2">否</label>' +
							'</span>' +
							'</td><td>' +
							'<span>' +
							'<input id="cadreInfos' + _len + '.cadre.isFirstSecretary1" disabled="disable" name="cadreInfos[' + _len + '].cadre.isFirstSecretary" class="isFirstSecretary" type="radio" value="1">' +
							'<label for="cadreInfos' + _len + '.cadre.isFirstSecretary1">是</label>' +
							'</span>' +
							'<span>' +
							'<input id="cadreInfos' + _len + '.cadre.isFirstSecretary2" disabled="disable" name="cadreInfos[' + _len + '].cadre.isFirstSecretary" class="isFirstSecretary" type="radio" value="0" checked="checked">' +
							'<label for="cadreInfos' + _len + '.cadre.isFirstSecretary2">否</label>' +
							'</span>' +
							'</td><td class="bg-white">' +
							'<input id="cadreInfos' + _len + '.startHelpTime" style="background-color:#fff;" name="cadreInfos[' + _len + '].cadre.startHelpTime" type="text" readonly="readonly" maxlength="20" class="startHelpTime input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">' +
							'</td><td class="bg-white">' +
							'<input id="cadreInfos' + _len + '.overHelpTime" style="background-color:#fff;" name="cadreInfos[' + _len + '].cadre.overHelpTime" type="text" readonly="readonly" maxlength="20" class="endHelpTime input-medium Wdate" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">' +
							'</td><td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';

					$(this).parents("tbody").append(trHtml);
					$("select").select2();
					rename();
				})
				$("#tab-15").delegate(".del-thistd-btn", "click", function () {
					$(this).parents("tr").remove();
					rename();
				});
				function rename() {
					var i = -1;
					$('#accpitem tr').each(function () {
//						console.debug("i = "+i);
						$(this).children('td').children('.cadreId').attr('name', 'cadreInfos[' + i + '].cadre.id');
						$(this).children('td').children('.id').attr('name', 'cadreInfos[' + i + '].id');
						$(this).children('td').children('.countryId').attr('name', 'cadreInfos[' + i + '].countryId');
						$(this).children('td').children('.b921Name').attr('name', 'cadreInfos[' + i + '].cadre.b921Name');
						$(this).children('td').children('.officeName').attr('name', 'cadreInfos[' + i + '].cadre.office.name');
						$(this).children('td').children('.b923Position').attr('name', 'cadreInfos[' + i + '].cadre.b923Position');
						$(this).children('td').children('.b924Relation').attr('name', 'cadreInfos[' + i + '].cadre.office.B924Relation');
						$(this).children('td').children('.b925Phone').attr('name', 'cadreInfos[' + i + '].cadre.b925Phone');
						$(this).children('td').children('.helpTime').attr('name', 'cadreInfos[' + i + '].helpTime');
						$(this).children('td').children('.political').attr('name', 'cadreInfos[' + i + '].cadre.political');
						$(this).children('td').children('.idNumber').attr('name', 'cadreInfos[' + i + '].cadre.idNumber');
						$(this).children('td').children('span').children('.isLeader').attr('name', 'cadreInfos[' + i + '].cadre.isLeader');
						$(this).children('td').children('span').children('.isFirstSecretary').attr('name', 'cadreInfos[' + i + '].cadre.isFirstSecretary');
						$(this).children('td').children('.startHelpTime').attr('name', 'cadreInfos[' + i + '].startHelpTime');
						$(this).children('td').children('.endHelpTime').attr('name', 'cadreInfos[' + i + '].overHelpTime');
						i++;
					});
				};
			});

		</script>
</body>
</html>
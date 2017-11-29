<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶单位情况管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/county/baseCountyInfo/">基本情况列表</a></li>
		<%-- <li><a href="${ctx}/county/bCountyHelpUnitInfo/">帮扶单位情况列表</a></li> --%>
		<li class="active"><a href="${ctx}/county/bCountyHelpUnitInfo/form?baseCountyInfoId=${info.id}">帮扶单位情况<shiro:hasPermission name="county:bCountyHelpUnitInfo:edit">${not empty bCountyHelpUnitInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="county:bCountyHelpUnitInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/county/baseCountyInfo/form?id=${info.id}">基本情况</a></li>
	        <li><a href="${ctx}/county/baseCountyKeyWorkInfo/form?baseCountyInfoId=${info.id}&type=1">村级道路畅通</a></li>
	        <li><a href="${ctx}/county/baseCountyDrinkSafe/form?baseCountyInfoId=${info.id}&type=2">饮水安全</a></li>
	        <li><a href="${ctx}/county/baseCountyPowerSupport/form?baseCountyInfoId=${info.id}&type=3">农村电力保障</a></li>
	        <li><a href="${ctx}/county/baseCountyDangerRoom/form?baseCountyInfoId=${info.id}&type=4">危房改造</a></li>
	        <li><a href="${ctx}/county/baseCountyIndustryIncome/form?baseCountyInfoId=${info.id}&type=5">特色产业增收</a></li>
	        <li><a href="${ctx}/county/baseCountyRuralTourism/form?baseCountyInfoId=${info.id}&type=6">乡村旅游</a></li>
	        <li><a href="${ctx}/county/baseCountyEducation/form?baseCountyInfoId=${info.id}&type=7">教育</a></li>
	        <li><a href="${ctx}/county/baseCountyHealthfamilyPlanning/form?baseCountyInfoId=${info.id}&type=8">卫生和计划生育</a></li>
	        <li><a href="${ctx}/county/baseCountyCulture/form?baseCountyInfoId=${info.id}&type=9">文化建设</a></li>
	        <li><a href="${ctx}/county/baseCountyInformation/form?baseCountyInfoId=${info.id}&type=10">贫困村信息化</a></li>
	        <li><a href="${ctx}/county/baseCountySpecialPovertyInfo/form?baseCountyInfoId=${info.id}&type=1">雨露计划</a></li>
	        <li><a href="${ctx}/county/microdinanceProvertyAlleviation/form?baseCountyInfoId=${info.id}&type=2">扶贫小额信贷</a></li>
	        <li><a href="${ctx}/county/offSiteRelocation/form?baseCountyInfoId=${info.id}&type=3">异地扶贫搬迁</a></li>
	        <li class="active">帮扶单位及责任人情况</li>
	        <li><a href="${ctx}/county/baseCountyHelpInfo/form?baseCountyInfoId=${info.id}">帮扶情况</a></li>
		</ul>
		<div id="tab-15" class="content-detail">
	
	<c:choose>
		<c:when test="${empty unitt.baseCountyInfoId }">
			<script>
				alert("请先填写基本情况！");
				window.history.back(-1);
			</script>
		</c:when>
		<c:otherwise>	
	
	<form:form id="inputForm" modelAttribute="info" action="${ctx}/county/bCountyHelpUnitInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<br/>
		<table>
			<tbody id="accpitem">
			<tr>
				<td>帮扶单位</td>
				<td>隶属关系</td>
				<td>帮扶责任人</td>
				<td>联系电话</td>
				<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${info.units != null && !info.units.isEmpty()}">
			<c:forEach items="${info.units}" var="unit" varStatus="status">
			<tr>
				<td>
					<input type="hidden" name="units[${status.index}].id" value="${unit.id}" class="id"/>
					<input type="hidden" name="units[${status.index}].baseCountyInfoId" class="baseCountyInfoId" value="${unit.baseCountyInfoId}"/>
					<input type="hidden" name="units[${status.index}].cadre.id" class="cadreId" value="${unit.cadre.id}"/>
					<form:input type="text" path="units[${status.index}].cadre.office.name" class="officeName" disabled="true"/>
				</td>
				<td>
					<form:select path="units[${status.index}].cadre.office.B924Relation" class="affiliation" disabled="true">
						<form:options items="${fns:getDictList('affiliation')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
					</form:select>
				</td>
				<td class="bg-white">
					<form:input type="text" path="units[${status.index}].cadre.b921Name" class="personLiable required"/>
				</td>
				<td>
					<form:input type="text" path="units[${status.index}].cadre.b925Phone" class="phone" disabled="true"/>
				</td>
				
				<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
				
				</tr>
				</c:forEach>
				</c:if>
			
			</tbody>
		</table>
		<div class="content-save">
			<shiro:hasPermission name="county:baseCountyInfo:edit">
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	</c:otherwise>
	</c:choose>
	</div>
	</div>
<script >
	var tr;
	function choose(cadre){
		//姓名
		tr.children("td").children(".personLiable").val(cadre.b921Name);
		//干部id
		tr.children("td").children(".cadreId").val(cadre.id);
		//单位
		tr.children("td").children(".officeName").val(cadre.office.name);
		//手机号码
		tr.children("td").children(".phone").val(cadre.b925Phone);
		//单位地址
		tr.children("td").children(".affiliation").val(cadre.office.b924Relation);
		$("select").select2();
	}
	$("#accpitem").delegate(".personLiable",'click',function(){
		tr = $(this).parents("tr");
		var iWidth = 900;
		var iHeight = 500;
		var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
		var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
		var win = window.open("${ctx}/record/workForceCadre/cadreChoose", "弹出窗口", "width=" + iWidth +
		", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
		",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
		"status=no,alwaysRaised=yes,depended=yes");
	});

		$(function () {

		});

			$(".add-tr-btn").click(function(){
				var _len=$("#accpitem tr").length - 1;
				var trHtml =
					'<tr>' +
					'<td>' +
					'<input type="hidden" name="units[' + _len + '].id" value="" class="id">' +
					'<input type="hidden" name="units[' + _len + '].baseCountyInfoId" class="baseCountyInfoId" value="">' +
					'<input type="hidden" name="units['+ _len +'].cadre.id" class="cadreId"/>' +
					'<input id="units0.officeName" name="units[' + _len + '].cadre.office.name" type="text" disabled="true" class="officeName" value="">' +
					'</td>' + 
					'<td>' +
						'<select id="units0.affiliation" name="units[' + _len + '].cadre.office.B924Relation" disabled="true" class="affiliation select2-offscreen" tabindex="-1">' +
							'<option value="01">中央</option>' +
							'<option value="02">省</option>' +
							'<option value="03">市</option>' +
							'<option value="04">县</option>' +
							'<option value="05">乡镇</option>' +
							'<option value="06">部队</option>' +
							'<option value="07">自治区</option>' +
							'<option value="99">其他</option>' +
						'</select>' + 
					'</td>' + 
					'<td class="bg-white">' + 
					'<input id="units0.personLiable" name="units[' + _len + '].cadre.b921Name" type="text" class="personLiable" value="">' +
					'</td>' + 
					'<td>' +
					'<input id="units0.phone" name="units[' + _len + '].cadre.b925Phone" disabled="true" type="text" class="phone" value="">' +
					'</td>' + 
					'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>' + 
					'</tr>';
				
				$(this).parents("tbody").append(trHtml);
				$("select").select2();
				rename();
			}); 
			$("#tab-15").delegate(".del-thistd-btn","click",function(){
				$(this).parents("tr").remove();
				rename();
			});
			function rename(){
				var i=-1;
				$('#accpitem tr').each(function(){
					$(this).children('td').children('.id').attr('name','units['+i+'].id');
					$(this).children('td').children('.cadreId').attr('name','units['+i+'].cadre.id');
					$(this).children('td').children('.baseCountyInfoId').attr('name','units['+i+'].baseCountyInfoId');
					$(this).children('td').children('.officeName').attr('name','units['+i+'].cadre.office.name');
					$(this).children('td').children('.affiliation').attr('name','units['+i+'].cadre.office.B924Relation');
					$(this).children('td').children('.personLiable').attr('name','units['+i+'].cadre.b921Name');
					$(this).children('td').children('.phone').attr('name','units['+i+'].cadre.b925Phone');
					i++;
				});
			};
	</script>
	
</body>
</html>
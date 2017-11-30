<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>帮扶单位及负责人管理</title>
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
	<li><a href="${ctx}/record/basePoorerRegCard/">建档立卡表列表</a></li>
		<%--<li><a href="${ctx}/record/basePoorerSupportUnitInfo/">帮扶单位及负责人列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${card.id}">帮扶单位及负责人<shiro:hasPermission name="record:basePoorerSupportUnitInfo:edit">${not empty basePoorerSupportUnitInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:basePoorerSupportUnitInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">帮扶单位及责任人</a>
	</div>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/record/basePoorerRegCard/form?id=${card.id}">基本情况</a></li>
			<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${card.id}">家庭成员</a></li>
			<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${card.id}">家庭成员受培训情况</a></li>
			<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${card.id}">家庭成员就业情况</a> </li>
			<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${card.id}">家庭成员参保情况</a></li>
			<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${card.id}">生产生活条件</a></li>
			<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${card.id}">家庭经济情况</a></li>
			<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${card.id}">特色产业增收</a></li>
			<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${card.id}">帮扶需求</a></li>
			<li class="active">帮扶单位及责任人</li>
			<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${card.id}">家庭在校生受帮扶情况</a></li>
			<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${card.id}">填表记录</a></li>
		</ul>
		<div id="tab-15" class="content-detail">
	<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/basePoorerSupportUnitInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>
		<br/>
		<table>
			<tbody id="accpitem">
			<tr>
				<td>序号</td>
				<td>A62姓名</td>
				<td>A63性别</td>
				<td>证件号码</td>
				<td>政治面貌</td>
				<td>A64所在单位</td>
				<td>A65职务</td>
				<td>A66单位隶属关系</td>
				<td>A67帮扶内容</td>
				<td>A68帮扶效果</td>
				<td>A69联系电话</td>
				<td>开始帮扶时间</td>
				<td>结束帮扶时间</td>
				<td>单位地址</td>
				<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${card.units != null && !card.units.isEmpty()}">
			<c:forEach items="${card.units}" var="unit" varStatus="status">
			<tr>
				<td class="bg-white">
					<input type="hidden" name="units[${status.index}].id" value="${unit.id}" class="id"/>
					<input type="hidden" name="units[${status.index}].poorerRegCardId" class="poorerRegCardId" value="${unit.poorerRegCardId}"/>
					<form:input path="units[${status.index}].idx" cssClass="idx input-mini required int" maxlength="10"/>
				</td>
				<td class="bg-white">
					<form:hidden path="units[${status.index}].cadre.id" class="cadreId"/>
					<form:input type="text" path="units[${status.index}].cadre.b921Name" class="a62Name required" maxlength="200"/>
				</td>
				<td>
					<form:radiobuttons path="units[${status.index}].cadre.sex" class="a63Sex"
									   items="${fns:getDictList('sex')}" itemValue="value" itemLabel="label" disabled="true"/>
				</td>
				<td>
					<form:input type="text" path="units[${status.index}].cadre.idNumber" class="idNumber" maxlength="64" disabled="true"/>
				</td>
				<td>
					<form:select  path="units[${status.index}].cadre.political" class="politicalStatus"
							items="${fns:getDictList('political_outlook')}" itemLabel="label" itemValue="value" disabled="true"/>
				</td>
				<td>
					<form:input path="units[${status.index}].cadre.office.name" class="a64unitName" maxlength="200" disabled="true"/>
				</td>
				<td>
					<form:input type="text" path="units[${status.index}].cadre.b923Position" class="a65Post" maxlength="200" disabled="true"/>
				</td>
				<td>
					<form:select path="units[${status.index}].cadre.office.B924Relation" class="a66UnitAffiliation"
								 items="${fns:getDictList('affiliation')}" itemLabel="label"  itemValue="value" disabled="true"/>
				</td>
				<td class="bg-white">
					<form:input path="units[${status.index}].a67Contents" class="a67Contents" maxlength="200"/>
				</td>
				<td class="bg-white">
					<form:input path="units[${status.index}].a68SupportEffect" class="a68SupportEffect" maxlength="200"/>
				</td>
				<td>
					<form:input path="units[${status.index}].cadre.b925Phone" class="phoneNumber" maxlength="11" disabled="true"/>
				</td>
				<td class="bg-white">
					<input id="supportStartTime" name="units[${status.index}].supportStartTime" type="text" readonly="readonly" maxlength="20" class="supportStartTime input-medium Wdate required"
						   value="<fmt:formatDate value="${card.units[status.index].supportStartTime}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #fff;"/>

				</td>
				<td class="bg-white">
					<input id="supportEndTime" name="units[${status.index}].supportEndTime" type="text" readonly="readonly" maxlength="20" class="supportEndTime input-medium Wdate"
						   value="<fmt:formatDate value="${card.units[status.index].supportEndTime}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #fff;"/>
				</td>
				<td>
					<form:input type="text" path="units[${status.index}].cadre.office.address" class="unitAddress" maxlength="200" disabled="true"/>
				</td>
				<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
				</c:forEach>
				</c:if>
			</tr>
			</tbody>
		</table>
		<div class="content-save">
			<shiro:hasPermission name="record:basePoorerRegCard:edit">
				<input class="save-btn add-tr-btn" style="margin-right:30px !important; width: 120px;" type="button" value="添加"/>
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
			</div>
		</div>

	<script >
		var tr;
		function choose(cadre){
			//姓名
			tr.children("td").children(".a62Name").val(cadre.b921Name);
			//政治面貌
			tr.children("td").children(".politicalStatus").val(cadre.political);
			//干部id
			tr.children("td").children(".cadreId").val(cadre.id);
			//证件号码
			tr.children("td").children(".idNumber").val(cadre.idNumber);
			//性别
			radioChecked(tr.children("td") ,".a63Sex" , cadre.sex );
			//单位
			tr.children("td").children(".a64unitName").val(cadre.office.name);
			//职务
			tr.children("td").children(".a65Post").val(cadre.b923Position);
			//手机号码
			tr.children("td").children(".phoneNumber").val(cadre.b925Phone);
			//单位地址
			tr.children("td").children(".unitAddress").val(cadre.office.address);
			$("select").select2();
		}
		//根据传入的单选name属性和需要set的值
		function radioChecked(obj , name , value){
			var radios = obj.find(name);
			for(i = 0 ; i< radios.length ; i++){
				if(radios[i].value == value){
					radios.eq(i).attr("checked",true);
				}
			}
		}
		$(function () {
			$("#accpitem").delegate(".a62Name",'click',function(){
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
			$(".content-nav li").each(function () {
				$(this).click(function () {
					$(".header-rt").text($(this).text())
				})
			});

			$(".add-tr-btn").click(function(){
				var _len=$("#accpitem tr").length - 1;
				var trHtml = '<tr>'+
						'<td class="bg-white">'+
				'<input type="hidden" name="units['+_len+'].id" value="" class="id">'+
				'<input type="hidden" name="units['+_len+'].poorerRegCardId" class="poorerRegCardId">'+
				'<input id="units'+_len+'.idx" name="units['+_len+'].idx" class="idx input-mini required int" type="text"  maxlength="10">'+
				'</td>'+
				'<td class="bg-white">'+
				'<input type="hidden" name="units['+_len+'].cadre.id" value="" class="cadreId">'+
				'<input id="units'+_len+'.a62Name" name="units['+_len+'].a62Name" class="a62Name required" type="text">'+
				'</td>'+
				'<td style="background-color: #f5f5f5;">'+
				'<span>' +
						'<input id="units'+_len+'.cadre.sex1" name="units['+_len+'].cadre.sex" disabled="disabled" class="a63Sex" type="radio" value="01">' +
						'<label for="units'+_len+'.cadre.sex1">男</label>' +
				'</span>' +
				'<span>' +
						'<input id="units'+_len+'.cadre.sex2" name="units['+_len+'].cadre.sex" disabled="disabled" class="a63Sex" type="radio" value="02">' +
						'<label for="units'+_len+'.cadre.sex2">女</label>' +
				'</span>'+
				'</td>'+
				'<td>'+
				'<input id="units'+_len+'.cadre.idNumber" disabled="disabled" name="units['+_len+'].cadre.idNumber" class="idNumber" type="text" >'+
				'</td>'+
				'<td>'+
				'<select id="units'+_len+'.cadre.political" disabled="disabled" name="units['+_len+'].cadre.political" class="politicalStatus select2-offscreen" tabindex="-1">'+
				'<option value="01" selected="selected">中共党员</option>'+
				'<option value="02">中共预备党员</option>'+
				'<option value="03">共青团员</option>'+
				'<option value="04">民革会员</option>'+
				'<option value="05">民盟盟员</option>'+
				'<option value="06">民建会员</option>'+
				'<option value="07">民进会员</option>'+
				'<option value="08">农工党党员</option>'+
				'<option value="09">致公党党员</option>'+
				'<option value="10">九三学社社员</option>'+
				'<option value="11">台盟盟员</option>'+
				'<option value="12">无党派民主人士</option>'+
				'<option value="13">群众</option>'+
				'</select>'+
				'</td>'+
				'<td>'+
				'<input id="units'+_len+'.office.name" disabled="disabled" name="units['+_len+'].office.name" class="a64unitName" type="text">'+
				'</td>'+
				'<td>'+
				'<input id="units'+_len+'.cadre.b923Position" disabled="disabled" name="units['+_len+'].cadre.b923Position" class="a65Post" type="text">'+
				'</td>'+
				'<td>'+
				'<select id="units'+_len+'.a66UnitAffiliation" disabled="disabled" name="units['+_len+'].a66UnitAffiliation" class="a66UnitAffiliation select2-offscreen" tabindex="-1">'+
				'<option value="01">中央</option>'+
				'<option value="02">省</option>'+
				'<option value="03">市</option>'+
				'<option value="04">县</option>'+
				'<option value="05">乡镇</option>'+
				'<option value="06">部队</option>'+
				'<option value="99">其他</option>'+
				'</select>'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="units'+_len+'.a67Contents" name="units['+_len+'].a67Contents" class="a67Contents" type="text">'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="units'+_len+'.a68SupportEffect" name="units['+_len+'].a68SupportEffect" class="a68SupportEffect" type="text" >'+
				'</td>'+
				'<td>'+
				'<input id="units'+_len+'.phoneNumber" disabled="disabled" name="units['+_len+'].phoneNumber" class="phoneNumber phoneChange" type="text" />'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="supportStartTime" style="background-color: #fff;" name="units['+_len+'].supportStartTime" type="text" readonly="readonly" maxlength="20" class="supportStartTime input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="supportEndTime" style="background-color: #fff;" name="units['+_len+'].supportEndTime" type="text" readonly="readonly" maxlength="20" class="supportEndTime input-medium Wdate"  onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
				'</td>'+
				'<td>'+
				'<input id="units'+_len+'.office.address" disabled="disabled" name="units['+_len+'].office.address" class="unitAddress" type="text" />'+
				'</td>'+
				'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>'+
				'</tr>';
//				$(this).parents("tbody").append(trHtml);
				$(this).parents("#inputForm").find("tbody").append(trHtml);
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
					$(this).children('td').children('.idx').attr('name','units['+i+'].idx');
					$(this).children('td').children('.poorerRegCardId').attr('name','units['+i+'].poorerRegCardId');
					$(this).children('td').children('.a62Name').attr('name','units['+i+'].a62Name');
					$(this).children('td').children('a63Sex').children('.a63Sex').attr('name','units['+i+'].a63Sex');
					$(this).children('td').children('.idNumber').attr('name','units['+i+'].idNumber');
					$(this).children('td').children('.politicalStatus').attr('name','units['+i+'].politicalStatus');
					$(this).children('td').children('.a64unitName').attr('name','units['+i+'].cadre.office.name');
					$(this).children('td').children('.a65Post').attr('name','units['+i+'].a65Post');
					$(this).children('td').children('.a66UnitAffiliation').attr('name','units['+i+'].cadre.office.B924Relation');
					$(this).children('td').children('.a67Contents').attr('name','units['+i+'].a67Contents');
					$(this).children('td').children('.a68SupportEffect').attr('name','units['+i+'].a68SupportEffect');
					$(this).children('td').children('.supportStartTime').attr('name','units['+i+'].supportStartTime');
					$(this).children('td').children('.supportEndTime').attr('name','units['+i+'].supportEndTime');
					$(this).children('td').children('.unitAddress').attr('name','units['+i+'].cadre.office.address');
					$(this).children('td').children('.phoneNumber').attr('name','units['+i+'].cadre.b925Phone');
					i++;
				});
			};
		});
	</script>
</body>
</html>
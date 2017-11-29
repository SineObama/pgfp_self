<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户在校生受帮扶情况管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
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
		<%--<li><a href="${ctx}/record/basePoorerStudentHelpInfo/">贫困户在校生受帮扶情况列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${card.id}">贫困户在校生受帮扶情况<shiro:hasPermission name="record:basePoorerStudentHelpInfo:edit">${not empty basePoorerStudentHelpInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:basePoorerStudentHelpInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">在校生受帮扶情况</a>
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
			<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${card.id}">帮扶单位及责任人</a></li>
			<li class="active"><a>家庭在校生受帮扶情况</a></li>
			<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${card.id}">填表记录</a></li>
		</ul>
		<div id="tab-15" class="content-detail">
	<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/basePoorerStudentHelpInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>

		<br/>
		<table>
			<tbody id="accpitem">
			<tr>
				<td>序号</td>
				<td>A70 姓名</td>
				<td>A71就读学校</td>
				<td>A72年级班级</td>
				<td>A73帮扶干部姓名</td>
				<td>A74帮扶干部单位</td>
				<td>A75帮扶干部联系电话</td>
				<td>A76是否得到扶持</td>
				<td>是否寄宿</td>
				<td>学校地址</td>
				<td>考证号</td>
				<td>学号</td>
				<td>学杂费或保费标准</td>
				<td>入学日期</td>
				<td>是否本区县户籍学生</td>
				<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${card.studentHelpInfos != null && !card.studentHelpInfos.isEmpty()}">
			<c:forEach items="${card.studentHelpInfos}" var="student" varStatus="status">
			<tr>
				<td class="bg-white">
					<input type="hidden" name="studentHelpInfos[${status.index}].id" value="${student.id}" class="id"/>
					<input type="hidden" name="studentHelpInfos[${status.index}].poorerRegCardId" class="poorerRegCardId" value="${student.poorerRegCardId}"/>
					<form:input path="studentHelpInfos[${status.index}].idx" cssClass="idx input-mini required int" maxlength="10"/>
				</td>
				<td class="bg-white">
					<form:hidden path="studentHelpInfos[${status.index}].member.id" class="memberId"/>
					<form:input type="text" path="studentHelpInfos[${status.index}].member.name" class="name required"/>
				</td>
				<td class="bg-white">
					<form:input path="studentHelpInfos[${status.index}].school" class="school required"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="studentHelpInfos[${status.index}].grade" class="grade"/>
				</td>
				<td class="bg-white">
					<form:hidden path="studentHelpInfos[${status.index}].cadre.id" class="cadreId"/>
					<form:input path="studentHelpInfos[${status.index}].cadre.b921Name" class="cadreName"/>
				</td>
				<td>
					<form:input type="text" path="studentHelpInfos[${status.index}].cadre.office.name" class="cadreUnit" disabled="true"/>
				</td>
				<td>
					<form:input path="studentHelpInfos[${status.index}].cadre.b925Phone" class="cadreMobile" disabled="true"/>
				</td>
				<td class="bg-white">
					<form:radiobuttons path="studentHelpInfos[${status.index}].supportFlag" class="supportFlag"
							items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</td>
				<td class="bg-white">
					<form:radiobuttons path="studentHelpInfos[${status.index}].isBoarding" class="isBoarding"
									   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="studentHelpInfos[${status.index}].schoolAdress" class="schoolAdress"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="studentHelpInfos[${status.index}].examId" class="examId"/>
				</td>
				<td class="bg-white">
					<form:input type="text" path="studentHelpInfos[${status.index}].studentId" class="studentId" />
				</td>
				<td class="bg-white">
					<form:input type="text" path="studentHelpInfos[${status.index}].tuition" class="tuition decimal" />
				</td>
				<td class="bg-white">
					<input name="studentHelpInfos[${status.index}].entranceDate" type="text" readonly="readonly" maxlength="20" class="entranceDate input-medium Wdate"
						   value="<fmt:formatDate value="${card.studentHelpInfos[status.index].entranceDate}" pattern="yyyy-MM-dd"/>"
						   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					<%--<form:input type="text" path="studentHelpInfos[${status.index}].entranceDate" class="entranceDate"/>--%>
				</td>
				<td class="bg-white">
					<form:radiobuttons path="studentHelpInfos[${status.index}].isLocalStudent" class="isLocalStudent"
									   items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
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
		function chooseMember(member){
//			console.debug(member);
			tr.find(".memberId").val(member.id);
			tr.find(".name").val(member.name);
		}

		//弹出学生窗口
		$(function () {
			$("#accpitem").delegate(".name",'click',function(){
				var cardId = $("#id").val();
				tr = $(this).parents("tr");
				var iWidth = 900;
				var iHeight = 500;
				var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
				var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
				var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?poorerRegCardId="+cardId+"&selectMode=2", "选择学生", "width=" + iWidth +
				", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
				",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
				"status=no,alwaysRaised=yes,depended=yes");
			});
		});


		//本函数作为接收返回值并且将值设置入对应的输入框中
		function choose(cadre){
			tr.find(".cadreId").val(cadre.id);
			//姓名
			tr.children("td").find(".cadreName").val(cadre.b921Name);
			//单位
			tr.children("td").children(".cadreUnit").val(cadre.office.name);
			//手机号码
			tr.children("td").children(".cadreMobile ").val(cadre.b925Phone);
			$("select").select2();
		}
		//弹出干部信息窗口
		$(function () {
			$("#accpitem").delegate(".cadreName",'click',function(){
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
//		$('.tabs').tabslet({
//			animation: true,
//			active: 15
//		});
			$(".content-nav li").each(function () {
				$(this).click(function () {
					$(".header-rt").text($(this).text())
				})
			});

			$(".add-tr-btn").click(function(){
//				console.debug('click add');
				var _len=$("#accpitem tr").length - 1;
				var trHtml = '<tr>'+
				'<td class="bg-white">'+
				'<input type="hidden" name="studentHelpInfos['+_len+'].id"  class="id">'+
				'<input type="hidden" name="studentHelpInfos['+_len+'].poorerRegCardId" class="poorerRegCardId" >'+
				'<input id="studentHelpInfos'+_len+'.idx" name="studentHelpInfos['+_len+'].idx" class="idx input-mini required int" type="text"  maxlength="10">'+
				'</td>'+
				'<td class="bg-white">' +
				'<input type="hidden" name="studentHelpInfos['+_len+'].member.id" class="memberId">'+
				'<input id="studentHelpInfos'+_len+'.name" name="studentHelpInfos['+_len+'].member.name" class="name required" type="text" >'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="studentHelpInfos'+_len+'.school" name="studentHelpInfos['+_len+'].school" class="school" type="text" >'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="studentHelpInfos'+_len+'.grade" name="studentHelpInfos['+_len+'].grade" class="grade" type="text" >'+
				'</td>'+
				'<td class="bg-white">' +
						'<input type="hidden" + name="studentHelpInfos['+_len+'.cadre.id" class="cadreId"/>'+
				'<input id="studentHelpInfos'+_len+'.cadreName" name="studentHelpInfos['+_len+'].cadre.b921Name" class="cadreName" type="text"/>'+
				'</td>'+
				'<td>'+
				'<input id="studentHelpInfos'+_len+'.cadreUnit" name="studentHelpInfos['+_len+'].cadre.office.name" class="cadreUnit" type="text"  disabled="true"/>'+
				'</td>'+
				'<td>'+
				'<input id="studentHelpInfos'+_len+'.cadreMobile" name="studentHelpInfos['+_len+'].cadre.b925Phone" class="cadreMobile" type="text"  disabled="true">'+
				'</td>'+
				'<td class="bg-white">'+
				'<span>' +
						'<input id="studentHelpInfos'+_len+'.supportFlag1" name="studentHelpInfos['+_len+'].supportFlag" class="supportFlag" type="radio" value="1">' +
						'<label for="studentHelpInfos'+_len+'.supportFlag1">是</label>' +
				'</span>' +
				'<span>' +
						'<input id="studentHelpInfos'+_len+'.supportFlag2" name="studentHelpInfos['+_len+'].supportFlag" class="supportFlag" type="radio" value="0">' +
						'<label for="studentHelpInfos'+_len+'.supportFlag2">否</label>' +
				'</span>'+
				'</td>'+
				'<td class="bg-white">'+
				'<span>' +
						'<input id="studentHelpInfos'+_len+'.isBoarding1" name="studentHelpInfos['+_len+'].isBoarding" class="isBoarding" type="radio" value="1">' +
						'<label for="studentHelpInfos'+_len+'.supportFlag1">是</label>' +
				'</span>' +
				'<span>' +
						'<input id="studentHelpInfos'+_len+'.isBoarding2" name="studentHelpInfos['+_len+'].isBoarding" class="isBoarding" type="radio" value="0">' +
						'<label for="studentHelpInfos'+_len+'.supportFlag2">否</label>' +
				'</span>'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="studentHelpInfos'+_len+'.schoolAdress" name="studentHelpInfos['+_len+'].schoolAdress" class="schoolAdress" type="text" >'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="studentHelpInfos'+_len+'.examId" name="studentHelpInfos['+_len+'].examId" class="examId" type="text" >'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="studentHelpInfos'+_len+'.studentId" name="studentHelpInfos['+_len+'].studentId" class="studentId" type="text" >'+
				'</td>'+
				'<td class="bg-white">'+
				'<input id="studentHelpInfos'+_len+'.tuition" name="studentHelpInfos['+_len+'].tuition" class="tuition decimal" type="text" >'+
				'</td>'+
				'</td><td class="bg-white">' +
				'<input id="studentHelpInfos" name="studentHelpInfos['+_len+'].entranceDate" type="text" readonly="readonly" maxlength="20" class="entranceDate input-medium Wdate" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});">'+
				'</td>' +
				'<td class="bg-white">'+
				'<span>' +
				'<input id="studentHelpInfos'+_len+'.isLocalStudent1" name="studentHelpInfos['+_len+'].isLocalStudent" class="isLocalStudent" type="radio" value="1">' +
				'<label for="studentHelpInfos'+_len+'.supportFlag1">是</label>' +
				'</span>' +
				'<span>' +
				'<input id="studentHelpInfos'+_len+'.isLocalStudent2" name="studentHelpInfos['+_len+'].isLocalStudent" class="isLocalStudent" type="radio" value="0">' +
				'<label for="studentHelpInfos'+_len+'.supportFlag2">否</label>' +
				'</span>'+
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
//				console.debug("i = "+i);
					$(this).children('td').children('.id').attr('name','studentHelpInfos['+i+'].id');
					$(this).children('td').children('.idx').attr('name','studentHelpInfos['+i+'].idx');
					$(this).children('td').children('.memberId').attr('name','studentHelpInfos['+i+'].member.id');
					$(this).children('td').children('.poorerRegCardId').attr('name','studentHelpInfos['+i+'].poorerRegCardId');
					$(this).children('td').children('.name').attr('name','studentHelpInfos['+i+'].member.name');
					$(this).children('td').children('.school').attr('name','studentHelpInfos['+i+'].school');
					$(this).children('td').children('.grade').attr('name','studentHelpInfos['+i+'].grade');
					$(this).children('td').children('.cadreId').attr('name','studentHelpInfos['+i+'].cadre.id');
					$(this).children('td').children('.cadreName').attr('name','studentHelpInfos['+i+'].cadre.b921Name');
					$(this).children('td').children('.cadreUnit').attr('name','studentHelpInfos['+i+'].cadre.office.name');
					$(this).children('td').children('.cadreMobile').attr('name','studentHelpInfos['+i+'].cadre.b925Phone');
					$(this).children('td').children('.supportFlag').attr('name','studentHelpInfos['+i+'].supportFlag');
					$(this).children('td').children('.isBoarding').attr('name','studentHelpInfos['+i+'].isBoarding');
					$(this).children('td').children('.schoolAdress').attr('name','studentHelpInfos['+i+'].schoolAdress');
					$(this).children('td').children('.examId').attr('name','studentHelpInfos['+i+'].examId');
					$(this).children('td').children('.tuition').attr('name','studentHelpInfos['+i+'].tuition');
					$(this).children('td').children('.entranceDate').attr('name','studentHelpInfos['+i+'].entranceDate');
					$(this).children('td').children('.isLocalStudent').attr('name','studentHelpInfos['+i+'].isLocalStudent');
					i++;
				});
			};
		});
	</script>
</body>
</html>
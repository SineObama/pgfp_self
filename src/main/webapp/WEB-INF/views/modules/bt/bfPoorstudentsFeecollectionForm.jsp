<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学前保教费免除添加</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/pgfp/css/style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#select").click(function () {

				$("#inputForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/form");
				//$("#inputForm").submit();
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
	</script>
</head>
<body>
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>

<ul class="nav nav-tabs">
	<li><a href="${ctx}/bt/bfPoorstudentsFeecollection/">学前保教费免除登记列表</a></li>
	<%-- MemberId=${bfPoorstudentsFeecollection.student.id} --%>
	<li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/form?office.id=${bfPoorstudentsFeecollection.office.id}&years=${bfPoorstudentsFeecollection.years}">学前保教费免除登记<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit">${not empty bfPoorstudentsFeecollection.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bt:bfPoorstudentsFeecollection:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
	<div id="tab-1" class="content-detail">
		<form:form id="select" modelAttribute="bfPoorstudentsFeecollection" action="${ctx}/bt/bfPoorstudentsFeecollection/form" method="post" class="form-horizontal">
			<table style="border: 0px;">
				<tr style="border: 0px #FFFFFF; ">
					<td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">
						<div class="control-group" style="float: left">
							<label class="control-label">填报单位:</label>
							<div class="controls">
								<sys:treeselect id="office" name="office.id" value="${bfPoorstudentsFeecollection.office.id}" labelName="office.name" labelValue="${bfPoorstudentsFeecollection.office.name}"
												title="填报单位" url="/sys/office/treeData" extId="${office.id}" cssClass="" allowClear="true" isAll="${bfPoorstudentsFeecollection.isAdminCadre }"/>

							</div>
						</div>
					</td>
					<td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">填报时间:</td>
					<td class="sec-td bg-white" style="border: 0px #FFFFFF;">
						<input name="years" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
							   value="<fmt:formatDate value="${bfPoorstudentsFeecollection.yearDate}" pattern="yyyy"/>"
							   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"  style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
					</td>
					<td class="sec-td bg-white" style="border: 0px #FFFFFF;">
						<input id="select" class="save-btn" style="margin-right:30px !important;" type="submit" value="查询"/>
					</td>


				</tr>
			</table>
		</form:form>
		<form:form id="inputForm" modelAttribute="collectionModel" action="${ctx}/bt/bfPoorstudentsFeecollection/save" method="post" class="form-horizontal">
			<input type="hidden" id="sub-years" name="years" value="${bfPoorstudentsFeecollection.years}"/>
			<input type="hidden" id="sub-officeId" name="office.id" value="${bfPoorstudentsFeecollection.office.id}"/>
			<sys:message content="${message}"/>
			<table style="border: 0px;">
				<tbody id="accpitem">
				<tr>
					<td rowspan=2 style="text-align: center;">序号</td>
					<td rowspan=2 style="text-align: center;">学生姓名</td>
					<td rowspan=2 style="text-align: center;">性别</td>
					<td rowspan=2 style="text-align: center;">身份证号</td>
					<td rowspan=2 style="text-align: center;">入园时间</td>
					<td rowspan=2 style="text-align: center;">家庭住址</td>
					<td rowspan=2 style="text-align: center;">建档立卡户主姓名</td>
					<td rowspan=2 style="text-align: center;">与户主关系</td>
					<td rowspan=2 style="text-align: center;">幼儿园保教费（元/学期）</td>
					<td colspan=2 style="text-align: center;">财政补助（元）</td>
					<td rowspan=2 style="text-align: center;"> 是否为非县区户籍学生（是填1，否填0）</td>
					<td style="text-align: center;cursor: pointer;width: 132px;" class="add-tr-btn" rowspan=2>添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
				</tr>

				<tr>
					<td style="text-align: center;">自治区拨款</td>
					<td style="text-align: center;">市、县拨款</td>
				</tr>
				<c:if test="${collectionModel.feeCollection!= null && !collectionModel.feeCollection.isEmpty()}">
					<c:forEach items="${collectionModel.feeCollection}" var="bfPoorstudentsFeecollection" varStatus="status">
						<tr>
								<%--序号 --%>
							<td class="bg-white">
								<input type="hidden" name="feeCollection[${status.index}].id" value="${bfPoorstudentsFeecollection.id}" class="id"/>
								<input type="hidden" name="feeCollection[${status.index}].basePoorerFamilyMemberId" class="basePoorerFamilyMemberId" value="${bfPoorstudentsFeecollection.basePoorerFamilyMemberId}"/>
								<form:input path="feeCollection[${status.index}].idx" htmlEscape="false" maxlength="8" class="idx input-xlarge int required"/>
							</td>
								<%--姓名 --%>
							<td class="bg-white">
								<form:hidden path="feeCollection[${status.index}].student.id" class="studentId"/>
								<form:input path="feeCollection[${status.index}].student.name" htmlEscape="false" maxlength="200" class="name input-xlarge  required"/>
							</td>
								<%--性别 --%>
							<td class="sec-td">
								<form:input path="feeCollection[${status.index}].student.sex" htmlEscape="false" maxlength="200" class="sex input-xlarge  " disabled="true"/>
							</td>
								<%--身份证号 --%>
							<td class="sec-td">
								<form:input path="feeCollection[${status.index}].student.idNumber" htmlEscape="false" maxlength="200" class="idNumber input-xlarge  " disabled="true"/>
							</td>
								<%--入园时间 --%>
							<td class="sec-td">
								<input name="studentHelpInfoEntranceDate"  id="studentHelpInfoEntranceDate" type="text"  class="studentHelpInfoEntranceDate input-medium   required"
											value="<fmt:formatDate value="${bfPoorstudentsFeecollection.studentHelpInfo.entranceDate}" pattern="yyyy-MM-dd"/>"
											disabled="false"/>
								<%--<form:input path="feeCollection[${status.index}].studentHelpInfo.entranceDate" htmlEscape="false" maxlength="200" class="studentHelpInfo.entranceDate input-xlarge  " disabled="true"/>--%>
							</td>
								<%--家庭住址 --%>
							<td class="sec-td">
								<form:input path="feeCollection[${status.index}].card.address" htmlEscape="false" maxlength="200" class="address input-xlarge  " disabled="true"/>
							</td>
								<%--建档立卡户主姓名 --%>
							<td class="sec-td">
								<form:input path="feeCollection[${status.index}].card.houseHolderName" htmlEscape="false" maxlength="200" class="houseHolderName input-xlarge  " disabled="true"/>
							</td>
								<%--与户主关系 --%>
							<td class="sec-td">
								<form:input path="feeCollection[${status.index}].student.householderRelationship" htmlEscape="false" maxlength="200" class="householderRelationship input-xlarge  " disabled="true"/>
							</td>
								<%--幼儿园保教费（元/学期） --%>
							<td class="sec-td">
								<form:input path="feeCollection[${status.index}].studentHelpInfo.tuition" htmlEscape="false" maxlength="200" class="studentHelpInfo.tuition input-xlarge  " disabled="true"/>
							</td>
								<%--自治区拨款 --%>
							<td class="bg-white">
								<form:input type="text" maxlength="11" path="feeCollection[${status.index}].municipatityAppropriation" class="municipatityAppropriation decimal required"/>
							</td>
								<%--市县区拨款 --%>
							<td class="bg-white">
								<form:input type="text" maxlength="11" path="feeCollection[${status.index}].cityCountyAppropriation" class="cityCountyAppropriation decimal required"/>
							</td>
								<%--是否为非本县户籍学生（是填1，否填0） --%>
							<td class="sec-td">
								<form:input path="feeCollection[${status.index}].studentHelpInfo.isLocalStudent" htmlEscape="false" maxlength="200" class="studentHelpInfo.isLocalStudent input-xlarge  " disabled="true"/>
							</td>

							<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
			<div class="content-save">
				<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit">
					<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
				</shiro:hasPermission>
				<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
					<%--<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>--%>
			</div>
		</form:form>
	</div>
</div>
<script>
	//保存前干的活
	//			$('.btnSubmit').click(function(){
	//				var officeId = $('#officeId').val();
	//				var year = $("#years").val();
	//				$('#sub-years').val(year);
	//				$('#sub-officeId').val(officeId);
	//				$('#inputForm').submit();
	//			});

	var tr;
	var years = ${bfPoorstudentsFeecollection.years};

	function chooseMember(member){
//				console.debug(member);
		tr.find(".studentId").val(member.id);
		tr.find(".name").val(member.name);
		tr.find(".idNumber").val(member.idNumber);
		tr.find(".sex").val(member.sex);
		tr.find(".householderRelationship").val(member.householderRelationship);
	}

	/* function chooseSubsidyType(member){
	 //				console.debug(member);
	 tr.find(".subsidyTypeId").val(member.id);
	 tr.find(".subsidyType").val(member.subsidyType);
	 } */

	//弹出个人窗口
	$(function () {
		$("#accpitem").delegate(".name",'click',function(){
//					var cardId = $("#id").val();
			tr = $(this).parents("tr");
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?years=${bfPoorstudentsFeecollection.years}&selectMode=2", "选择个人", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});

	<%--//弹出资助项目窗口--%>
	<%--$(function () {--%>
	<%--$("#accpitem").delegate(".projectTitle",'click',function(){--%>
	<%--//	var cardId = $("#id").val();--%>
	<%--tr = $(this).parents("tr");--%>
	<%--var iWidth = 900;--%>
	<%--var iHeight = 500;--%>
	<%--var iTop = (window.screen.availHeight - 30 - iHeight) / 2;--%>
	<%--var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;--%>
	<%--var win = window.open("${ctx}/cms/cmsProject/proChoose", "选择资助项目", "width=" + iWidth +--%>
	<%--", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +--%>
	<%--",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +--%>
	<%--"status=no,alwaysRaised=yes,depended=yes");--%>
	<%--});--%>
	<%--});--%>


	$(function (){
		$(".add-tr-btn").click(function(){
			var _len=$("#accpitem tr").length - 1;
			var trHtml = '<tr>' +
						//序号
					'<td class="bg-white">' +
					'<input type="hidden" name="feeCollection['+_len+'].id"  class="id">'+
					'<input id="feeCollection'+_len+'.idx" name="feeCollection['+_len+'].idx" class="idx input-mini required int" type="text"  maxlength="8">'+
					'</td>' +
						//名字
					'<td class="bg-white">' +
					'<input type="hidden" class="studentId" name="feeCollection['+_len+'].student.id"/>' +
					'<input id="feeCollection'+_len+'.name" name="feeCollection['+_len+'].student.name" class="name required" type="text" >'+
					'</td class="bg-white">' +
						//性别
					'<td class="sec-td">' +
					'<input id="feeCollection'+_len+'.sex" name="feeCollection['+_len+'].student.sex" class="sex required" type="text" disabled="true">'+
					'</td>' +
						//身份证号码
					'<td class="sec-td">' +
					'<input id="feeCollection'+_len+'.idNumber" name="feeCollection['+_len+'].student.idNumber" class="idNumber required" type="text" disabled="true">'+
					'</td>' +
						//入园时间
					'<td class="sec-td">' +
					'<input id="feeCollection'+_len+'.studentHelpInfo.entranceDate" name="feeCollection['+_len+'].studentHelpInfo.entranceDate" class="entranceDate required" type="text" disabled="true">'+
					'</td>' +
						//家庭住址
					'<td class="sec-td">' +
					'<input type="hidden" class="houseId" name="feeCollection['+_len+'].card.id"/>' +
					'<input id="feeCollection'+_len+'.address" name="feeCollection['+_len+'].card.address" class="address required" type="text" disabled="true">'+
					'</td>' +
						//建档立卡户主姓名
					'<td class="sec-td">' +
					'<input id="feeCollection'+_len+'.houseHolderName" name="feeCollection['+_len+'].card.houseHolderName" class="houseHolderName required" type="text" disabled="true">'+
					'</td>' +
						//与户主关系
					'<td class="sec-td">' +
					'<input id="feeCollection'+_len+'.houseHolderRelationship" name="feeCollection['+_len+'].student.householderRelationship" class="houseHolderRelationship required" type="text" disabled="true">'+
					'</td>' +
						//幼儿园保教费
					'<td class="sec-td">' +
					'<input id="feeCollection'+_len+'.studentHelpInfo.tuition" name="feeCollection['+_len+'].studentHelpInfo.tuition" class="tuition required" type="text" disabled="true">'+
					'</td>' +
						//自治区拨款
					'<td class="bg-white">' +
					'<input id="feeCollection'+_len+'.municipatityAppropriation" name="feeCollection['+_len+'].municipatityAppropriation" maxlength="11" class="municipatityAppropriation input-mini required ecimal" type="text">'+
					'</td>' +
						//市县拨款
					'<td class="bg-white">' +
					'<input id="feeCollection'+_len+'.cityCountyAppropriation" name="feeCollection['+_len+'].cityCountyAppropriation" maxlength="11" class="cityCountyAppropriation input-mini required decimal" type="text">'+
					'</td>' +
						//是否为非本县户籍学生
					'<td class="sec-td">' +
					'<input id="feeCollection'+_len+'.studentHelpInfo.isLocalStudent" name="feeCollection['+_len+'].studentHelpInfo.isLocalStudent" class="isLocalStudent required" type="text" disabled="true">'+
					'</td>' +
					'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';
			$(this).parents("tbody").append(trHtml);
			rename();
		})
		$("#tab-1").delegate(".del-thistd-btn","click",function(){
			$(this).parents("tr").remove();
			rename();
		});
		function rename() {
			var i = -2;
			$('#accpitem tr').each(function () {
//						console.debug("i = "+i);
				$(this).children('td').children('.id').attr('name', 'feeCollection[' + i + '].id');
				$(this).children('td').children('.basePoorerFamilyMemberId').attr('name', 'feeCollection[' + i + '].basePoorerFamilyMemberId');
				$(this).children('td').children('.idx').attr('name', 'feeCollection[' + i + '].idx');
				$(this).children('td').children('.name').attr('name', 'feeCollection[' + i + '].student.name');
				$(this).children('td').children('.studentId').attr('name', 'feeCollection[' + i + '].student.id');
				$(this).children('td').children('.idNumber').attr('name', 'feeCollection[' + i + '].student.idNumber');
				$(this).children('td').children('.entranceDate').attr('name', 'feeCollection[' + i + '].studentHelpInfo.entranceDate');
				$(this).children('td').children('.houseId').attr('name', 'feeCollection[' + i + '].card.houseId');
				$(this).children('td').children('.address').attr('name', 'feeCollection[' + i + '].card.address');
				$(this).children('td').children('.houseHolderName').attr('name', 'feeCollection[' + i + '].card.houseHolderName');
				$(this).children('td').children('.householderRelationship').attr('name', 'feeCollection[' + i + '].student.householderRelationship');
				$(this).children('td').children('.tuition').attr('name', 'feeCollection[' + i + '].studentHelpInfo.tuition');
				$(this).children('td').children('.municipatityAppropriation').attr('name', 'feeCollection[' + i + '].municipatityAppropriation');
				$(this).children('td').children('.cityCountyAppropriation').attr('name', 'feeCollection[' + i + '].cityCountyAppropriation');
				$(this).children('td').children('.isLocalStudent').attr('name', 'feeCollection[' + i + '].studentHelpInfo.isLocalStudent');
				i++
			});
		};
	});
	$(function () {
		$("#accpitem").delegate(".subsidyType",'click',function(){
//			var cardId = $("#id").val();
			tr = $(this).parents("tr");
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/bf/bfSubsidyType/bfSubsidyTypeChoose", "选择资助项目", "width=" + iWidth +
			", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
			",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
			"status=no,alwaysRaised=yes,depended=yes");
		});
	});
	function chooseSubsidyType(member){
//		console.debug(member);
		tr.find(".subTypeId").val(member.id);
		tr.find(".subsidyType").val(member.subsidyType);
	}
	//			function chooseProject(project){
	//				tr.find('.projectId').val(project.id);
	//				tr.find('.projectTitle').val(project.title);
	//			}
</script>
</body>
</html>
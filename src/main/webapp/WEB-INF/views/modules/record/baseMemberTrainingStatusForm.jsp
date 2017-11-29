<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>家庭成员培训情况管理</title>
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
	<li class="active"><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${card.id}">家庭成员培训情况<shiro:hasPermission name="record:baseMemberTrainingStatus:edit">${not empty baseMemberTrainingStatus.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:baseMemberTrainingStatus:edit">查看</shiro:lacksPermission></a></li>
</ul>
<div class="header">
	<a href="" class="header-lt">贫困户建档立卡</a>
	<a href="" class="header-rt">家庭成员培训情况</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/basePoorerRegCard/form?id=${card.id}">基本情况</a></li>
		<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${card.id}">家庭成员</a></li>
		<li class="active"><a>家庭成员受培训情况</a></li>
		<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${card.id}">家庭成员就业情况</a> </li>
		<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${card.id}">家庭成员参保情况</a></li>
		<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${card.id}">生产生活条件</a></li>
		<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${card.id}">家庭经济情况</a></li>
		<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${card.id}">特色产业增收</a></li>
		<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${card.id}">帮扶需求</a></li>
		<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${card.id}">帮扶单位及责任人</a></li>
		<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${card.id}">家庭在校生受帮扶情况</a></li>
		<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${card.id}">填表记录</a></li>
	</ul>
	<div id="tab-1" class="content-detail">
		<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/baseMemberTrainingStatus/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="houseId"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>

			<br/>
			<table>
				<tbody id="accpitem">
				<tr>
					<td>姓名<font color="red">&nbsp;&nbsp;*</font></td>
					<td>培训类型</td>
					<td>参加时间<font color="red">&nbsp;&nbsp;*</font></td>
					<td>培训内容</td>
					<td>培训专业</td>
					<td>培训学校</td>
					<td>获得证书</td>
					<td>是否搬迁后数据</td>
					<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
				</tr>
				<c:if test="${card.trains != null && !card.trains.isEmpty()}">
				<c:forEach items="${card.trains}" var="train" varStatus="status">
					<tr class="bg-white">
						<td>
							<input type="hidden" name="trains[${status.index}].id" value="${train.id}" class="id"/>
							<input type="hidden" name="trains[${status.index}].poorRegCardId" value="${train.poorRegCardId}" class="poorRegCardId"/>
							<input type="hidden" name="trains[${status.index}].houseId" value="${train.houseId}" class="houseId"/>
							<input type="hidden" name="trains[${status.index}].year" value="${train.year}" class="year"/>
							<input type="hidden" name="trains[${status.index}].member.id" value="${train.member.id}" class="memberId"/>
							<input type="hidden" name="trains[${status.index}].member.idNumber" value="${train.member.idNumber}" class="idNumber"/>
							<input type="text" name="trains[${status.index}].member.name" value="${train.member.name}" class="memberName required"/>

						</td>
						<td>
							<%--<input type="text" name="trains[${status.index}].trainingType" value="${train.trainingType}" class="trainingType"/>--%>
							<%--<select class="trainingType" >--%>

							<%--</select>--%>
							<form:select path="trains[${status.index}].trainingType" class="trainingType"
										 items="${fns:getDictList('cultivate_situation')}" itemLabel="label" itemValue="value"/>
						</td>
						<td>
							<%--<input type="text" name="trains[${status.index}].trainingDate" class="trainingDate wdate"/>--%>
							<input name="trains[${status.index}].trainingDate" type="text" readonly="readonly"
								   class="trainingDate input-medium Wdate required"
								   value="<fmt:formatDate value="${train.trainingDate}" pattern="yyyy-MM-dd"/>"
								   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
								   style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
						</td>
						<td>
							<input type="text" name="trains[${status.index}].trainingContent" value="${train.trainingContent}" class="trainingContent"/>
						</td>
						<td>
							<input type="text" name="trains[${status.index}].trainingSpecialty" value="${train.trainingSpecialty}" class="trainingSpecialty"/>
						</td>
						<td>
							<input type="text" name="trains[${status.index}].trainingSchool" value="${train.trainingSchool}" class="trainingSchool"/>
						</td>
						<td>
							<input type="text" name="trains[${status.index}].certificates" value="${train.certificates}" class="certificates"/>
						</td>
						<td>
							<select name="trains[${status.index}].removalFlag" class="removalFlag">
								<option value="1" <c:if test="${train.removalFlag eq '1'}"> selected ="selected" </c:if> >搬迁前</option>
								<option value="2" <c:if test="${train.removalFlag eq '2'}"> selected ="selected" </c:if> >搬迁后</option>
							</select>
						</td>
						<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>

					</tr>
				</c:forEach>
				</c:if>
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
		tr.find(".memberName").val(member.name);
		tr.find(".idNumber").val(member.idNumber);
	}

	//弹出学生窗口
	$(function () {
		$("#accpitem").delegate(".memberName",'click',function(){
			var cardId = $("#id").val();
			tr = $(this).parents("tr");
			var iWidth = 900;
			var iHeight = 500;
			var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
			var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
			var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?poorerRegCardId="+cardId+"&selectMode=0", "选择学生", "width=" + iWidth +
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
			var trHtml = '<tr class="bg-white">'+
					'<td>'+
					'<input type="hidden" name="trains[0].id" class="id"/>'+
			'<input type="hidden" name="trains[0].poorRegCardId" class="poorRegCardId"/>'+
			'<input type="hidden" name="trains[0].houseId" class="houseId"/>'+
			'<input type="hidden" name="trains[0].year" class="year"/>'+
			'<input type="hidden" name="trains[0].member.id" class="memberId"/>'+
			'<input type="hidden" name="trains[0].member.idNumber" class="idNumber"/>'+
			'<input type="text" name="trains[0].member.name" class="memberName required"/>'+

			'</td>'+
			'<td>'+
					'<select class="trainingType">' +
					'<option value="01">短期技能培训</option>' +
					'<option value="02">农民实用技术培训</option>' +
					'<option value="99">其他</option>' +
					'</select>'+
			'</td>'+
			'<td>'+
			'<input name="trains[0].trainingDate" type="text" readonly="readonly"'+
			'class="trainingDate input-medium Wdate required"'+
			'value=""'+
			'onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});"'+
			'style="width: 120px;height:90%;background-color: #FFFFFF;border:0px none #FFFFFF;"/>'+
			'</td>'+
			'<td>'+
			'<input type="text" name="trains[0].trainingContent" class="trainingContent"/>'+
			'</td>'+
			'<td>'+
			'<input type="text" name="trains[0].trainingSpecialty" class="trainingSpecialty"/>'+
			'</td>'+
			'<td>'+
			'<input type="text" name="trains[0].trainingSchool" class="trainingSchool"/>'+
			'</td>'+
			'<td>'+
			'<input type="text" name="trains[0].certificates" class="certificates"/>'+
			'</td>'+
			'<td>'+
			'<select name="removalFlag" class="removalFlag">'+
			'<option value="1" >搬迁前</option>'+
			'<option value="2" >搬迁后</option>'+
			'</select>'+
			'</td>'+
					'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>'+
					'</tr>';
//				$(this).parents("tbody").append(trHtml);
			$(this).parents("#inputForm").find("tbody").append(trHtml);
			$("select").select2();
			rename();
		});
		$("#tab-1").delegate(".del-thistd-btn","click",function(){
			$(this).parents("tr").remove();
			rename();
		});
		function rename(){
			var i=-1;
			$('#accpitem tr').each(function(){
//				console.debug("i = "+i);
				$(this).find('.id').attr('name','trains['+i+'].id');
				$(this).find('.poorRegCardId').attr('name','trains['+i+'].poorRegCardId');
				$(this).find('.houseId').attr('name','trains['+i+'].houseId');
				$(this).find('.year').attr('name','trains['+i+'].year');
				$(this).find('.memberId').attr('name','trains['+i+'].member.id');
				$(this).find('.memberName').attr('name','trains['+i+'].member.name');
				$(this).find('.idNumber').attr('name' , 'trains['+i+'].member.idNumber');
				$(this).find('.trainingType').attr('name','trains['+i+'].trainingType');
				$(this).find('.trainingDate').attr('name','trains['+i+'].trainingDate');
				$(this).find('.trainingContent').attr('name','trains['+i+'].trainingContent');
				$(this).find('.trainingSpecialty').attr('name','trains['+i+'].trainingSpecialty');
				$(this).find('.trainingSchool').attr('name','trains['+i+'].trainingSchool');
				$(this).find('.certificates').attr('name','trains['+i+'].certificates');
				$(this).find('.removalFlag').attr('name','trains['+i+'].removalFlag');

				i++;
			});
		};
	});
</script>

</body>
</html>
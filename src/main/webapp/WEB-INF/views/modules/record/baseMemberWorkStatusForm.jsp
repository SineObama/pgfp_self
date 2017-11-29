<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>家庭成员就业情况管理</title>
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
		<li class="active"><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${card.id}">家庭成员就业情况<shiro:hasPermission name="record:baseMemberWorkStatus:edit">${not empty baseMemberWorkStatus.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:baseMemberWorkStatus:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">家庭成员就业情况</a>
	</div>
	<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/basePoorerRegCard/form?id=${card.id}">基本情况</a></li>
		<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${card.id}">家庭成员</a></li>
		<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${card.id}">家庭成员受培训情况</a></li>
		<li class="active"><a>家庭成员就业情况</a></li>
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
	<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/baseMemberWorkStatus/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="houseId"/>
		<form:hidden path="years"/>
		<sys:message content="${message}"/>

		<br/>
		<table>
			<tbody id="accpitem">
			<tr>
				<td>姓名</td>
				<td>务工情况</td>
				<td>就业单位</td>
				<td>就业行业</td>
				<td>月收入</td>
				<td>年内务工时间<br/>（月数）</td>
				<td>工作意愿</td>
				<td>意愿去向</td>
				<td>意愿行业</td>
				<td>是否搬迁后数据</td>
				<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${card.works != null && !card.works.isEmpty()}">
				<c:forEach items="${card.works}" var="work" varStatus="status">
					<tr class="bg-white">
						<td>
							<input type="hidden" name="works[${status.index}].id" value="${work.id}" class="id"/>
							<input type="hidden" name="works[${status.index}].poorRegCardId" value="${work.poorRegCardId}" class="poorRegCardId"/>
							<input type="hidden" name="works[${status.index}].houseId" value="${work.houseId}" class="houseId"/>
							<input type="hidden" name="works[${status.index}].year" value="${work.year}" class="year"/>
							<input type="hidden" name="works[${status.index}].member.id" value="${work.member.id}" class="memberId"/>
							<input type="hidden" name="works[${status.index}].member.idNumber" value="${work.member.idNumber}" class="idNumber"/>
							<input type="text" name="works[${status.index}].member.name" value="${work.member.name}" class="memberName"/>

						</td>
						<td>
							<%--<input type="text" name="works[${status.index}].workStation" value="${work.workStation}" class="workStation"/>--%>
							<form:select path="works[${status.index}].workStation" class="workStation"
										 items="${fns:getDictList('migrant_workers')}" itemLabel="label" itemValue="value"/>
						</td>
						<td>
								<input type="text" name="works[${status.index}].unit" value="${work.unit}" class="unit"/>

						</td>
						<td>
							<input type="text" name="works[${status.index}].industry" value="${work.industry}" class="industry"/>
						</td>
						<td>
							<input type="text" name="works[${status.index}].income" value="${work.income}" class="income decimal required"/>
						</td>
						<td>
							<input type="text" name="works[${status.index}].workMonth" value="${work.workMonth}" class="workMonth int required"/>
						</td>
						<td>
							<input type="text" name="works[${status.index}].workWilling" value="${work.workWilling}" class="workWilling"/>
						</td>
						<td>
							<%--<input type="text" name="works[${status.index}].willDestination" value="${work.willDestination}" class="willDestination"/>--%>
							<form:select path="works[${status.index}].willDestination" class="willDestination"
										 items="${fns:getDictList('migrant_workers')}" itemLabel="label" itemValue="value"/>
						</td>
						<td>
							<input type="text" name="works[${status.index}].willIndustry" value="${work.willIndustry}" class="willIndustry"/>

						</td>
						<td>
							<select name="works[${status.index}].removalFlag" class="removalFlag">
								<option value="1" <c:if test="${work.removalFlag eq '1'}"> selected ="selected" </c:if> >搬迁前</option>
								<option value="2" <c:if test="${work.removalFlag eq '2'}"> selected ="selected" </c:if> >搬迁后</option>
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
//				console.debug('click add');
//				var _len=$("#accpitem tr").length - 1;
				var trHtml = '<tr class="bg-white">'+
						'<td>'+
						'<input type="hidden" name="works[0].id"  class="id"/>'+
				'<input type="hidden" name="works[0].poorRegCardId" class="poorRegCardId"/>'+
				'<input type="hidden" name="works[0].houseId"class="houseId"/>'+
				'<input type="hidden" name="works[0].year" class="year"/>'+
				'<input type="hidden" name="works[0].member.id"  class="memberId"/>'+
				'<input type="hidden" name="works[0].member.idNumber"  class="idNumber"/>'+
				'<input type="text" name="works[0].member.name" class="memberName"/>'+
				'</td>'+
				'<td>'+
//				'<input type="text" name="works[0].workStation" class="workStation"/>' +
						'<select id="works[0].workStation" name="works[0].workStation" class="workStation select2-offscreen" tabindex="-1">' +
						'<option value="01">县内</option>' +
						'<option value="02">省内县外</option>' +
						'<option value="03">省外务工</option>' +
						'<option value="99">其他</option>' +
						'</select>'+

				'</td>'+
				'<td>'+
				'<input type="text" name="works[0].unit" class="unit"/>'+
				'</td>'+
				'<td>'+
				'<input type="text" name="works[0].industry" class="industry"/>'+
				'</td>'+
				'<td>'+
				'<input type="text" name="works[0].income" class="income decimal required"/>'+
				'</td>'+
				'<td>'+
				'<input type="text" name="works[0].workMonth" class="workMonth int required"/>'+
				'</td>'+
				'<td>'+
				'<input type="text" name="works[0].workWilling" class="workWilling"/>'+
				'</td>'+
				'<td>'+
//				'<input type="text" name="works[0].willDestination" class="willDestination"/>'+
						'<select id="works[0].willDestination" name="works[0].willDestination" class="willDestination select2-offscreen" tabindex="-1">' +
						'<option value="01">县内</option>' +
						'<option value="02">省内县外</option>' +
						'<option value="03">省外务工</option>' +
						'<option value="99">其他</option>' +
						'</select>'+
				'</td>'+
				'<td>'+
				'<input type="text" name="works[0].willIndustry" class="willIndustry"/>'+
				'</td>'+
				'<td>'+
				'<select name="works[0].removalFlag" class="removalFlag">'+
				'<option value="1" >搬迁前</option>'+
				'<option value="2">搬迁后</option>'+
				'</select>'+
				'</td>'+
				'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>'+

				'</tr>';
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
					$(this).find('.id').attr('name','works['+i+'].id');
					$(this).find('.poorRegCardId').attr('name','works['+i+'].poorRegCardId');
					$(this).find('.houseId').attr('name','works['+i+'].houseId');
					$(this).find('.year').attr('name','works['+i+'].year');
					$(this).find('.memberId').attr('name','works['+i+'].member.id');
					$(this).find('.memberName').attr('name','works['+i+'].member.name');
					$(this).find('.idNumber').attr('name' , 'works['+i+'].member.idNumber');
					$(this).find('.workStation').attr('name','works['+i+'].workStation');
					$(this).find('.unit').attr('name','works['+i+'].unit');
					$(this).find('.industry').attr('name','works['+i+'].industry');
					$(this).find('.income').attr('name','works['+i+'].income');
					$(this).find('.workMonth').attr('name','works['+i+'].workMonth');
					$(this).find('.workWilling').attr('name','works['+i+'].workWilling');
					$(this).find('.willDestination').attr('name','works['+i+'].willDestination');
					$(this).find('.willIndustry').attr('name','works['+i+'].willIndustry');
					$(this).find('.removalFlag').attr('name','works['+i+'].removalFlag');

					i++;
				});
			};
		});
	</script>
</body>
</html>
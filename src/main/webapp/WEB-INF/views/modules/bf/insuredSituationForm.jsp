<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>家庭成员参保情况管理</title>
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
	<%--<li><a href="${ctx}/bf/insuredSituation/">家庭成员参保情况表列表</a></li>--%>
	<%--<li><a href="${ctx}/record/basePoorerinsuredHelpInfo/">贫困户在校生受帮扶情况列表</a></li>--%>
	<li class="active"><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${card.id}">家庭成员参保情况表<shiro:hasPermission name="bf:insuredSituation:edit">${not empty insuredSituation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bf:insuredSituation:edit">查看</shiro:lacksPermission></a></li>
</ul>
<div class="header">
	<a href="" class="header-lt">贫困户建档立卡</a>
	<a href="" class="header-rt">家庭成员参保情况</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/basePoorerRegCard/form?id=${card.id}">基本情况</a></li>
		<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${card.id}">家庭成员</a></li>
		<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${card.id}">家庭成员受培训情况</a></li>
		<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${card.id}">家庭成员就业情况</a> </li>
		<li class="active"><a>家庭成员参保情况</a></li>
		<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${card.id}">生产生活条件</a></li>
		<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=re${card.id}">家庭经济情况</a></li>
		<li><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${card.id}">特色产业增收</a></li>
		<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${card.id}">帮扶需求</a></li>
		<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${card.id}">帮扶单位及责任人</a></li>
		<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${card.id}">家庭在校生受帮扶情况</a></li>
		<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${card.id}">填表记录</a></li>
	</ul>
	<div id="tab-15" class="content-detail">
		<form:form id="inputForm" modelAttribute="card" action="${ctx}/bf/insuredSituation/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="years"/>
			<sys:message content="${message}"/>

			<br/>
			<table>
				<tbody id="accpitem">
				<tr>
					<td>姓名</td>
					<td>险种</td>
					<td>金额</td>
					<td>报销比例(%)</td>
					<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
				</tr>
				<c:if test="${card.insuredSituations != null && !card.insuredSituations.isEmpty()}">
				<c:forEach items="${card.insuredSituations}" var="insured" varStatus="status">
				<tr>
					<td class="bg-white">
						<input type="hidden" name="insuredSituations[${status.index}].id" value="${insured.id}" class="id"/>
						<input type="hidden" name="insuredSituations[${status.index}].poorerRegCardId" class="poorerRegCardId" value="${insured.poorerRegCardId}"/>
						<form:hidden path="insuredSituations[${status.index}].member.id" class="memberId"/>
						<form:input type="text" path="insuredSituations[${status.index}].member.name" class="name required"/>
					</td>
					<td class="bg-white">
						<%--<form:input path="insuredSituations[${status.index}].insuredType" class="insuredType required"/>--%>
						<form:select path="insuredSituations[${status.index}].insuredType" class="insuredType required">
							<form:option value="" label="----------------------"/>
							<form:options items="${fns:getDictList('insurance')}" itemValue="value" itemLabel="label"/>
						</form:select>
					</td>
					<td class="bg-white">
						<form:input maxlength="11" type="text" path="insuredSituations[${status.index}].money" class="money"/>
					</td>
					<td class="bg-white">
						<form:input path="insuredSituations[${status.index}].percent"  maxlength="8" class="percent"/>
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
			var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?poorerRegCardId="+cardId+"&selectMode=0", "选择家庭成员", "width=" + iWidth +
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
					'<td class="bg-white">' +
					'<input type="hidden" name="insuredSituations['+_len+'].id"  class="id">'+
					'<input type="hidden" name="insuredSituations['+_len+'].poorerRegCardId" class="poorerRegCardId" >'+
					'<input type="hidden" name="insuredSituations['+_len+'].member.id" class="memberId">'+
					'<input id="insuredSituations'+_len+'.name" name="insuredSituations['+_len+'].member.name" class="name required" type="text" >'+
					'</td>' +
					'<td class="bg-white">' +
					'<select  class="insuredType">' +
					'<option value="1">------------------</option>'+
					'<option value="1">城乡居民基本医疗保险</option>' +
					'<option value="2">城乡居民基本养老保险</option>' +
					'<option value="3">商业医疗保险</option>' +
					'<option value="4">商业养老保险</option>' +
					'</select>' +
					'</td>'+
//					'<td class="bg-white">'+
//					'<input id="insuredSituations'+_len+'.insuredType" name="insuredSituations['+_len+'].insuredType" class="insuredType" type="text" >'+
//					'</td>'+
					'<td class="bg-white">'+
					'<input id="insuredSituations'+_len+'.money" name="insuredSituations['+_len+'].money" class="money decimal" type="text" >'+
					'</td>'+
					'<td class="bg-white">'+
					'<input id="insuredSituations'+_len+'.percent" name="insuredSituations['+_len+'].percent" class="percent decimal" type="text"/>'+
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
				$(this).children('td').children('.id').attr('name','insuredSituations['+i+'].id');
				$(this).children('td').children('.memberId').attr('name','insuredSituations['+i+'].member.id');
				$(this).children('td').children('.poorerRegCardId').attr('name','insuredSituations['+i+'].poorerRegCardId');
				$(this).children('td').children('.name').attr('name','insuredSituations['+i+'].member.name');
				$(this).children('td').children('.insuredType').attr('name','insuredSituations['+i+'].insuredType');
				$(this).children('td').children('.money').attr('name','insuredSituations['+i+'].money');
				$(this).children('td').children('.percent').attr('name','insuredSituations['+i+'].percent');
				i++;
			});
		};
	});
</script>
</body>
</html>
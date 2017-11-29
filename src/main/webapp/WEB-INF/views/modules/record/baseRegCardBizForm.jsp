<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户特色产业增收管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		var tr;
		function chooseBiz(biz){
			var existId = false;
			$('#accpitem tr').each(function() {
				var bizId = $(this).find(".bizId").val();
				if(bizId == biz.id){
					existId = true;
					return;
				}
			});
			if(existId){
				alert("已经存在"+biz.name+"产业，请核实情况再录入！");
			} else {
				tr.find(".bizName").val(biz.name);
				tr.find(".bizId").val(biz.id);
				tr.find(".unit").val(biz.unit);
			}
		}

		$(document).ready(function() {

			$("#accpitem").delegate(".bizName",'click',function(){
				tr = $(this).parents("tr");
				var iWidth = 900;
				var iHeight = 500;
				var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
				var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
				var win = window.open("${ctx}/cms/cmsBizinfo/chooseBiz", "弹出窗口", "width=" + iWidth +
				", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
				",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
				"status=no,alwaysRaised=yes,depended=yes");
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/record/basePoorerRegCard/">建档立卡表列表</a></li>
		<li class="active"><a href="${ctx}/record/baseRegCardBiz/form?regCardId=${baseRegCardBiz.regCardId}">贫困户特色产业增收<shiro:hasPermission name="record:baseRegCardBiz:edit">${not empty baseRegCardBiz.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:baseRegCardBiz:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">家庭成员</a>
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
			<li class="active">特色产业增收</li>
			<li><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${card.id}">帮扶需求</a></li>
			<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${card.id}">帮扶单位及责任人</a></li>
			<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${card.id}">家庭在校生受帮扶情况</a></li>
			<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${card.id}">填表记录</a></li>
		</ul>
		<div id="tab-15" class="content-detail">
			<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/baseRegCardBiz/save" method="post" class="form-horizontal">
				<sys:message content="${message}"/>
				<form:hidden  path="id"/>
				<form:hidden path="houseId"/>
				<form:hidden path="years"/>
				<br/>
				<table>
					<tbody id="accpitem">
					<tr>
						<td>特色产业名称</td>
						<td>数量</td>
						<td>单位</td>
						<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
					</tr>
					<c:if test="${card.bizs != null && !card.bizs.isEmpty()}">
						<c:forEach items="${card.bizs}" var="biz" varStatus="status">
							<tr>
							<td class="bg-white">
								<input type="hidden" name="bizs[${status}].id" class="id" value="${biz.id}"/>
								<input type="hidden" name="bizs[${status}].cmsBizinfo.id" class="bizId" value="${biz.cmsBizinfo.id}"/>
								<input type="text" name="bizs[${status}].cmsBizinfo.name" class="bizName" value="${biz.cmsBizinfo.name}"/>
							</td>
							<td class="bg-white">
								<input type="text" name="bizs[${status}].amount" class="amount decimal" value="${biz.amount}"/>
							</td>
							<td>
								<input type="text" name="bizs[${status}].cmsBizinfo.unit" class="unit" value="${biz.cmsBizinfo.unit}" disabled/>
							</td>
							<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
								</tr>
						</c:forEach>
					</c:if>
					</tbody>
				</table>

				<div class="content-save">
					<shiro:hasPermission name="record:basePoorerRegCard:edit">
						<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;"
							   type="submit" value="保 存"/>
						</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;"
						   value="返 回" onclick="history.go(-1)"/>
				</div>
			</form:form>
		</div>

	</div>
	<script >
		$(function () {
			$(".content-nav li").each(function () {
				$(this).click(function () {
					$(".header-rt").text($(this).text())
				})
			});

			$(".add-tr-btn").click(function(){
				var _len=$("#accpitem tr").length - 1;
				var trHtml = '<tr>'+
						'<td class="bg-white">' +
							'<input type="hidden" name="bizs[0].id" class="id"/>' +
							'<input type="hidden" name="bizs[0].cmsBizinfo.id" class="bizId"/>' +
							'<input type="text" name="bizs[0].cmsBizinfo.name" class="bizName"/>' +
						'</td>'+
						'<td class="bg-white">'+
							'<input type="text" name="bizs[0].amount" class="amount decimal"/>'+
						'</td>'+
						'<td>'+
							'<input type="text" name="bizs[0].cmsBizinfo.unit" class="unit" disabled/>'+
						'</td>'+
						'<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>'+
						'</tr>';
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
					$(this).children('td').children('.id').attr('name','bizs['+i+'].id');
					$(this).children('td').children('.bizId').attr('name','bizs['+i+'].cmsBizinfo.id');
					$(this).children('td').children('.bizName').attr('name','bizs['+i+'].cmsBizinfo.name');
					$(this).children('td').children('.amount').attr('name','bizs['+i+'].amount');
					$(this).children('td').children('.unit').attr('name','bizs['+i+'].cmsBizinfo.unit');

					i++;
				});
			};
		});
	</script>
</body>
</html>
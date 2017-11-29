<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户家庭成员管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
		<%--<li><a href="${ctx}/record/basePoorerFamilyMember/">贫困户家庭成员列表</a></li>--%>
		<li class="active"><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${card.id}">家庭成员<shiro:hasPermission name="record:basePoorerFamilyMember:edit">${not empty basePoorerFamilyMember.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:basePoorerFamilyMember:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<div class="header">
		<a href="" class="header-lt">贫困户建档立卡</a>
		<a href="" class="header-rt">家庭成员</a>
	</div>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li><a href="${ctx}/record/basePoorerRegCard/form?id=${card.id}">基本情况</a></li>
			<li class="active"><a>家庭成员</a></li>
			<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${card.id}">家庭成员受培训情况</a></li>
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
	<div id="tab-15" class="content-detail">
	<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/basePoorerFamilyMember/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>
		<form:hidden  path="id"/>
		<form:hidden path="residenceBookletNumber"/>
		<form:hidden path="years"/>
		<br/>
		<table>
			<tbody id="accpitem">
			<tr>
					<td>序号<font color="red">&nbsp;&nbsp;*</font></td>
					<td>A4姓名<font color="red">&nbsp;&nbsp;*</font></td>
					<td>A5性别</td>
					<td>出生年月</td>
					<td>A7公民身份证号或残疾证号<font color="red">&nbsp;&nbsp;*</font></td>
					<td>联系电话<font color="red">&nbsp;&nbsp;*</font></td>
					<td>A8与户主关系</td>
					<td>A9民族</td>
					<td>A10文化程度</td>
					<%--<td>A10文化程度</td>--%>
					<td>政治面貌</td>
					<td>是否现役军人</td>
					<td>A11在校生情况</td>
					<td>A12健康状况</td>
					<td>A13劳动能力</td>
				<%--SWEET--%>
				    <td>是否有意愿参加培训</td>
				    <td>培训状况</td>
				    <td>意愿行业</td>
				    <td>意愿去向</td>
				<%--<--%>
					<td>A14务工状况</td>
				    <td>就业单位</td>
					<td>A15年内务工时间（月数）</td>
					<%--<td>A16是否参加新型农村合作医疗或城镇居民医疗保险</td>--%>
					<%--<td>A17是否参加城乡居民基本养老保险 或城镇居民养老保险</td>--%>
					<td>是否享受低保政策</td>
					<td>是否享受养老保险待遇</td>
				<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
			</tr>
			<c:if test="${card.members != null && !card.members.isEmpty()}">
			<c:forEach items="${card.members}" var="member" varStatus="status">
			<tr>
				<td class="bg-white">
					<input type="hidden" name="members[${status.index}].id" value="${member.id}" class="id"/>
					<input type="hidden" name="members[${status.index}].poorerRegCardId" class="poorerRegCardId" value="${member.poorerRegCardId}"/>
					<form:input path="members[${status.index}].idx" cssClass="idx input-mini required" maxlength="20"/>
				</td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].name" class="name required"/></td>
				<td class="bg-white">
					<form:radiobuttons path="members[${status.index}].sex" class="sex" items="${fns:getDictList('sex')}" itemValue="value" itemLabel="label"/>
				</td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].birthDate" class="birthDate"/></td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].idNumber" class="idNumber required" maxlength="30"/></td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].phone" class="phone required" maxlength="30"/></td>
				<td class="bg-white">
					<form:select path="members[${status.index}].householderRelationship" class="householderRelationship "  items="${fns:getDictList('relationship_with_householder')}" itemValue="value" itemLabel="label" />
				</td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].nation" class="nation"/></td>
				<td class="bg-white">
					<form:select path="members[${status.index}].educationalLevel"
								 items="${fns:getDictList('degree_of_education')}" itemLabel="label" class="educationalLevel" itemValue="value"/>
				</td>
				<td class="bg-white">
					<form:select path="members[${status.index}].politicalStatus" class="politicalStatus"
								 items="${fns:getDictList('political_outlook')}" itemLabel="label" itemValue="value"/>
				</td>
				<td class="bg-white">
					<form:radiobuttons path="members[${status.index}].activeArmyFlag" class="activeArmyFlag"
										   items="${fns:getDictList('yes_no')}"
										   itemValue="value" itemLabel="label"/>
				</td>
				<td class="bg-white">
					<form:select path="members[${status.index}].studentStatus" class="studentStatus"
								 items="${fns:getDictList('students_situation')}" itemLabel="label" itemValue="value" style="width:120px;"/>
				</td>
				<td class="bg-white">
					<form:select path="members[${status.index}].healthCondition" class="healthCondition"
								 items="${fns:getDictList('health')}"
								 itemLabel="label" itemValue="value"/>
					<%--<form:input type="text" path="members[${status.index}].healthCondition"/>--%>
				</td>
				<td class="bg-white">
					<form:select path="members[${status.index}].laborCapacity" class="laborCapacity"
								 items="${fns:getDictList('labor_skill')}" itemLabel="label" itemValue="value"/>
				</td>
				<%--1.是否参加培训 2.培训状况  务工：3.意愿行业 4.意愿去向5.就业单位--%>
				<td class="bg-white">
						<form:radiobuttons path="members[${status.index}].joinCultivateFlag" class="joinCultivateFlag"
										   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
				</td>
				<td class="bg-white">
						<form:select path="members[${status.index}].cultivateSituation" class="cultivateSituation"
									 items="${fns:getDictList('cultivate_situation')}" itemLabel="label" itemValue="value"/>
				</td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].willIndustry" class="willIndustry"/></td>
				<td class="bg-white">
					<form:select path="members[${status.index}].willDestination" class="willDestination"
								 items="${fns:getDictList('migrant_workers')}" itemLabel="label" itemValue="value"/>
				</td>
				<td class="bg-white">
					<form:select path="members[${status.index}].workingConditions" class="workingConditions"
								 items="${fns:getDictList('migrant_workers')}" itemLabel="label" itemValue="value"/>
				</td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].employmentUnit" class="employmentUnit"/></td>
				<td class="bg-white"><form:input type="text" path="members[${status.index}].workingTime" class="decimal workingTime"/></td>
				<%--<td class="bg-white">--%>
					<%--<form:radiobuttons path="members[${status.index}].joinMedicareFlag" class="joinMedicareFlag"--%>
									   <%--items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>--%>
				<%--</td>--%>
				<%--<td class="bg-white">--%>
					<%--<form:radiobuttons path="members[${status.index}].joinEndowmentInsuranceFlag" class="joinEndowmentInsuranceFlag"--%>
									   <%--items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>--%>
				<%--</td>--%>
				<td class="bg-white">
					<form:radiobuttons path="members[${status.index}].enjoyLowEnsure" class="enjoyLowEnsure"
									   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
				</td>
				<td class="bg-white">
					<form:radiobuttons path="members[${status.index}].enjoyEndowment" class="enjoyEndowment"
									   items="${fns:getDictList('yes_no')}" itemValue="value" itemLabel="label"/>
				</td>
				<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
			</tr>
				</c:forEach>
				</c:if>

			<%--<tr>--%>
				<%--<td colspan="18">--%>

				<%--</td>--%>
			<%--</tr>--%>
			</tbody>
		</table>

		<div class="content-save">
			<shiro:hasPermission name="record:basePoorerRegCard:edit">
				<input class="save-btn add-tr-btn" style="margin-right:30px !important; width: 120px;" type="button" value="添加"/>
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;"
					   data-toggle="modal" data-target="#myModal" type="button" value="保 存"/>
				<%--<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="button" value="修改家庭成员变更原因"/>--%>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</div>

</div>



<div class="modal fade" style="display: none;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	 aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title text-center" id="myModalLabel">请修改家庭成员变动原因</h4>
			</div>
			<%--<form action="${ctx}/record/basePoorerRegCard/updateMemberChangeReason" id="editSave" method="post">--%>
				<div class="modal-body">
					<%--<input type="hidden" value="${card.id}">--%>
					<textarea  style="width:100%;" rows="6" id="memberChangeReason">${card.memberChangeReason}</textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" id="sub" class="btn btn-primary" >提交</button>
				</div>
			<%--</form>--%>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal -->
</div>
	<script >
		//点击提交时
		$("#sub").click(function(){
			var requiredList = $('#accpitem .required');
			var isOk = true;
			requiredList.each(function(){
				var val = $(this).val();
				if(val == null || val == ''){
					alert('存在必输项未填写完整！');
					$("#inputForm").submit();
					isOk = false;
					return isOk;
				}
			});
			if(isOk){
				var memberChangeReason = $('#memberChangeReason').val();
					var id = $('#id').val();
					var action = "";
					$.ajax({
						type: "POST",
						url:"${ctx}/record/basePoorerRegCard/updateMemberChangeReason",
						data:{id:id , memberChangeReason:memberChangeReason},
						sucess : function(msg){
						}
					});
				}
				$("#inputForm").submit();
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
				var _len=$("#accpitem tr").length - 1;
				var trHtml = '<tr>'+
						'<td class="bg-white">'+
						'<input type="hidden" name="members['+_len+'].id" class="id"/>'+
						'<input type="hidden" name="members['+_len+'].poorerRegCardId" class="poorerRegCardId"/>'+
						'<input type="text" name="members['+_len+'].idx" class="idx input-mini required" maxlength="2"/>'+
						'</td>'+
						'<td class="bg-white">'+
						'<input id="members'+_len+'.name" name="members['+_len+'].name" type="text" class="valid name required"/>'+
						'</td>'+
						'<td class="bg-white">'+
						'<span><input id="members'+_len+'.sex1" name="members['+_len+'].sex" type="radio" value="01" checked="checked" class="sex">'+
						'<label for="members'+_len+'.sex1">男</label></span>'+
						'<span><input id="members'+_len+'.sex2" name="members['+_len+'].sex" type="radio" value="02" class="sex">'+
						'<label for="members'+_len+'.sex2">女</label></span>'+
						'</td>'+
						'<td class="bg-white">' +
						'<input id="members'+_len+'.birthDate" name="members['+_len+'].birthDate" type="text" class="birthDate">'+
						'</td>'+
						'<td class="bg-white">' +
						'<input id="members'+_len+'.idNumber" name="members['+_len+'].idNumber" type="text" class="idNumber required" maxlength="30">' +
						'</td>'+
						'<td class="bg-white">' +
						'<input id="members'+_len+'.phone" name="members['+_len+'].phone" type="text" class="phone required" maxlength="30">' +
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.householderRelationship" class="householderRelationship">'+
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen1" >'+
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results"></ul></div>' +
						'</div>' +
						'<select id="members'+_len+'.householderRelationship" name="members['+_len+'].householderRelationship" tabindex="-1" class="select2-offscreen householderRelationship">' +
						'<option value="01" selected="selected">本人或户主</option>' +
						'<option value="02">配偶</option>' +
						'<option value="03">之子</option>' +
						'<option value="04">之女</option>' +
						'<option value="05">之儿媳</option>' +
						'<option value="06">之女婿</option>' +
						'<option value="07">之孙子</option>' +
						'<option value="08">之孙女</option>' +
						'<option value="09">之外孙子</option>' +
						'<option value="10">之外孙女</option>' +
						'<option value="11">之父</option>' +
						'<option value="12">之母</option>' +
						'<option value="13">之岳父</option>' +
						'<option value="14">之岳母</option>' +
						'<option value="15">之公公</option>' +
						'<option value="16">之婆婆</option>' +
						'<option value="17">之祖父</option>' +
						'<option value="18">之祖母</option>' +
						'<option value="19">之外祖父</option>' +
						'<option value="20">之外祖母</option>' +
						'<option value="99">其他</option>' +
						'</select>'+
						'</td>'+
						'<td class="bg-white">' +
						'<input id="members'+_len+'.nation" name="members['+_len+'].nation" type="text" class="nation">' +
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.educationalLevel">' +
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen2">' +
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results"></ul>' +
						'</div>' +
						'</div>' +
						'<select id="members'+_len+'.educationalLevel" name="members['+_len+'].educationalLevel" tabindex="-1" class="select2-offscreen educationalLevel">' +
						'<option value="01" selected="selected">文盲或半文盲</option>' +
						'<option value="02">小学</option>' +
						'<option value="03">初中</option>' +
						'<option value="04">高中</option>' +
						'<option value="05">大专及以上</option>' +
						'<option value="06">学龄前儿童</option>' +
						'</select>'+
						'</td>'+
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
						'<select id="members'+_len+'.politicalStatus" name="members['+_len+'].politicalStatus" tabindex="-1" class="select2-offscreen politicalStatus">' +
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
						'<td class="bg-white">'+
						'<span>' +
						'<input id="members'+_len+'.activeArmyFlag1" name="members['+_len+'].activeArmyFlag" class="activeArmyFlag" type="radio" value="1">' +
						'<label for="members'+_len+'.activeArmyFlag1">是</label>' +
						'</span>' +
						'<span>' +
						'<input id="members'+_len+'.activeArmyFlag2" name="members['+_len+'].activeArmyFlag" class="activeArmyFlag" type="radio" value="0" checked="checked">' +
						'<label for="members'+_len+'.activeArmyFlag2">否</label>' +
						'</span>'+
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.studentStatus">' +
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen4">' +
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results">' +
						'</ul></div></div>' +
						'<select id="members'+_len+'.studentStatus"  name="members['+_len+'].studentStatus" tabindex="-1" class="studentStatus select2-offscreen" style="width:120px;">' +
						'<option value="01" selected="selected">非在校生</option>' +
						'<option value="02">学前教育</option>' +
						'<option value="03">小学</option>' +
						'<option value="04">七年级</option>' +
						'<option value="05">八年级</option>' +
						'<option value="06">九年级</option>' +
						'<option value="07">高中一年级</option>' +
						'<option value="08">高中二年级</option>' +
						'<option value="09">高中三年级</option>' +
						'<option value="10">中职一年级</option>' +
						'<option value="11">中职二年级</option>' +
						'<option value="12">中职三年级</option>' +
						'<option value="13">高职一年级</option>' +
						'<option value="14">高职二年级</option>' +
						'<option value="15">高职三年级</option>' +
						'<option value="16">大专及以上</option>' +
						'</select>'+
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.healthCondition">' +
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen5">' +
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results">' +
						'</ul></div></div>' +
						'<select id="members'+_len+'.healthCondition" name="members['+_len+'].healthCondition" tabindex="-1" class="healthCondition select2-offscreen">' +
						'<option value="01" selected="selected">健康</option>' +
						'<option value="02">长期慢性病</option>' +
						'<option value="03">大病</option>' +
						'<option value="04">残疾</option>' +
						'</select>'+
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.laborCapacity">' +
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen6">' +
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results">' +
						'</ul></div></div>' +
						'<select id="members'+_len+'.laborCapacity" name="members['+_len+'].laborCapacity" tabindex="-1" class="laborCapacity select2-offscreen">' +
						'<option value="01" selected="selected">普通劳动力</option>' +
						'<option value="02">技能劳动力</option>' +
						'<option value="03">丧失劳动力</option>' +
						'<option value="04">无劳动力</option>' +
						'</select>'+
						'</td>'+
						<%--1.是否参加培训 2.培训状况 。。。--%>
						'<td class="bg-white">'+
						'<span>' +
						'<input id="members'+_len+'.joinCultivateFlag1" name="members['+_len+'].joinCultivateFlag" class="joinCultivateFlag" type="radio" value="1" checked="checked">' +
						'<label for="members'+_len+'.joinCultivateFlag1">是</label>' +
						'</span>' +
						'<span>' +
						'<input id="members'+_len+'.joinCultivateFlag2" name="members['+_len+'].joinCultivateFlag" class="joinCultivateFlag" type="radio" value="0">' +
						'<label for="members'+_len+'.joinCultivateFlag2">否</label>' +
						'</span>'+
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.cultivateSituation">' +
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen7">' +
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results">' +
						'</ul></div></div>' +
						'<select id="members'+_len+'.cultivateSituation" name="members['+_len+'].cultivateSituation" tabindex="-1" class="cultivateSituation select2-offscreen">' +
//					'<option value="01" selected="selected">县内</option>' +
						'<option value="01">短期技能培训</option>' +
						'<option value="02">农民实用技术培训</option>' +
						'<option value="99">其他</option>' +
						'</select>'+
						'</td>'+
						'<td class="bg-white">' +
						'<input id="members'+_len+'.willIndustry" name="members['+_len+'].willIndustry" type="text" class="willIndustry">'+
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.willDestination">' +
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen7">' +
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results">' +
						'</ul></div></div>' +
						'<select id="members'+_len+'. willDestination" name="members['+_len+']. willDestination" tabindex="-1" class=" willDestination select2-offscreen">' +
						'<option value="01" selected="selected">县内</option>' +
						'<option value="02">省内县外</option>' +
						'<option value="04">区内务工</option>' +
						'<option value="03">省外务工</option>' +
						'<option value="99">其他</option>' +
						'</select>'+
						'</td>'+
						'<td class="bg-white">'+
						'<div class="select2-container" id="s2id_members'+_len+'.workingConditions">' +
						'<input class="select2-focusser select2-offscreen" type="text" id="s2id_autogen7">' +
						'<div class="select2-drop select2-display-none select2-with-searchbox">' +
						'<div class="select2-search">' +
						'<input type="text" autocomplete="off" autocorrect="off" autocapitalize="off" spellcheck="false" class="select2-input">' +
						'</div>' +
						'<ul class="select2-results">' +
						'</ul></div></div>' +
						'<select id="members'+_len+'.workingConditions" name="members['+_len+'].workingConditions" tabindex="-1" class="workingConditions select2-offscreen">' +
						'<option value="01" selected="selected">县内</option>' +
						'<option value="02">省内县外</option>' +
						'<option value="03">省外务工</option>' +
						'<option value="99">其他</option>' +
						'</select>'+
						'</td>'+
						'<td class="bg-white">' +
						'<input id="members'+_len+'.employmentUnit" name="members['+_len+'].employmentUnit" type="text" class="employmentUnit">'+
						'</td>'+
						'<td class="bg-white">' +
						'<input id="members'+_len+'.workingTime" name="members['+_len+'].workingTime" type="text" class="workingTime decimal">' +
						'</td>'+
//						'<td class="bg-white">'+
//						'<span>' +
//						'<input id="members'+_len+'.joinMedicareFlag1" name="members['+_len+'].joinMedicareFlag" class="joinMedicareFlag" type="radio" value="1" checked="checked">' +
//						'<label for="members'+_len+'.joinMedicareFlag1">是</label>' +
//						'</span>' +
//						'<span>' +
//						'<input id="members'+_len+'.joinMedicareFlag2" name="members['+_len+'].joinMedicareFlag" class="joinMedicareFlag" type="radio" value="0">' +
//						'<label for="members'+_len+'.joinMedicareFlag2">否</label>' +
//						'</span>'+
//						'</td>'+
//						'<td class="bg-white">'+
//						'<span>' +
//						'<input id="members'+_len+'.joinEndowmentInsuranceFlag1" name="members['+_len+'].joinEndowmentInsuranceFlag" class="joinEndowmentInsuranceFlag2" type="radio" value="1">' +
//						'<label for="members'+_len+'.joinEndowmentInsuranceFlag1">是</label>' +
//						'</span>' +
//						'<span>' +
//						'<input id="members'+_len+'.joinEndowmentInsuranceFlag2" name="members['+_len+'].joinEndowmentInsuranceFlag" class="joinEndowmentInsuranceFlag2" type="radio" value="0" checked="checked">' +
//						'<label for="members'+_len+'.joinEndowmentInsuranceFlag2">否</label>' +
//						'</span>'+
//						'</td>'+
						'<td class="bg-white">'+
						'<span>' +
						'<input id="members'+_len+'.enjoyLowEnsure1" name="members['+_len+'].enjoyLowEnsure" class="enjoyLowEnsure" type="radio" value="1">' +
						'<label for="members'+_len+'.joinEndowmentInsuranceFlag1">是</label>' +
						'</span>' +
						'<span>' +
						'<input id="members'+_len+'.enjoyLowEnsure2" name="members['+_len+'].enjoyLowEnsure" class="enjoyLowEnsure" type="radio" value="0" checked="checked">' +
						'<label for="members'+_len+'.joinEndowmentInsuranceFlag2">否</label>' +
						'</span>'+
						'</td>'+
						'<td class="bg-white">'+
						'<span>' +
						'<input id="members'+_len+'.enjoyLowEnsure1" name="members['+_len+'].enjoyEndowment" class="enjoyEndowment" type="radio" value="1">' +
						'<label for="members'+_len+'.joinEndowmentInsuranceFlag1">是</label>' +
						'</span>' +
						'<span>' +
						'<input id="members'+_len+'.enjoyLowEnsure2" name="members['+_len+'].enjoyEndowment" class="enjoyEndowment" type="radio" value="0" checked="checked">' +
						'<label for="members'+_len+'.joinEndowmentInsuranceFlag2">否</label>' +
						'</span>'+
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
//				console.debug("i = "+i);
					$(this).children('td').children('.id').attr('name','members['+i+'].id');
					$(this).children('td').children('.idx').attr('name','members['+i+'].idx');
					$(this).children('td').children('.poorerRegCardId').attr('name','members['+i+'].poorerRegCardId');
					$(this).children('td').children('.name').attr('name','members['+i+'].name');
					$(this).children('td').children('span').children('.sex').attr('name','members['+i+'].sex');
					$(this).children('td').children('.birthDate').attr('name','members['+i+'].birthDate');
					$(this).children('td').children('.idNumber').attr('name','members['+i+'].idNumber');
					$(this).children('td').children('.phone').attr('name','members['+i+'].phone');
					$(this).children('td').children('.householderRelationship').attr('name','members['+i+'].householderRelationship');
					$(this).children('td').children('.nation').attr('name','members['+i+'].nation');
					$(this).children('td').children('.educationalLevel').attr('name','members['+i+'].educationalLevel');
					$(this).children('td').children('.politicalStatus').attr('name','members['+i+'].politicalStatus');
					$(this).children('td').children('span').children('.activeArmyFlag').attr('name','members['+i+'].activeArmyFlag');
					$(this).children('td').children('.studentStatus').attr('name','members['+i+'].studentStatus');
					$(this).children('td').children('.healthCondition').attr('name','members['+i+'].healthCondition');
					$(this).children('td').children('.laborCapacity').attr('name','members['+i+'].laborCapacity');
					$(this).children('td').children('span').children('.joinCultivateFlag').attr('name','members['+i+'].joinCultivateFlag');
					$(this).children('td').children('span').children('.cultivateSituation').attr('name','members['+i+'].cultivateSituation');
					$(this).children('td').children('.willIndustry').attr('name','members['+i+'].willIndustry');
					$(this).children('td').children('.willDestination').attr('name','members['+i+'].willDestination');
					$(this).children('td').children('.employmentUnit').attr('name','members['+i+'].employmentUnit');
					$(this).children('td').children('.workingTime').attr('name','members['+i+'].workingTime');
					$(this).children('td').children('.workingConditions').attr('name','members['+i+'].workingConditions');
//					$(this).children('td').children('span').children('.joinMedicareFlag').attr('name','members['+i+'].joinMedicareFlag');
//					$(this).children('td').children('span').children('.joinEndowmentInsuranceFlag').attr('name','members['+i+'].joinEndowmentInsuranceFlag');
					$(this).children('td').children('span').children('.enjoyLowEnsure').attr('name','members['+i+'].enjoyLowEnsure');
					$(this).children('td').children('span').children('.enjoyEndowment').attr('name','members['+i+'].enjoyEndowment');
//				$(this).children('td').children('label').find('input[type=radio]').attr('name','bsAceptances['+i+'].checkedFlag');
					i++;
				});
			};
		});
		//	console.debug('test');
	</script>
</body>
</html>
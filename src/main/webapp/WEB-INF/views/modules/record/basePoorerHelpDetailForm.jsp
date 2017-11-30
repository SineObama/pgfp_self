<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>贫困户帮扶需求管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
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
	<%--<li><a href="${ctx}/record/basePoorerHelpDetail/">贫困户帮扶需求列表</a></li>--%>
	<li class="active"><a href="${ctx}/record/basePoorerHelpDetail/form?poorerRegCardId=${card.id}">贫困户帮扶需求<shiro:hasPermission name="record:basePoorerHelpDetail:edit">${not empty basePoorerHelpDetail.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="record:basePoorerHelpDetail:edit">查看</shiro:lacksPermission></a></li>
</ul>
<div class="header">
	<a href="" class="header-lt">贫困户建档立卡</a>
	<a href="" class="header-rt">帮扶需求</a>
</div>
<div class="content tabs f-clear">
	<ul class="content-nav">
		<li><a href="${ctx}/record/basePoorerRegCard/form?id=${card.id}">基本情况</a></li>
		<li><a href="${ctx}/record/basePoorerFamilyMember/form?poorerRegCardId=${card.id}">家庭成员</a></li>
		<li><a href="${ctx}/record/baseMemberTrainingStatus/form?cardId=${card.id}">家庭成员受培训情况</a></li>
		<li><a href="${ctx}/record/baseMemberWorkStatus/form?cardId=${card.id}">家庭成员就业情况</a> </li>
		<li><a href="${ctx}/record/baseProductionLivingCondition/form?poorerRegCardId=${card.id}">生产生活条件</a></li>
		<li><a href="${ctx}/record/baseFamilyEconomicInfo/form?poorerRegCardId=${card.id}">家庭经济情况</a></li>
		<li class="active">帮扶需求</li>
		<li><a href="${ctx}/record/basePoorerSupportUnitInfo/form?poorerRegCardId=${card.id}">帮扶单位及责任人</a></li>
		<li><a href="${ctx}/record/basePoorerStudentHelpInfo/form?poorerRegCardId=${card.id}">家庭在校生受帮扶情况</a></li>
		<li><a href="${ctx}/record/basePoorerRegCard/tpPlan?id=${card.id}">脱贫计划及其他</a></li>
		<li><a href="${ctx}/bf/insuredSituation/form?poorerRegCardId=${card.id}">参保情况</a></li>
	</ul>
	<div id="tab-15" class="content-detail">

		<form:form id="inputForm" modelAttribute="card" action="${ctx}/record/basePoorerHelpDetail/save" method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<form:hidden path="years"/>
			<%--<form:hidden path="poorerRegCardId"/>--%>
			<sys:message content="${message}"/>
		<br/>
		<table>
			<tbody id="accpitem">
			<tr>
				<td rowspan="2" style="text-align: center;">A54类别<br/>（单选）</td>
				<td rowspan="2" style="text-align: center;">辅助类别<br/>（最多选两个）</td>
				<td rowspan="1" colspan="2" style="text-align: center;">A55具体需求（最多选三项）</td>
				<td rowspan="2" style="text-align: center; min-width:250px;">A56当前状况</td>
				<td rowspan="2" style="text-align: center; min-width:250px;">A57存在的困难</td>
					<%--<td style="text-align: center;cursor: pointer;" class="add-tr-btn">添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>--%>
			</tr>
			<tr>
				<td style="text-align: center;">帮扶项目</td>
				<td style="text-align: center; min-width:250px;">帮扶内容</td>
			</tr>
			<c:if test="${card.details != null && !card.details.isEmpty()}">
				<c:forEach items="${card.details}" var="detail" varStatus="status">
					<c:choose>
						<c:when test="${detail.showType eq '1'}">
							<tr>
								<td class="bg-white input-width">
									<input type="hidden" name="details[${status.index}].idx" value="${detail.idx}"/>
									<input type="hidden" name="details[${status.index}].helpType" value="${detail.helpType}"/>
									<input type="hidden" name="details[${status.index}].showType" value="${detail.showType}"/>
									<input type="hidden" name="details[${status.index}].id" value="${detail.id}"/>
									<input type="checkbox" class="tdA" name="details[${status.index}].isFirstHelp" <c:if test="${detail.isFirstHelp eq 'on'}">checked="true" </c:if>/>
										${detail.helpType}
								</td>
								<td class="bg-white input-width">
									<input type="checkbox" class="tdB" name="details[${status.index}].isAssistHelp" <c:if test="${detail.isAssistHelp eq 'on'}">checked="true" </c:if>/>
										${detail.helpType}
								</td>
								<td class="bg-white input-width">
									<input type="checkbox" class="tdC" name="details[${status.index}].isSelect" <c:if test="${detail.isSelect eq 'on'}">checked="true" </c:if>/>
									<input type="hidden" value="${detail.helpPro}" name="details[${status.index}].helpPro" />
										${detail.helpPro}
								</td>
								<td class="bg-white">
									<input type="text" name="details[${status.index}].content" value="${detail.content}"/>
								</td>
								<td class="bg-white">
									<input type="text" name="details[${status.index}].currentStatus" value="${detail.currentStatus}"/>
								</td>
								<td class="bg-white">
									<input type="text" name="details[${status.index}].existingDifficulty" value="${detail.existingDifficulty}"/>
								</td>
							</tr>
						</c:when>
						<c:when test="${detail.showType eq '2'}">
							<tr>
								<td class="bg-white input-width">
									<input type="hidden" name="details[${status.index}].idx" value="${detail.idx}"/>
									<input type="hidden" name="details[${status.index}].helpType" value="${detail.helpType}"/>
									<input type="hidden" name="details[${status.index}].showType" value="${detail.showType}"/>
									<input type="hidden" name="details[${status.index}].id" value="${detail.id}"/>
									<input type="checkbox" name="details[${status.index}].isFirstHelp" <c:if test="${detail.isFirstHelp eq 'on'}">checked="true" </c:if>/>
										${detail.helpType}
								</td>
								<td class="bg-white input-width">
									<input type="checkbox" name="details[${status.index}].isAssistHelp" <c:if test="${detail.isAssistHelp eq 'on'}">checked="true" </c:if>/>
										${detail.helpType}
								</td>
								<td  class="bg-white typesed" colspan="4" style="height:70px;">
									是否愿意搬迁：&nbsp;&nbsp;<form:radiobuttons path="details[${status.index}].relocateFlag"
																		  itemValue="value" itemLabel="label"  items="${fns:getDictList('yes_no')}"/>
									计划搬迁年份：<form:input path="details[${status.index}].relocateYear" class="int" maxlength="4"/><br/>
									&nbsp;&nbsp;希望安置地点：&nbsp;&nbsp;<form:select path="details[${status.index}].settingPlace">
									<form:option value="" label="-----------"/>
									<form:options  items="${fns:getDictList('place_of_resettlement')}" itemLabel="label" itemValue="value"/>
								</form:select>
									&nbsp;&nbsp;希望安置房类型:&nbsp;&nbsp;<form:select  path="details[${status.index}].HousingTypes">
									<form:option value=" " label="------------"/>
									<form:options items="${fns:getDictList('housing_types')}" itemLabel="label" itemValue="value"/>
								</form:select>
									&nbsp;&nbsp;搬迁原因：&nbsp;&nbsp;<form:select  path="details[${status.index}].relocateReason">
									<form:option value=" " label="------------"/>
									<form:options items="${fns:getDictList('relocation_reasons' )}" itemLabel="label" itemValue="value"/>
								</form:select>

										<%--<form:input path="details[${status.index}].relocateReason"/>--%>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="bg-white input-width">
									<input type="hidden" name="details[${status.index}].idx" value="${detail.idx}"/>
									<input type="hidden" name="details[${status.index}].helpType" value="${detail.helpType}"/>
									<input type="hidden" name="details[${status.index}].showType" value="${detail.showType}"/>
									<input type="hidden" name="details[${status.index}].id" value="${detail.id}"/>
									<input type="checkbox" name="details[${status.index}].isFirstHelp" <c:if test="${detail.isFirstHelp eq 'on'}">checked="true" </c:if>/>
										${detail.helpType}
								</td>
								<td class="bg-white input-width">
									<input type="checkbox" name="details[${status.index}].isAssistHelp" <c:if test="${detail.isAssistHelp eq 'on'}">checked="true" </c:if>/>
										${detail.helpType}
								</td>
								<td  class="bg-white input-width" colspan="4" style="">
									<form:radiobuttons path="details[${status.index}].valueChoose"
													   items="${fns:getDictList(detail.dictType)}" itemValue="value" itemLabel="label"/>
									<form:hidden path="details[${status.index}].dictType"/>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>
			</tr>
			</tbody>
		</table>
		<div class="content-save">
			<shiro:hasPermission name="record:basePoorerRegCard:edit">
				<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
		</div>

		</form:form>
		<script>
			// 这里是勾选的逻辑
			/**
			 * A:A54类别  B:辅助类别  C:帮扶项目
			 */
			$(document).ready(function($) {
				console.log("run!")
				// A列
				var $tdA = $(".tdA");
				// B列
				var $tdB = $(".tdB")
				// C列
				var $tdC = $(".tdC")
				// var aLength = false;
				// 根据AB列确定C列的checked情况
				$tdA.on('click',  function(event) {
					var aBol = $(this).parents("tr").find("td:eq(0) input[type='checkbox']").attr("checked");
					var bBol = $(this).parents("tr").find("td:eq(1) input[type='checkbox']").attr("checked");
					var c = $(this).parents("tr").find("td:eq(2) input[type='checkbox']");
					var aLength = $(".tdA:checked").length;
					if(bBol){
						$(this).parent().next().find('input[type="checkbox"]').attr('checked', false);
					}
					if(aBol!= 'checked'&&bBol!= 'checked'){
						c.attr('checked', false);
					}else{
						c.attr('checked', true);
					}
					if(aLength>1){
						alert("只能选一个！")
						$(this).attr('checked', false);
						c.attr('checked', false);
					}
				});
				$tdB.on('click',  function(event) {
					var aBol = $(this).parents("tr").find("td:eq(0) input[type='checkbox']").attr("checked");
					var bBol = $(this).parents("tr").find("td:eq(1) input[type='checkbox']").attr("checked");
					var c = $(this).parents("tr").find("td:eq(2) input[type='checkbox']");
					var bLength = $(".tdB:checked").length;
					if(aBol){
						$(this).parent().prev().find('input[type="checkbox"]').attr('checked', false);
					}
					if(aBol!= 'checked'&&bBol!= 'checked'){
						c.attr('checked', false);
					}else{
						c.attr('checked', true);
					}
					if(bLength>2){
						alert("最多选两个！")
						$(this).attr('checked', false);
						c.attr('checked', false);
					}
				});
				$tdC.on('click',function(event){
					console.log($(this).attr("checked"))
					if(!$(this).attr("checked")){
						$(this).parents("tr").find("td:eq(0) input[type='checkbox'],td:eq(1) input[type='checkbox']").attr("checked",false);
					}
				})
			});
		</script>
</body>
</html>
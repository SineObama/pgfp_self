<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>移民搬迁登记管理</title>
	<meta name="decorator" content="default"/>
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
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/migration/countryMigrate/">基本情况列表</a></li>
		<li class="active"><a href="${ctx}/migration/countryMigrate/form?id=${countryMigrate.id}">基本情况<shiro:hasPermission name="migration:countryMigrate:edit">${not empty countryMigrate.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="migration:countryMigrate:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<div class="content tabs f-clear">
		<ul class="content-nav">
			<li class="active">基本情况</li>
			<li><a href="${ctx}/migration/relocationPlanSituation/form?countryMigrateId=${countryMigrate.id}">移民搬迁情况</a></li>
			<li><a href="${ctx}/migration/bNaturalVillageRelocationPlan/form?countryMigrateId=${countryMigrate.id}">移民搬迁规划</a></li>
			<li><a href="${ctx}/migration/bRelocationFinishStatus/form?countryMigrateId=${countryMigrate.id}">任务完成情况</a></li>
			<li><a href="${ctx}/migration/table/form?countryMigrateId=${countryMigrate.id}&type=1">填表</a></li>
		</ul>
		<div id="tab-1" class="content-detail">
			<form:form id="inputForm" modelAttribute="countryMigrate" action="${ctx}/migration/countryMigrate/save" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<sys:message content="${message}"/>

				<div class="control-group" style="float: left">
					<label class="control-label">村名:</label>
					<div class="controls">
						<sys:treeselect id="area" name="area.id" value="${countryMigrate.area.id}" labelName="area.name" labelValue="${countryMigrate.area.name}"
										title="村名" url="/sys/area/treeData" extId="${countryMigrate.area.id}" cssClass="" allowClear="true" />
					</div>
				</div>
				<div class="control-group" style="float: left">
					<label class="control-label">归属年度:</label>
					<div class="controls">
						<input name="years" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
							   value="<fmt:formatDate value="${countryMigrate.yearDate}" pattern="yyyy"/>"
							   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"/>
					</div>
				</div>
				<table>
					<tbody>
					<tr>
						<td class="fir-td" width="40%">
							<span>总户数（户）</span>
						</td>
						<td class="sec-td bg-white" width="15%">
							<form:input path="totalHou" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
						<td class="thr-td" colspan="2" width="35%">
							<span>意愿安置点类型</span>
						</td>
						<td class="fou-td bg-white" width="10%" >
								<%--<form:input path="desiredSiteType" htmlEscape="false" maxlength="11" class="input-xlarge required "/>--%>
							<%--<form:select path="desiredSiteType" class="required" style="width:100%">--%>
								<%--<form:option value="1">集中安置</form:option>--%>
								<%--<form:option value="2">分散安置</form:option>--%>
							<%--</form:select>--%>
							<form:select path="desiredSiteType">
								<form:option value="" label="-----------"/>
								<form:options  items="${fns:getDictList('place_of_resettlement')}" itemLabel="label" itemValue="value"/>

							</form:select>

						</td>
					</tr>
					<tr>
						<td class="fir-td">
							<span>总人数（人）</span>
						</td>
						<td class="sec-td bg-white">
							<form:input path="totalPer" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
						<td class="thr-td"colspan="2">
							<span>已搬迁户数（户）</span>
						</td>
						<td class="fou-td bg-white">
							<form:input path="relocatedHou" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
					</tr>
					<tr>
						<td class="fir-td">
							<span>贫困户（户）</span>
						</td>
						<td class="sec-td bg-white">
							<form:input path="poorHou" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
						<td class="thr-td"colspan="2">
							<span>已搬迁人数（人）</span>
						</td>
						<td class="fou-td bg-white">
							<form:input path="relocatedPer" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
					</tr>
					<tr>
						<td class="fir-td">
							<span>贫困人数（人）</span>
						</td>
						<td class="sec-td bg-white">
							<form:input path="poorPer" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
						<td class="thr-td" rowspan="2">
					<span>其中：纳入<form:input path="yearNew" htmlEscape="false" maxlength="11" class="input-xlarge required " style="width: 80px;height: 28px;"/>
						年扶贫生态移民计划</span>
						</td>
						<td class="fou-td">
							<span>（户）</span>
						</td>
						<td class="fou-td bg-white">
							<form:input path="household" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
					</tr>
					<tr>
						<td class="fir-td">
							<span>是否需要整体搬迁</span>
						</td>
						<td class="sec-td bg-white" style="text-align: center">
							<form:radiobuttons path="overallRelocation" items="${fns:getDictList('yes_no')}" itemValue="value" itemlabel="label" />
						</td>
						<td class="fou-td">
							<span>（人）</span>
						</td>
						<td class="fou-td bg-white">
							<form:input path="person" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
					</tr>
					<tr>
						<td class="fir-td">
							<span>搬迁原因</span>
						</td>
						<td class="sec-td bg-white">
								<%--<form:input path="relocationReason" htmlEscape="false" maxlength="100" class="input-xlarge required"/>--%>
							<%--<form:select path="relocationReason" class="required" style="width:100%">--%>
								<%--<form:option value="1">缺乏生存条件</form:option>--%>
								<%--<form:option value="2">生态脆弱</form:option>--%>
								<%--<form:option value="3">避灾避险</form:option>--%>
								<%--<form:option value="4">自然保护区</form:option>--%>
							<%--</form:select>--%>
							<form:select path="relocationReason" >
								<form:option value=" " label="------------"/>
								<form:options items="${fns:getDictList('relocation_reasons' )}" itemLabel="label" itemValue="value"/>
							</form:select>
						</td>
						<td class="thr-td"colspan="2">
							<span>已安置点类型</span>
						</td>
						<td class="fou-td bg-white">
								<%--<form:input path="siteTpye" htmlEscape="false" maxlength="11" class="input-xlarge required"/>--%>
							<%--<form:select path="siteTpye" class="required" style="width:100%">--%>
								<%--<form:option value="1">集中安置</form:option>--%>
								<%--<form:option value="2">分散安置</form:option>--%>
							<%--</form:select>--%>
								<form:select path="siteTpye">
									<form:option value="" label="-----------"/>
									<form:options  items="${fns:getDictList('place_of_resettlement')}" itemLabel="label" itemValue="value"/>

								</form:select>
						</td>
					</tr>
					<tr>
						<td class="fir-td">
							<span>意愿搬迁年度</span>
						</td>
						<td class="sec-td bg-white">
							<form:input path="wishYear" htmlEscape="false" maxlength="11" class="input-xlarge required int"/>
						</td>
						<td class="thr-td"colspan="2">
							<span></span>
						</td>
						<td class="fou-td bg-white" >
							<span></span>
						</td>
					</tr>
					</tbody>
				</table>
				<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
			</form:form>
		</div>
	</div>
	</body>
</head>
</html>
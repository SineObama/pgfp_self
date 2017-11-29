<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>县贫困家庭学生享受教育精准扶贫政策情况统计表管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\countyExport.css"/>
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


            $(function () {
                $(".content-nav #educationPolicy").attr("class", "active");
            });

        });
	</script>
</head>
<body>
<div class="main">
	<input type="hidden" id="main_year" value="${cuMain['year']}">
	<input type="hidden" id="main_id" value="${cuMain['id']}">
</div>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/record/cuMain/">年度扶贫档案列表</a></li>
	<shiro:hasPermission name="record:cuMain:view">
		<li class="active">
			<a href="">扶贫年度档案添加</a>
		</li>
	</shiro:hasPermission>
</ul>
<div class="content tabs f-clear">
	<jsp:include page="cuItemList.jsp"/>
	<div id="tab-1" class="content-detail">

		<form:form id="inputForm" modelAttribute="cuTable"
				   action="${ctx}/record/cuCountyEducationPolicy/save" method="post"
				   class="form-horizontal">
			<sys:message content="${message}"/>
			<input type="hidden" name="id" value="${cuTable.id}"/>
			<input type="hidden" name="cuMainId" value="${cuTable.cuMainId}"/>
			<input type="hidden" name="year" value="${cuTable.year}"/>
			<input type="hidden" name="type" value="${cuTable.type}"/>
			<h1 id="h1" style="text-align: center">
				平桂县贫困家庭学生享受教育精准扶贫政策情况统计表
			</h1>
			<br/><br/>
			<p style="margin-bottom: 5px!important;">
                <span id="span-1" class="department" style="float: left">
                    <input type="hidden" readonly="true" class="departmentId" name="department.id"
						   value="2"/>
             填报单位：<input class="underline departmentName required" readonly="true" name="department.name"
						 value="平桂"
						 style="width: 80px" maxlength="20"/>县（市、区）教育、扶贫部门（盖章） 单位：人，万元
                </span>
				<span style="float: right">填报时间：<input name="time" id="time" type="text" maxlength="20"
													   class="input-medium Wdate required"
													   value="<fmt:formatDate value="${cuTable.time}" pattern="yyyy-MM-dd"/>"
													   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
													   style="width: 120px;background-color: #FFFFFF;border:1px solid #ccc;"/>
        </span>
			</p>
			<br/>
			<div>
				<table>
					<thead>
					<tr>
						<td style="width:150px!important;">就学学段</td>
						<td>学前教育</td>
						<td>义务教育</td>
						<td>普通高中</td>
						<td>中职教育</td>
						<td>高等教育</td>
                        <td>合计</td>
						<td>备注</td>
                    </tr>
					</thead>
					<tbody id="accpitem">
					<tr>
                        <td>
                            <input class="dataType td-input" style="width:140px!important;background-color:#f5f5f5!important;"
                                    name="cuCountyEducationPolicies[0].dataType"
                                    value="贫困家庭学生数" readonly/>
                        </td>
                        <td class="bg-white">
                            <input type="hidden" class="id" name="cuCountyEducationPolicies[0].id" value="${cuTable.cuCountyEducationPolicies[0].id}"/>
                            <input class="preschoolEducation int td-input required"
                                   name="cuCountyEducationPolicies[0].preschoolEducation"
                                   value="${cuTable.cuCountyEducationPolicies[0].preschoolEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="compulsoryEducation int td-input required"
                                   name="cuCountyEducationPolicies[0].compulsoryEducation"
                                   value="${cuTable.cuCountyEducationPolicies[0].compulsoryEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="seniorSchool int td-input required"
                                   name="cuCountyEducationPolicies[0].seniorSchool"
                                   value="${cuTable.cuCountyEducationPolicies[0].seniorSchool}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="vocationalEducation int td-input required"
                                   name="cuCountyEducationPolicies[0].vocationalEducation"
                                   value="${cuTable.cuCountyEducationPolicies[0].vocationalEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="higherEducation int td-input required"
                                   name="cuCountyEducationPolicies[0].higherEducation"
                                   value="${cuTable.cuCountyEducationPolicies[0].higherEducation}" maxlength="8"/>
                        </td>
                        <td>
                            ${cuTable.cuCountyEducationPolicies[0].total}
                        </td>
                        <td class="bg-white">
                            <input class="remarks td-input"
                                   name="cuCountyEducationPolicies[0].remarks"
                                   value="${cuTable.cuCountyEducationPolicies[0].remarks}" maxlength="8"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="dataType td-input" style="width:140px!important;background-color:#f5f5f5!important;"
                                   name="cuCountyEducationPolicies[1].dataType"
                                   value="享受资助人数" readonly/>
                            </td>
                        <td class="bg-white">
                            <input type="hidden" class="id" name="cuCountyEducationPolicies[1].id" value="${cuTable.cuCountyEducationPolicies[1].id}"/>
                            <input class="preschoolEducation int td-input required"
                                   name="cuCountyEducationPolicies[1].preschoolEducation"
                                   value="${cuTable.cuCountyEducationPolicies[1].preschoolEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="compulsoryEducation int td-input required"
                                   name="cuCountyEducationPolicies[1].compulsoryEducation"
                                   value="${cuTable.cuCountyEducationPolicies[1].compulsoryEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="seniorSchool int td-input required"
                                   name="cuCountyEducationPolicies[1].seniorSchool"
                                   value="${cuTable.cuCountyEducationPolicies[1].seniorSchool}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="vocationalEducation int td-input required"
                                   name="cuCountyEducationPolicies[1].vocationalEducation"
                                   value="${cuTable.cuCountyEducationPolicies[1].vocationalEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="higherEducation int td-input required"
                                   name="cuCountyEducationPolicies[1].higherEducation"
                                   value="${cuTable.cuCountyEducationPolicies[1].higherEducation}" maxlength="8"/>
                        </td>
                        <td>
                                ${cuTable.cuCountyEducationPolicies[1].total}
                        </td>
                        <td class="bg-white">
                            <input class="remarks td-input"
                                   name="cuCountyEducationPolicies[1].remarks"
                                   value="${cuTable.cuCountyEducationPolicies[1].remarks}" maxlength="8"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="dataType td-input" style="width:140px!important;background-color:#f5f5f5!important;"
                                   name="cuCountyEducationPolicies[2].dataType"
                                   value="享受资助金额" readonly/>
                        </td>
                        <td>
                            <input type="hidden" class="id" name="cuCountyEducationPolicies[2].id" value="${cuTable.cuCountyEducationPolicies[2].id}"/>
                            ————
                        </td>
                        <td class="bg-white">
                            <input class="compulsoryEducation decimal td-input required"
                                   name="cuCountyEducationPolicies[2].compulsoryEducation"
                                   value="${cuTable.cuCountyEducationPolicies[2].compulsoryEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="seniorSchool decimal td-input required"
                                   name="cuCountyEducationPolicies[2].seniorSchool"
                                   value="${cuTable.cuCountyEducationPolicies[2].seniorSchool}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="vocationalEducation decimal td-input required"
                                   name="cuCountyEducationPolicies[2].vocationalEducation"
                                   value="${cuTable.cuCountyEducationPolicies[2].vocationalEducation}" maxlength="8"/>
                        </td>
                        <td class="bg-white">
                            <input class="higherEducation decimal td-input required"
                                   name="cuCountyEducationPolicies[2].higherEducation"
                                   value="${cuTable.cuCountyEducationPolicies[2].higherEducation}" maxlength="8"/>
                        </td>
                        <td>
                                ${cuTable.cuCountyEducationPolicies[2].total}
                        </td>
                        <td class="bg-white">
                            <input class="remarks td-input"
                                   name="cuCountyEducationPolicies[2].remarks"
                                   value="${cuTable.cuCountyEducationPolicies[2].remarks}" maxlength="8"/>
                        </td>
                    </tr>
					</tbody>
				</table>
				<span style="float: left;">
                 审核人：<input class="underline realName" name="verifier" value="${cuTable.verifier}" style="width: 100px"
							maxlength="20"/>&nbsp;&nbsp;&nbsp;
                 填表人：<input class="underline realName required" name="reportingName" value="${cuTable.reportingName}"
							style="width: 100px" maxlength="20"/>&nbsp;&nbsp;&nbsp;
                 联系电话：<input class="underline phone required" name="phone" value="${cuTable.phone}" style="width: 100px"
							 maxlength="11"/>
                </span>

			</div>

			<div class="form-actions actions">
				<div class="submitStyle">
					<shiro:hasPermission name="record:cuCountyEducationPolicy:edit">
						<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
						<input id="btnExport" class="btn btn-primary btnEx" type="button" value="导 出"/>&nbsp;
					</shiro:hasPermission>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</div>
			</div>
		</form:form>
	</div>
</div>
</body>
</html>
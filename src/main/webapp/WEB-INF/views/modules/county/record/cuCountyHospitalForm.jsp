<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>县辖区二级以上公立医院情况表管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\countyExport.css"/>

    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });

            $(function () {
                $(".content-nav #Hospital").attr("class", "active");
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
                   action="${ctx}/record/cuCountyHospital/save" method="post"
                   class="form-horizontal">
            <sys:message content="${message}"/>
            <input type="hidden" name="id" value="${cuTable.id}"/>
            <input type="hidden" name="cuMainId" value="${cuTable.cuMainId}"/>
            <input type="hidden" name="year" value="${cuTable.year}"/>
            <input type="hidden" name="type" value="${cuTable.type}"/>
            <h1 id="h1" style="text-align: center">
                平桂县辖区二级以上公立医院情况表
            </h1>
            <br/><br/>
            <p style="margin-bottom: 5px!important;">
                <span id="span-1" class="department" style="float: left">
                    <input type="hidden" readonly="true" class="departmentId" name="department.id"
                           value="2"/>
             填报单位：<input class="underline departmentName required" readonly="true" name="department.name"
                         value="平桂"
                         style="width: 80px" maxlength="20"/>县(市、区）卫生计生局（盖章）
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
                        <td width="70px">序号</td>
                        <td width="180px">医院名称</td>
                        <td width="100px">等级</td>
                        <td width="180px">地址</td>
                        <td width="110px">院长姓名</td>
                        <td width="150px">联系方式</td>
                        <td width="80px">备注</td>
                        <td style="text-align: center;cursor: pointer;width: 60px;" class="add-tr-btn" rowspan="3">
                            添加<span
                                style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
                    </tr>
                    </thead>
                    <tbody id="accpitem">
                    <c:if test="${!empty cuTable.cuCountyHospitals}">
                        <c:forEach items="${cuTable.cuCountyHospitals}" var="county" varStatus="status">
                            <c:set var="indexN" value="${status.index+1}" scope="page"/>
                            <input type="hidden" class="id" name="cuCountyHospitals[${status.index}].id"
                                   value="${county.id}"/>
                            <tr>
                                <td class="bg-white">${indexN}</td>
                                <td class="bg-white">
                                    <input class="hospitalName td-input" style="width: 120px!important;"
                                           name="cuCountyHospitals[${status.index}].hospitalName"
                                           value="${county.hospitalName}" maxlength="100"/>
                                </td>
                                <td class="bg-white">
                                    <input class="grade td-input"
                                           name="cuCountyHospitals[${status.index}].grade"
                                           value="${county.grade}" maxlength="100"/>
                                </td>
                                <td class="bg-white">
                                    <input class="adress td-input" style="width: 120px!important;"
                                           name="cuCountyHospitals[${status.index}].adress"
                                           value="${county.adress}" maxlength="11"/>
                                </td>
                                <td class="bg-white">
                                    <input class="deanName td-input realName  "
                                           name="cuCountyHospitals[${status.index}].deanName"
                                           value="${county.deanName}" maxlength="30"/>
                                </td>
                                <td class="bg-white">
                                    <input class="phone td-input phone" style="width: 100px!important;"
                                           name="cuCountyHospitals[${status.index}].phone"
                                           value="${county.phone}"/>
                                </td>
                                <td class="bg-white">
                                    <input class="remarks td-input"
                                           name="cuCountyHospitals[${status.index}].remarks"
                                           value="${county.remarks}"/>
                                </td>
                                <td class="bg-white" style="text-align: center">
                                    <span class="del-thistd-btn">删除</span>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
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
                    <shiro:hasPermission name="record:cuCountyHospital:edit">
                        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
                        <input id="btnExport" class="btn btn-primary btnEx" type="button" value="导 出"/>&nbsp;
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
                </div>
            </div>
        </form:form>
    </div>
</div>
<script>

    var index = 0;
    var renum = 0;

    /*添加删除一行tr方法*/
    function reflowIndex() {
        var trs = $('tbody tr');
        var trLen = trs.length;
        for (var i = 0; i <= trLen; i++) {
            var tr = trs[i];
            $(tr).find("td:eq(0)").text(i + 1);
        }
    };

    $(function () {
        $(".add-tr-btn").click(function () {
            index = $("table tbody").find("tr").length;
            var num = index + renum;
            var tr = '<tr>' +
                '<td class="bg-white">' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input hospitalName" style="width: 120px!important;" maxlength="100" name="cuCountyHospitals[' + num + '].hospitalName"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input  grade" maxlength="100" name="cuCountyHospitals[' + num + '].grade"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input adress" style="width: 120px!important;" maxlength="100" name="cuCountyHospitals[' + num + '].adress"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input deanName realName  " maxlength="30" name="cuCountyHospitals[' + num + '].deanName"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input phone" style="width: 100px!important;" maxlength="11" name="cuCountyHospitals[' + num + '].phone"/> ' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input remarks" name="cuCountyHospitals[' + num + '].remarks" maxlength="500"/>' +
                '</td>' +
                '<td class="bg-white" style="text-align: center">' +
                '<span class="del-thistd-btn">删除</span>' +
                '</td>' +
                '</tr>';
            $("table tbody").append(tr);
            reflowIndex();
        });

        $("#tab-1").delegate(".del-thistd-btn", "click", function () {
            $(this).parents("tr").remove();
            renum++;
            reflowIndex();
        });
    });
</script>
</body>
</html>
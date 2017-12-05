<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\countyExport.css"/>
    <script type="text/javascript">
        $(document).ready(function () {
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

            $('.btnEx').click(function () {
                top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v) {
                    var cuTable = null;
                    if (v == "ok") {
                        window.location.href = "${ctx}/county/record/countyIncapabilityOrWorkout/export?type=${cuTable.type}&cuMainId=${cuTable.cuMainId}";
                    }
                });
            });

            $(function () {
                $(".content-nav #labour1").attr("class", "active");
            });
        })
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
                   action="${ctx}/county/record/countyIncapabilityOrWorkout/save" method="post" class="form-horizontal">
            <sys:message content="${message}"/>
            <input type="hidden" name="id" value="${cuTable.id}"/>
            <input type="hidden" name="cuMainId" value="${cuTable.cuMainId}"/>
            <input type="hidden" name="year" value="${cuTable.year}"/>
            <input type="hidden" name="type" value="${cuTable.type}"/>
            <h1 style="text-align: center">平桂区无劳动能力或主要劳动力长期外出务工贫困户</h1>
            <br/><br/>
            <p style="margin-bottom: 5px!important;">
            <span class="department" style="float: left">
                <input type="hidden" class="departmentId" name="department.id" value="2"/>
                填报单位：<input class="underline departmentName" value="平桂"
                            style="width: 80px" maxlength="20" readonly/>县（市、区）产业开发专责小组
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
                        <td rowspan="3">序号</td>
                        <td rowspan="3">乡（镇）</td>
                        <td rowspan="2" colspan="2">无劳动能力或主要劳动力长期外出务工贫困户</td>
                        <td colspan="4">其中</td>
                        <td rowspan="3">备注</td>
                        <td style="text-align: center;cursor: pointer;width: 60px;" class="add-tr-btn" rowspan="3">
                            添加<span
                                style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
                    </tr>
                    <tr>
                        <td colspan="2">无劳动能力贫困户</td>
                        <td colspan="2">主要劳动力长期外出务工贫困户</td>
                    </tr>
                    <tr>
                        <td>户数</td>
                        <td>人数</td>
                        <td>户数</td>
                        <td>人数</td>
                        <td>户数</td>
                        <td>人数</td>
                    </tr>
                    </thead>
                    <tbody id="accpitem">
                    <c:if test="${!empty cuTable.cuCountyIncapabilityOrWorkouts}">
                        <c:forEach items="${cuTable.cuCountyIncapabilityOrWorkouts}" var="county" varStatus="status">
                            <c:set var="indexN" value="${status.index+1}" scope="page"/>
                            <input type="hidden" class="id" name="cuCountyIncapabilityOrWorkouts[${status.index}].id"
                                   value="${county.id}"/>
                            <tr>
                                <td class="bg-white">${indexN}</td>
                                <td class="bg-white required town">
                                    <input type="hidden" class="townId"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].townId"
                                           value="${county.townId}"/>
                                    <input class="td-input townName"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].town.name"
                                           readonly="true" value="${county.town.name}"/>
                                </td>
                                <td class="bg-white">
                                    <input class="incapabilityOrWorkoutHouse td-input int required"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].incapabilityOrWorkoutHouse"
                                           value="${county.incapabilityOrWorkoutHouse}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="incapabilityOrWorkoutNumber td-input int required"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].incapabilityOrWorkoutNumber"
                                           value="${county.incapabilityOrWorkoutNumber}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="incapabilityHouse td-input int required"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].incapabilityHouse"
                                           value="${county.incapabilityHouse}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="incapabilityNumber td-input int required"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].incapabilityNumber"
                                           value="${county.incapabilityNumber}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="workoutHouse td-input int required"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].workoutHouse"
                                           value="${county.workoutHouse}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="workoutNumber td-input int required"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].workoutNumber"
                                           value="${county.workoutNumber}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="remarks td-input"
                                           name="cuCountyIncapabilityOrWorkouts[${status.index}].remarks"
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
                    <shiro:hasPermission name="record:countyIncapabilityOrWorkout:edit">
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

    var who;

    function chooseMember(area, type) {
        if (type == 0) {
            who.find(".departmentId").val(area.id);
            who.find(".departmentName").val(area.name);
        } else if (type == 1) {
            who.find(".townId").val(area.id);
            who.find(".townName").val(area.name);
        }
    }

    $(function () {
        function call(parentId, type) {
            var iWidth = 800;
            var iHeight = 400;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/cuTable/areaChoose?parentId=" + parentId + "&type=" + type, "选择地区", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
        };
        $("#accpitem").delegate(".town", 'click', function () {
            who = $(this);
            call("2", "1");
        });
    });

</script>
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
                '<input type="hidden" class="id"  name="cuCountyIncapabilityOrWorkouts[' + num + '].id"/>' +
                '<td class="bg-white">' +
                '</td>' +
                '<td class="bg-white town">' +
                '<input type="hidden" class="townId" name="cuCountyIncapabilityOrWorkouts[' + num + '].townId"/>' +
                '<input class="td-input townName required" name="cuCountyIncapabilityOrWorkouts[' + num + '].town.name"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input incapabilityOrWorkoutHouse int required" name="cuCountyIncapabilityOrWorkouts[' + num + '].incapabilityOrWorkoutHouse"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input int incapabilityOrWorkoutNumber required" name="cuCountyIncapabilityOrWorkouts[' + num + '].incapabilityOrWorkoutNumber"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input incapabilityHouse int required" name="cuCountyIncapabilityOrWorkouts[' + num + '].incapabilityHouse"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input incapabilityNumber int required" name="cuCountyIncapabilityOrWorkouts[' + num + '].incapabilityNumber"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input workoutHouse int required" name="cuCountyIncapabilityOrWorkouts[' + num + '].workoutHouse"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input workoutNumber int required" name="cuCountyIncapabilityOrWorkouts[' + num + '].workoutNumber"/>' +
                '</td>' +
                ' <td class="bg-white">' +
                '<input class="td-input remarks" name="cuCountyIncapabilityOrWorkouts[' + num + '].remarks"/>' +
                '</td>' +
                '<td class="bg-white" style="text-align: center">' +
                '<span class="del-thistd-btn">删除</span>' +
                '</td>' +
                '</tr>';
            $("table tbody").append(tr);
            reflowIndex();
        })
        $("#tab-1").delegate(".del-thistd-btn", "click", function () {
            $(this).parents("tr").remove();
            renum++;
            reflowIndex();
        });
    });
</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>县贫困发生率统计表管理</title>
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
                $(".content-nav #PovertyIncidence").attr("class", "active");
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
                   action="${ctx}/record/cuCountyPovertyIncidence/save" method="post"
                   class="form-horizontal">
            <sys:message content="${message}"/>
            <input type="hidden" name="id" value="${cuTable.id}"/>
            <input type="hidden" name="cuMainId" value="${cuTable.cuMainId}"/>
            <input type="hidden" name="year" value="${cuTable.year}"/>
            <input type="hidden" name="type" value="${cuTable.type}"/>
            <h1 id="h1" style="text-align: center">
                平桂县贫困发生率统计表
            </h1>
            <br/><br/>
            <p style="margin-bottom: 5px!important;">
                <span id="span-1" class="department" style="float: left">
                    <input type="hidden" readonly="true" class="departmentId" name="department.id"
                           value="2"/>
             填报单位：<input class="underline departmentName required" readonly="true" name="department.name"
                         value="平桂"
                         style="width: 80px" maxlength="20"/>县（市、区）住房城乡建设部门（盖章）
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
                        <td rowspan="2" width="70px">序号</td>
                        <td rowspan="2" width="100px">乡（镇）</td>
                        <td rowspan="2" width="100px">行政村</td>
                        <td rowspan="2" width="80px">乡村人口数</td>
                        <td rowspan="2" width="80px">2013年底贫困人口数</td>
                        <td colspan="3" width="300px">${cuTable.year - 2}年以来每年脱贫人数</td>
                        <td rowspan="2" width="80px">新增贫困人口数</td>
                        <td rowspan="2" width="80px">返贫人口数</td>
                        <td rowspan="2" width="80px">核验时贫困人口数</td>
                        <td rowspan="2" width="80px">贫困发生率</td>
                        <td rowspan="2" width="80px">备注</td>
                        <td style="text-align: center;cursor: pointer;width: 60px;" class="add-tr-btn" rowspan="2">
                            添加<span
                                style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
                    </tr>
                    <tr>
                        <td width="80px;">${cuTable.year - 2}年脱贫人数</td>
                        <td width="80px;">${cuTable.year - 1}年脱贫人数</td>
                        <td width="80px;">${cuTable.year}年脱贫人数</td>
                    </tr>
                    </thead>
                    <tbody id="accpitem">
                    <c:if test="${!empty cuTable.cuCountyPovertyIncidences}">
                        <c:forEach items="${cuTable.cuCountyPovertyIncidences}" var="county" varStatus="status">
                            <c:set var="indexN" value="${status.index+1}" scope="page"/>
                            <input type="hidden" class="id" name="cuCountyPovertyIncidences[${status.index}].id"
                                   value="${county.id}"/>
                            <tr>
                                <td class="bg-white">${indexN}</td>
                                <td class="bg-white required town">
                                    <input type="hidden" class="townId"
                                           name="cuCountyPovertyIncidences[${status.index}].town.id"
                                           value="${county.town.id}"/>
                                    <input class="td-input townName required"
                                           name="cuCountyPovertyIncidences[${status.index}].town.name"
                                           readonly="true" value="${county.town.name}"/>
                                </td>
                                <td class="bg-white required village">
                                    <input type="hidden" class="villageId"
                                           name="cuCountyPovertyIncidences[${status.index}].village.id"
                                           value="${county.village.id}"/>
                                    <input class="td-input villageName required"
                                           name="cuCountyPovertyIncidences[${status.index}].village.name"
                                           readonly="true" value="${county.village.name}"/>
                                </td>
                                <td class="bg-white">
                                    <input class="people int td-input required"
                                           name="cuCountyPovertyIncidences[${status.index}].people"
                                           value="${county.people}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="poorPeople2013 int td-input required"
                                           name="cuCountyPovertyIncidences[${status.index}].poorPeople2013"
                                           value="${county.poorPeople2013}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="threeYearsAgoNumber td-input int required"
                                           name="cuCountyPovertyIncidences[${status.index}].threeYearsAgoNumber"
                                           value="${county.threeYearsAgoNumber}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="twoYearsAgoNumber td-input int required"
                                           name="cuCountyPovertyIncidences[${status.index}].twoYearsAgoNumber"
                                           value="${county.threeYearsAgoNumber}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="lastYearNumber td-input int required"
                                           name="cuCountyPovertyIncidences[${status.index}].lastYearNumber"
                                           value="${county.lastYearNumber}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="newPoorPeople td-input int required"
                                           name="cuCountyPovertyIncidences[${status.index}].newPoorPeople"
                                           value="${county.newPoorPeople}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="repovertyNumber td-input int required"
                                           name="cuCountyPovertyIncidences[${status.index}].repovertyNumber"
                                           value="${county.repovertyNumber}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="checkPoorPeople td-input int required"
                                           name="cuCountyPovertyIncidences[${status.index}].checkPoorPeople"
                                           value="${county.checkPoorPeople}" maxlength="8"/>
                                </td>
                                <td>
                                    ${county.rate}
                                </td>
                                <td class="bg-white">
                                    <input class="remarks td-input"
                                           name="cuCountyPovertyIncidences[${status.index}].remarks"
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
                    <shiro:hasPermission name="record:cuCountyPovertyIncidence:edit">
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

    var choose;

    function chooseMember(area, type) {
        if (type == 1) {
            choose.find(".townId").val(area.id);
            choose.find(".townName").val(area.name);
            choose.parents('tr').find(".villageId").val("");
            choose.parents('tr').find(".villageName").val("");
        } else if (type == 2) {
            choose.find(".villageId").val(area.id);
            choose.find(".villageName").val(area.name);
        }
    }

    $(function () {
        function openWindow(parentId, type) {
            var iWidth = 800;
            var iHeight = 400;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/cuTable/areaChoose?parentId=" + parentId + "&type=" + type, "选择地区", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
        };
        /*type(1：镇级)*/
        $("#accpitem").delegate(".town", 'click', function () {
            choose = $(this);
            var parentId = $("#span-1").find(".departmentId").val();
            openWindow(parentId, "1");
        });
        /*type(2:村级)*/
        $("#accpitem").delegate(".village", 'click', function () {
            choose = $(this);
            var parentId = choose.parents().find(".townId").val();
            if (parentId == "") {
                alert("请先选择镇！");
                return false;
            }
            openWindow(parentId, "2");
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
            index = $("table tbody").find("tr").length + renum;
            var tr = '<tr>' +
                '<td class="bg-white">' +
                '</td>' +
                '<td class="bg-white town">' +
                '<input type="hidden" class="townId" name="cuCountyPovertyIncidences[' + index + '].town.id"/>' +
                '<input class="td-input townName required" readonly="true" name="cuCountyPovertyIncidences[' + index + '].town.name"/>' +
                '</td>' +
                ' <td class="bg-white village">' +
                '<input type="hidden" class="villageId" name="cuCountyPovertyIncidences[' + index + '].village.id"/>' +
                '<input class="td-input villageName required" readonly="true" name="cuCountyPovertyIncidences[' + index + '].village.name"/>' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input people int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].people"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input poorPeople2013 int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].poorPeople2013"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input threeYearsAgoNumber int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].threeYearsAgoNumber"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input twoYearsAgoNumber int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].twoYearsAgoNumber"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input lastYearNumber int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].lastYearNumber"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input newPoorPeople int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].newPoorPeople"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input repovertyNumber int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].repovertyNumber"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input checkPoorPeople int required" maxlength="8" name="cuCountyPovertyIncidences[' + index + '].checkPoorPeople"/> ' +
                '</td>' +
                '<td>' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input remarks" name="cuCountyPovertyIncidences[' + index + '].remarks" maxlength="500"/>' +
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
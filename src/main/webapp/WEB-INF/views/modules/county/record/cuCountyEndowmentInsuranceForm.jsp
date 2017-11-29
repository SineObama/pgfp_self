<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>县城乡居民养老保险参保情况统计表管理</title>
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
                $(".content-nav #EndowmentInsurance").attr("class", "active");
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
                   action="${ctx}/record/cuCountyEndowmentInsurance/save" method="post"
                   class="form-horizontal">
            <sys:message content="${message}"/>
            <input type="hidden" name="id" value="${cuTable.id}"/>
            <input type="hidden" name="cuMainId" value="${cuTable.cuMainId}"/>
            <input type="hidden" name="year" value="${cuTable.year}"/>
            <input type="hidden" name="type" value="${cuTable.type}"/>
            <h1 id="h1" style="text-align: center">
                平桂县贫困户纳入农村低保户情况统计表
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
                        <td rowspan="2" width="100px">应参保人数</td>
                        <td rowspan="2" width="100px">实际参保人数</td>
                        <td rowspan="2" width="60px">参保率</td>
                        <td rowspan="2" width="100px">截止填报日期实际缴费人数</td>
                        <td colspan="3" width="300px">60周岁以上参保及领取养老保险待遇情况</td>
                        <td rowspan="2" width="80px">备注</td>
                        <td style="text-align: center;cursor: pointer;width: 60px;" class="add-tr-btn" rowspan="3">
                            添加<span
                                style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
                    </tr>
                    <tr>
                        <td width="100px">参保人数</td>
                        <td width="100px">领取养老保险待遇人数</td>
                        <td width="60px">领取率</td>
                    </tr>
                    </thead>
                    <tbody id="accpitem">
                    <c:if test="${!empty cuTable.cuCountyEndowmentInsurances}">
                        <c:forEach items="${cuTable.cuCountyEndowmentInsurances}" var="county" varStatus="status">
                            <c:set var="indexN" value="${status.index+1}" scope="page"/>
                            <input type="hidden" class="id" name="cuCountyEndowmentInsurances[${status.index}].id"
                                   value="${county.id}"/>
                            <tr>
                                <td class="bg-white">${indexN}</td>
                                <td class="bg-white required town">
                                    <input type="hidden" class="townId"
                                           name="cuCountyEndowmentInsurances[${status.index}].town.id"
                                           value="${county.town.id}"/>
                                    <input class="td-input townName required"
                                           name="cuCountyEndowmentInsurances[${status.index}].town.name"
                                           readonly="true" value="${county.town.name}"/>
                                </td>
                                <td class="bg-white required village">
                                    <input type="hidden" class="villageId"
                                           name="cuCountyEndowmentInsurances[${status.index}].village.id"
                                           value="${county.village.id}"/>
                                    <input class="td-input villageName required"
                                           name="cuCountyEndowmentInsurances[${status.index}].village.name"
                                           readonly="true" value="${county.village.name}"/>
                                </td>
                                <td class="bg-white">
                                    <input class="people int td-input required"
                                           name="cuCountyEndowmentInsurances[${status.index}].people"
                                           value="${county.people}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="insuredNumber int td-input required"
                                           name="cuCountyEndowmentInsurances[${status.index}].insuredNumber"
                                           value="${county.insuredNumber}" maxlength="8"/>
                                </td>

                                <td>
                                        ${county.rate}
                                </td>
                                <td class="bg-white">
                                    <input name="cuCountyEndowmentInsurances[${status.index}].pay" maxlength="20"
                                           class="input-medium pay required" type="text"
                                           value="<fmt:formatDate value="${county.pay}" pattern="yyyy-MM-dd"/>"
                                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                           style="width: 80px;"/>

                                </td>
                                <td class="bg-white">
                                    <input class="sixtyPeople int td-input required"
                                           name="cuCountyEndowmentInsurances[${status.index}].sixtyPeople"
                                           value="${county.sixtyPeople}" maxlength="8"/>
                                </td>
                                <td class="bg-white">
                                    <input class="sixtyGetInsuredNumber int td-input required"
                                           name="cuCountyEndowmentInsurances[${status.index}].sixtyGetInsuredNumber"
                                           value="${county.sixtyGetInsuredNumber}" maxlength="8"/>
                                </td>
                                <td>
                                    ${county.sixtyRate}
                                </td>
                                <td class="bg-white">
                                    <input class="remarks td-input"
                                           name="cuCountyEndowmentInsurances[${status.index}].remarks"
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
                    <shiro:hasPermission name="record:cuCountyEndowmentInsurance:edit">
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
                '<input type="hidden" class="townId" name="cuCountyEndowmentInsurances[' + index + '].town.id"/>' +
                '<input class="td-input townName required" readonly="true" name="cuCountyEndowmentInsurances[' + index + '].town.name"/>' +
                '</td>' +
                ' <td class="bg-white village">' +
                '<input type="hidden" class="villageId" name="cuCountyEndowmentInsurances[' + index + '].village.id"/>' +
                '<input class="td-input villageName required" readonly="true" name="cuCountyEndowmentInsurances[' + index + '].village.name"/>' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input people int required" maxlength="8" name="cuCountyEndowmentInsurances[' + index + '].people"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input insuredNumber int required" maxlength="8" name="cuCountyEndowmentInsurances[' + index + '].insuredNumber"/> ' +
                '</td>' +
                '<td>' +
                '<td class="bg-white">' +
                '<input name="cuCountyEndowmentInsurances[' + index + '].pay" type="text" class="input-medium pay" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});"style="width: 80px;background-color: inherit!important;"/>'+
                '</td>' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input sixtyPeople int required" maxlength="8" name="cuCountyEndowmentInsurances[' + index + '].sixtyPeople"/> ' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input sixtyGetInsuredNumber int required" maxlength="8" name="cuCountyEndowmentInsurances[' + index + '].sixtyGetInsuredNumber"/> ' +
                '</td>' +
                '<td>' +
                '</td>' +
                '<td class="bg-white">' +
                '<input class="td-input remarks" name="cuCountyEndowmentInsurances[' + index + '].remarks" maxlength="500"/>' +
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>贫困户劳动力情况管理</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
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
        });
    </script>
</head>
<body>
<style>
    .content-detail td {
        text-align: center;
        min-width: 92px !important;
    }

    /**
     * common Css
     */
    .content-detail .table-title {
        font-size: 24px;
        width: 1000px; /* 标题位置 */
        text-align: center;
        color: #317eac;
        white-space: nowrap;
    }

    .content-detail .table-title input {
        display: inline-block;
        border-radius: 0;
        width: 140px;
        font-size: 18px;
        border-bottom: 1px solid #ccc;
    }

    .content-detail .table-subtitle {
        width: 1000px; /* 副标题位置 */
        font-size: 0;
        white-space: nowrap;
    }

    .content-detail .table-subtitle > span {
        width: 50%;
        display: inline-block;
        font-size: 14px;
        color: #555;
    }

    .content-detail .table-subtitle > span:last-child {
        text-align: right;
    }

    .content-detail .table-subtitle > span:last-child input {
        width: 145px;
    }

    .content-detail .table-subtitle > span input {
        border-radius: 0;
        width: 100px;
        font-size: 16px;
        border-bottom: 1px solid #ccc;
    }

    .text-bottom {
        margin-top: 10px;
        white-space: nowrap;
    }

    .text-bottom span {
        display: inline-block;
        width: 400px; /* 底部文字位置 */
        font-size: 14px;
    }

    /** -------- **/
    #areaName {
        height: 20px;
        border: 1px solid #ccc;
        text-align: start;
        padding: 4px 6px 4px 6px;
        font-size: 14px;
        border-radius: 4px 0 0 4px;
    }
    .table-subtitle span{
        vertical-align: top;
    }
    #fillDate{
        padding: 4px 6px 4px 6px;
    }
</style>
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/co/coCountryYear/">行政村档案清单列表</a></li>
    <%--<li><a href="${ctx}/record/workForceOffice/">驻村工作队情况_干部表列表</a></li>--%>
    <li class="active"><a href="">劳动力情况统计表<shiro:hasPermission
            name="co:coLaborSituation:edit">${not empty coLaborSituation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="co:coLaborSituation:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>

<div class="content tabs f-clear">
    <ul class="content-nav">
        <li><a href="${ctx}/co/coCountryYear/form?id=${comain.coId}">村名与年度</a></li>
        <li><a href="${ctx}/co/coCharacterIndustry/form?coMain.coId=${comain.coId}&coMain.type=1">特色产业情况统计表</a></li>
        <li><a href="${ctx}/co/coPoorHouIndustry/form?coMain.coId=${comain.coId}&coMain.type=2">贫困户产业登记表</a></li>
        <li><a href="${ctx}/co/coLaborOut/form?coId=${comain.coId}&countryId=${countryId}">贫困户劳动力统计表</a></li>
        <li class="active"><a>贫困户劳动力情况表</a></li>
        <li><a href="${ctx}/co/coHouseSecurity/form?coMain.coId=${comain.coId}&coMain.type=5">住房保障达标情况统计表</a></li>
        <li><a href="${ctx}/co/coHouseSituation/form?coId=${comain.coId}&countryId=${countryId}">住房保障未达标户名单情况表</a></li>
        <li><a href="${ctx}/co/coPovertyRelocation/form?coMain.coId=${comain.coId}&coMain.type=7">易地扶贫搬迁户住房保障情况表</a></li>
        <li><a href="${ctx}/co/coBuyMedicalInsurance/form?coMain.coId=${comain.coId}&coMain.type=8">居民购买医疗或商业保险情况</a></li>
        <li><a href="${ctx}/co/coInsuranceNameList/form?coId=${comain.coId}&countryId=${countryId}">未购买医疗或商业保险情况名单</a></li>
        <li><a href="${ctx}/co/coIllTreatment/form?coId=${comain.coId}&countryId=${countryId}">患病救治和补助报销情况统计</a></li>
        <li><a href="${ctx}/co/coChildHaveEducation/form?coMain.coId=${comain.coId}&coMain.type=11">适龄儿童接受义务教育</a></li>
        <li><a href="${ctx}/co/coNoEducation/form?coMain.coId=${comain.coId}&coMain.type=12">适龄儿童未接受义务教育</a></li>
        <li><a href="${ctx}/co/coPoorStudentPolicy/form?coMain.coId=${comain.coId}&coMain.type=13">学生享受教育精准扶贫政策</a></li>
        <li><a href="${ctx}/co/coSafeDrink/form?coId=${comain.coId}&countryId=${countryId}">安全饮水达标情况统计</a></li>
        <li><a href="${ctx}/co/coDrinkSituation/form?coId=${comain.coId}&countryId=${countryId}">未达到安全饮水户名单</a></li>
        <li><a href="${ctx}/co/coRoadSituation/form?coId=${comain.coId}&countryId=${countryId}">通硬化路情况表</a></li>
        <li><a href="${ctx}/co/coTwentyRoad/form?coId=${comain.coId}&countryId=${countryId}">20户以上通路情况表</a></li>
        <li><a href="${ctx}/co/coHaveElectric/form?coMain.coId=${comain.coId}&coMain.type=18">村有电用达标情况统计表</a></li>
        <li><a href="${ctx}/co/coNoElectric/form?coMain.coId=${comain.coId}&coMain.type=19">全村未接通生活用电户名单</a></li>
        <li><a href="${ctx}/co/coCultureSituation/form?coId=${comain.coId}&countryId=${countryId}">篮球场，文化室或戏台情况表</a></li>
        <li><a href="${ctx}/co/coNetwork/form?coId=${comain.coId}&countryId=${countryId}">通网络宽带情况表</a></li>
        <li><a href="${ctx}/co/coEndowmentInsured/form?coMain.coId=${comain.coId}&coMain.type=22">城乡居民养老保险参保情况</a></li>
        <li><a href="${ctx}/co/coNoEndowmentInsured/form?coMain.coId=${comain.coId}&coMain.type=23">城乡居民养老保险未参保名单</a></li>
        <li><a href="${ctx}/co/coAllowances/form?coMain.coId=${comain.coId}&coMain.type=24">贫困户纳入农村低保情况</a></li>
        <li><a href="${ctx}/co/coTvOnline/form?coId=${comain.coId}&countryId=${countryId}">农户能看电视或上网情况统计表</a></li>
        <li><a href="${ctx}/co/coDigitalCount/form?coId=${comain.coId}&countryId=${countryId}">未有数码设备名单</a></li>
        <li><a href="${ctx}/co/coIncidenceOfPoverty/form?coId=${comain.coId}&countryId=${countryId}">贫困发生率统计表</a></li>

    </ul>
    <div id="tab-15" class="content-detail">
        <c:choose>
        <c:when test="${empty comain.coId}">
            <script>
                alert("请先填写村名和年度！");
                window.history.back(-1);
            </script>
        </c:when>
        <c:otherwise>
        <form:form id="inputForm" modelAttribute="comain" action="${ctx}/co/coLaborSituation/save" method="post"
                   class="form-horizontal">
        <sys:message content="${message}"/>
        <form:hidden path="id" value="${comain.id}"/>
        <form:hidden path="coId"/>
        <h2 class="table-title"><input type="text" value="${countryName}" readonly/>无劳动能力或主要劳动力长期外出务工贫困户情况表
        </h2>

        <h3 class="table-subtitle">

                <%--<span>填报单位：<input type="text" value="平桂" readonly/>县（市丶区）公共服务专责小组（盖章）</span>--%>
						<span>
							<%--<div class="control-group" style="float: left">--%>
                                <label class="control-label" style="height: 40px;line-height: 36px;">填报单位 <font color="red">*</font>:</label>

                                <div class="controls">
                                    <sys:treeselect id="area" name="area.id" value="${comain.area.id}"
                                                    labelName="area.name" labelValue="${comain.area.name}"
                                                    title="上级行政区划" url="/sys/area/treeData" extId="${area.id}"
                                                    cssClass="" allowClear="true"/>
                                </div>
                            <%--</div>--%>
                        </span>
						<span>填报时间：<input name="fillDate" id="fillDate" type="text" maxlength="20"
                                          class="input-medium Wdate required"
                                          value="<fmt:formatDate value="${comain.fillDate}" pattern="yyyy-MM-dd"/>"
                                          onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/></span>
    </h3>
    <table>
        <tbody id="accpitem">
        <tr>
            <td rowspan="3">序号</td>
            <td rowspan="3" style="min-width: 120px!important;">自然村（屯）</td>
            <td colspan="2" rowspan="2">无劳动能力或主要劳动力长期外出务工的家庭</td>
            <td colspan="4">其中</td>
            <td rowspan="3">备注</td>
            <td style="text-align: center;cursor: pointer;width: 132px;" class="add-tr-btn" rowspan="3">
                添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
        </tr>
        <tr>
            <td>无劳动能力户</td>
            <td colspan="3">主要劳动力长期外出务工户</td>
        </tr>
        <tr>
            <td>户数</td>
            <td>家庭人口数</td>
            <td>是否属于此类型的</td>
            <td>是否属于此类型</td>
            <td>务工人数</td>
            <td style="min-width: 200px!important;">务工地</td>
        </tr>
        <c:if test="${comain.coLaborSituationList != null && !comain.coLaborSituationList.isEmpty()}">
        <c:forEach items="${comain.coLaborSituationList}" var="coLaborSituation" varStatus="status">
        <tr>
            <td class="bg-white">
                <input type="hidden" name="coLaborSituationList[${status.index}].id"
                       value="${coLaborSituation.id}" class="id"/>
                <input type="hidden" name="coLaborSituationList[${status.index}].mainId" class="mainId"
                       value="${coLaborSituation.mainId}"/>
                <form:input path="coLaborSituationList[${status.index}].idx" htmlEscape="false"
                            maxlength="255" class="idx input-xlarge "/>
            </td>
            <td class="bg-white">
                <form:input path="coLaborSituationList[${status.index}].natureId" htmlEscape="false"
                            maxlength="64" class="natureId input-xlarge"/>
            </td>
            <td class="bg-white">
                <form:input path="coLaborSituationList[${status.index}].housename" htmlEscape="false"
                            maxlength="64" class="housename input-xlarge"/>
            </td>
            <td class="bg-white">
                <form:input path="coLaborSituationList[${status.index}].familyNumber" htmlEscape="false"
                            maxlength="64" class="familyNumber input-xlarge int"/>
            </td>
            <td class="bg-white">
                <form:radiobuttons path="coLaborSituationList[${status.index}].isNoLabor"
                                   class="isNoLabor"
                                   items="${fns:getDictList('yes_no')}" itemLabel="label"
                                   itemValue="value"/>
            </td>
            <td class="bg-white">
                <form:radiobuttons path="coLaborSituationList[${status.index}].isLaborOut"
                                   class="isLaborOut"
                                   items="${fns:getDictList('yes_no')}" itemLabel="label"
                                   itemValue="value"/>
            </td>
                <%--<td class="bg-white">--%>
                <%--<form:input path="coLaborSituationList[${status.index}].isNoLabor" htmlEscape="false" maxlength="64" class="isNoLabor input-xlarge"/>--%>
                <%--</td>--%>
                <%--<td class="bg-white">--%>
                <%--<form:input path="coLaborSituationList[${status.index}].isLaborOut" htmlEscape="false" maxlength="64" class="isLaborOut input-xlarge"/>--%>
                <%--</td>--%>
            <td class="bg-white">
                <form:input path="coLaborSituationList[${status.index}].workNumber" htmlEscape="false"
                            maxlength="64" class="workNumber input-xlarge int"/>
            </td>
            <td class="bg-white">
                <form:input path="coLaborSituationList[${status.index}].workPlace" htmlEscape="false"
                            maxlength="64" class="workPlace input-xlarge"/>
            </td>
            <td class="bg-white">
                <form:input path="coLaborSituationList[${status.index}].remarks" htmlEscape="false"
                            maxlength="64" class="remarks input-xlarge "/>
            </td>


            <td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
            </c:forEach>
            </c:if>
        </tr>
        </tbody>
    </table>
    <div class="text-bottom">
        <span>审核人：</span>
        <span>填表人：</span>
        <span>联系电话：</span>
    </div>
    <div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>
    </form:form>
    </c:otherwise>
    </c:choose>
</div>
<script>
    var tr;
    function chooseMember(area) {
//			console.debug(member);
        tr.find(".natureId").val(area.name);
    }

    //弹出自然村屯选择窗口
    $(function () {
        $("#accpitem").delegate(".natureId", 'click', function () {
//				var cardId = $("#id").val();
            var countryId = '${countryId}';
            tr = $(this).parents("tr");
            var iWidth = 900;
            var iHeight = 500;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/co/coCountryYear/countryChoose?countryId=" + countryId, "选择地区", "width=" + iWidth +
            ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
            ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
            "status=no,alwaysRaised=yes,depended=yes");
        });
    });
    $(function () {
        $(".content-nav li").each(function () {
            $(this).click(function () {
                $(".header-rt").text($(this).text())
            })
        })
        $(".add-tr-btn").click(function () {
            var _len = $("#accpitem tr").length - 1;
            var trHtml = '<tr>' +
                    '<td class="bg-white">' +
                    '<input type="hidden" name="coLaborSituationList[' + _len + '].id"  class="id">' +
                    '<input type="hidden" name="coLaborSituationList[' + _len + '].mainId" class="mainId" >' +
                    '<input id="coLaborSituationList' + _len + '.idx" name="coLaborSituationList[' + _len + '].idx" class="idx input-mini required " type="text"  maxlength="10">' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<input id="coLaborSituationList' + _len + '.natureId" name="coLaborSituationList[' + _len + '].natureId" class="natureId" type="text" >' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<input id="coLaborSituationList' + _len + '.housename" name="coLaborSituationList[' + _len + '].housename" class="housename int" type="text" >' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<input id="coLaborSituationList' + _len + '.familyNumber" name="coLaborSituationList[' + _len + '].familyNumber" class="familyNumber int" type="text" >' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<span>' +
                    '<input id="coLaborSituationList' + _len + '.isNoLabor1" name="coLaborSituationList[' + _len + '].isNoLabor" class="isNoLabor" type="radio" value="1">' +
                    '<label for="coLaborSituationList' + _len + '.supportFlag1">是</label>' +
                    '</span>' +
                    '<span>' +
                    '<input id="coLaborSituationList' + _len + '.isNoLabor2" name="coLaborSituationList[' + _len + '].isNoLabor" class="isNoLabor" type="radio" value="0">' +
                    '<label for="coLaborSituationList' + _len + '.supportFlag2">否</label>' +
                    '</span>' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<span>' +
                    '<input id="coLaborSituationList' + _len + '.isLaborOut1" name="coLaborSituationList[' + _len + '].isLaborOut" class="isLaborOut" type="radio" value="1">' +
                    '<label for="coLaborSituationList' + _len + '.supportFlag1">是</label>' +
                    '</span>' +
                    '<span>' +
                    '<input id="coLaborSituationList' + _len + '.isLaborOut2" name="coLaborSituationList[' + _len + '].isLaborOut" class="isLaborOut" type="radio" value="0">' +
                    '<label for="coLaborSituationList' + _len + '.supportFlag2">否</label>' +
                    '</span>' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<input id="coLaborSituationList' + _len + '.workNumber" name="coLaborSituationList[' + _len + '].workNumber" class="workNumber int" type="text" >' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<input id="coLaborSituationList' + _len + '.workPlace" name="coLaborSituationList[' + _len + '].workPlace" class="workPlace int" type="text" >' +
                    '</td>' +
                    '<td class="bg-white">' +
                    '<input id="coLaborSituationList' + _len + '.remarks" name="coLaborSituationList[' + _len + '].remarks" class="remarks" type="text" >' +
                    '</td>' +

                    '<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';
            $(this).parents("tbody").append(trHtml);
            $("select").select2();
            rename();
        })
        $("#tab-15").delegate(".del-thistd-btn", "click", function () {
            $(this).parents("tr").remove();
            rename();
        });
        function rename() {
            var i = -3;
            $('#accpitem tr').each(function () {
//						console.debug("i = "+i);
                $(this).children('td').children('.id').attr('name', 'coLaborSituationList[' + i + '].id');
                $(this).children('td').children('.mainId').attr('name', 'coLaborSituationList[' + i + '].mainId');
                $(this).children('td').children('.idx').attr('name', 'coLaborSituationList[' + i + '].idx');
                $(this).children('td').children('.natureId').attr('name', 'coLaborSituationList[' + i + '].natureId');
                $(this).children('td').children('.housename').attr('name', 'coLaborSituationList[' + i + '].housename');
                $(this).children('td').children('.familyNumber').attr('name', 'coLaborSituationList[' + i + '].familyNumber');
                $(this).children('td').children('span').children('.isNoLabor').attr('name', 'coLaborSituationList[' + i + '].isNoLabor');
                $(this).children('td').children('span').children('.isLaborOut').attr('name', 'coLaborSituationList[' + i + '].isLaborOut');
                $(this).children('td').children('.workNumber').attr('name', 'coLaborSituationList[' + i + '].workNumber');
                $(this).children('td').children('.workPlace').attr('name', 'coLaborSituationList[' + i + '].workPlace');
                $(this).children('td').children('.remarks').attr('name', 'coLaborSituationList[' + i + '].remarks');
                i++;
            });
        };
    });
</script>
</div>
</body>
</html>
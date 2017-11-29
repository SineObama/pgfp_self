<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>移民搬迁房管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
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
        function chooseHolds(regCard){
            //农户id
            $(".houseId").val(regCard.houseId);
            //姓名或组织名称
            $(".houseHolderName").val(regCard.houseHolderName);
            //识别分数
            $(".sbScore").val(regCard.sbScore);
            $.ajax({
                type: 'POST',
                dataType: "JSON",
                data:{cardId:regCard.id},
                url:${fns:toJson(ctx)}+"/record/basePoorerFamilyMember/getMemberCount",
                success : function(memberCount){
                    $('.memberCount').val(memberCount);
//                    console.debug(memberCount);
                    if(memberCount > 0 ){
                        var buildArea = $('#buildArea').val();//建筑面积
                        var perCapitaArea = buildArea / memberCount;//人均面积
                        $('#perCapitaArea').val(perCapitaArea);
                        var totalPrice = $('#totalPrice').val();
                        $('#perCapitaPrice').val(totalPrice / memberCount);
                    } else {
                        $('#perCapitaArea').val("");
                        $('#perCapitaPrice').val("");
                    }
                }
            });
        }

        //弹出户窗口
        $(function () {
            $('#accpitem').delegate("#distributeFlag2" , 'click', function(){
//                console.debug("asdfasfasdf");
                $('.houseId').val('');
                $('.houseHolderName').val('');
            });
            $("#accpitem").delegate(".houseHolderName",'click',function(){
                var iWidth = 900;
                var iHeight = 500;
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                var win = window.open("${ctx}/record/basePoorerRegCard/maxYearByHouseId", "弹出窗口", "width=" + iWidth +
                ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                "status=no,alwaysRaised=yes,depended=yes");
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li>
        <a href="${ctx}/bf/bfPovertyAlleviationRoom/list?building.id=${bfPovertyAlleviationRoom.building.id}">
            移民搬迁房列表
        </a>
    </li>
    <li class="active"><a
            href="${ctx}/bf/bfPovertyAlleviationRoom/form?id=${bfPovertyAlleviationRoom.id}">移民搬迁房<shiro:hasPermission
            name="bf:bfPovertyAlleviationRoom:edit">${not empty bfPovertyAlleviationRoom.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="bf:bfPovertyAlleviationRoom:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>

<div class="content tabs f-clear">
    <div id="tab-15" class="content-detail">
        <form:form id="inputForm" modelAttribute="bfPovertyAlleviationRoom"
                   action="${ctx}/bf/bfPovertyAlleviationRoom/save" method="post" class="form-horizontal">
            <form:hidden path="id"/>
            <form:hidden path="building.id"/>
            <sys:message content="${message}"/>
            <table>
                <tbody id="accpitem">
                <tr>
                    <td>
                        楼层
                    </td>
                    <td class="bg-white">
                        <form:select path="floor" class="" style="min-width:160px !important;">
                        <form:option value="" label="     "/>
                        <form:options items="${fns:getDictList('room_floor')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                        </form:select>
                    </td>
                    <td>
                        单元编号
                    </td>
                    <td class="bg-white">
                        <form:input path="roomCode" htmlEscape="false" maxlength="64" class=""/>
                    </td>
                </tr>
                <tr>
                    <td>
                        建筑面积
                    </td>
                    <td class="bg-white">
                        <form:input path="buildArea" htmlEscape="false" maxlength="64" class="decimal"/>
                    </td>
                    <td>
                        套内面积
                    </td>
                    <td class="bg-white">
                        <form:input path="comprisingArea" htmlEscape="false" maxlength="64" class="decimal"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        总价款
                    </td>
                    <td class="bg-white">
                        <form:input path="totalPrice" htmlEscape="false" maxlength="64" class="decimal"/>
                    </td>
                    <td>
                        签订合同日期
                    </td>
                    <td class="bg-white">
                        <input  id = "signContratDate" name = "signContratDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                                value="<fmt:formatDate value='${bfPovertyAlleviationRoom.signContratDate}' pattern="yyyy-MM-dd"/>"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        住户
                    </td>
                    <td class="bg-white">
                        <form:hidden path="regCard.houseId" class="houseId"/>
                        <form:input path="regCard.houseHolderName" class="houseHolderName"/>
                    </td>
                    <td>
                        住户人口
                    </td>
                    <td class="bg-white">
                        <form:input path="memberCount" class="memberCount int"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        人均面积
                    </td>
                    <td class="bg-white">
                        <form:input path="perCapitaArea" class="perCapitaArea decimal"/>
                    </td>
                    <td>
                        家庭人均负担
                    </td>
                    <td class="bg-white">
                        <form:input path="perCapitaPrice" class="memberCount decimal"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        是否交钥匙
                    </td>
                    <td class="bg-white">
                        <form:radiobuttons path="isHandover" class="isHandover" items="${fns:getDictList('yes_no')}"
                                itemLabel="label" itemValue="value"/>
                    </td>
                    <td>
                        交房日期
                    </td>
                    <td class="bg-white">
                        <input  id = "handoverDate" name = "handoverDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                          value="<fmt:formatDate value='${bfPovertyAlleviationRoom.handoverDate}' pattern="yyyy-MM-dd"/>"
                          onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                          style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        是否达到入住基本标准
                    </td>
                    <td class="bg-white">
                        <%--<form:input path="isMortgage" class="perCapitaArea"/>--%>
                        <form:radiobuttons path="canMoveIn" class="canMoveIn"
                                           items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
                    </td>
                    <%--<td>--%>
                        <%--安置类型--%>
                    <%--</td>--%>
                    <%--<td class="bg-white">--%>
                        <%--&lt;%&ndash;<form:input path="canMoveIn" class="memberCount decimal"/>&ndash;%&gt;--%>
                            <%--<form:select path="placementType" class="placementType">--%>
                                <%--<option value="">--------</option>--%>
                                <%--<option value="1">集中安置</option>--%>
                                <%--<option value="2">分散安置</option>--%>
                            <%--</form:select>--%>
                    <%--</td>--%>
                    <td>
                        识别分
                    </td>
                    <td class="bg-white">
                        <form:input path="regCard.sbScore" class="sbScore"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        是否入住
                    </td>
                    <td class="bg-white">
                        <%--<form:input path="checkInFlag" class="perCapitaArea"/>--%>
                        <form:radiobuttons path="checkInFlag" class="perCapitaArea"
                                           items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
                    </td>
                    <td>
                        户主入住时间
                    </td>
                    <td class="bg-white">
                        <input  id = "checkInDate" name = "checkInDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
                                value="<fmt:formatDate value='${bfPovertyAlleviationRoom.checkInDate}' pattern="yyyy-MM-dd"/>"
                                onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                    </td>
                </tr>
                <tr>
                    <td>
                        是否按揭
                    </td>
                    <td class="bg-white">
                        <%--<form:input path="isMortgage" class="perCapitaArea"/>--%>
                        <form:radiobuttons path="isMortgage" class="perCapitaArea"
                                           items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value"/>
                    </td>
                    <td>
                        按揭款
                    </td>
                    <td class="bg-white">
                        <form:input path="mortgageRaised" class="memberCount decimal"/>
                    </td>
                </tr>
                <tr>

                    <td>
                        自筹款
                    </td>
                    <td class="bg-white">
                        <form:input path="selfRaised" class="perCapitaArea decimal"/>
                    </td>

                    <td>
                        房产证号
                    </td>
                    <td class="bg-white">
                        <form:input path="proOwnerCerNum" class="memberCount"/>
                    </td>

                </tr>
                </tbody>
            </table>
            <div class="form-actions">
            <shiro:hasPermission name="bf:bfPovertyAlleviationRoom:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
            <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </div>
</div>
</body>
</html>
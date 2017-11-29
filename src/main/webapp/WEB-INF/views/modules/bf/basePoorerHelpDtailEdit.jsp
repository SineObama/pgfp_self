<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>搬迁意愿修改</title>
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
    <li><a href="${ctx}/bf/basePoorerHelpDtail">贫困户搬迁意愿列表</a></li>
    <shiro:hasPermission name="record:basePoorerHelpDetail:edit"><li><a href="${ctx}/bf/basePoorerHelpDetail/edit">贫困户搬迁意愿修改</a></li></shiro:hasPermission>
</ul>

<div class="content tabs f-clear">
    <div id="tab-15" class="content-detail">
        <form:form id="inputForm" modelAttribute="basePoorerHelpDetail" action="${ctx}/record/basePoorerHelpDetail/saveV"
                   method="post" class="form-horizontal">
            <form:hidden path="id"/>
            <sys:message content="${message}"/>
            <table>
                <tbody id="accpitem">
                <tr>
                    <td class="bg-white" colspan="2">
                        <span style="float:right;">归属年度：
                         ${basePoorerHelpDetail.year}
                        </span>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>户主姓名</span></td>
                    <td class="sec-td bg-white">
                        <form:hidden path="cards.id" class="cardsId"/>
                        <form:input path="cards.houseHolderName" class="cardsHouseHolderName required"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">户口本号</td>
                    <td  class="sec-td">
                        <form:input path="cards.residenceBookletNumber" disabled="true" class="cardsResidenceBookletNumber"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">是否愿意搬迁</td>
                    <td  class="sec-td bg-white"   style="text-align: center">
                            ${fns:getDictLabel(basePoorerHelpDetail.relocateFlag,'yes_no' ,'')}
                            <%--<form:input path="relocateFlag" class="relocateFlag required" htmlEscape="false"/>--%>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">计划搬迁年份</td>
                    <td  class="sec-td bg-white" style="text-align: center">
                            ${basePoorerHelpDetail.relocateYear}
                            <%--<form:input path="relocateYear" class="relocateYear"/>--%>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">希望安置地点</td>
                    <td  class="sec-td bg-white" style="text-align: center">
                            ${fns:getDictLabel(basePoorerHelpDetail.settingPlace,'place_of_resettlement' ,'')}
                            <%--<form:input path="settingPlace" class="settingPlace required" htmlEscape="false"/>--%>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">希望安置房类型</td>
                    <td  class="sec-td bg-white" style="text-align: center">
                            ${fns:getDictLabel(basePoorerHelpDetail.housingTypes, 'housing_types','' )}
                            <%--<form:input path="housingTypes" class="housingTypes required" htmlEscape="false"/>--%>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">搬迁原因</td>
                    <td  class="sec-td bg-white" style="text-align: center">
                            ${fns:getDictLabel(basePoorerHelpDetail.relocateReason,'relocation_reasons','' )}
                            <%--<form:input path="housingTypes" class="housingTypes required" htmlEscape="false"/>--%>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="content-save">
                <shiro:hasPermission name="record:basePoorerHelpDetail:edit"><td>
                    <%--<input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>--%>
                </shiro:hasPermission>
                <input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </div>
</div>

<script >
    //修改选中人员信息
    function chooseMember(member){
        $('.cardsHouseHolderName').val(member.houseHolderName);
        $('.cardsId').val(member.id);
        $('.cardsResidenceBookletNumber').val(member.residenceBookletNumber);
    }
    //弹出户窗口
    $(function () {
        $("#accpitem").delegate(".cardsHouseHolderName",'click',function(){
//      tr = $(this).parents("tr");
            var iWidth = 900;
            var iHeight = 500;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/basePoorerRegCard/regCardChoose", "选择户主", "width=" + iWidth +
            ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
            ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
            "status=no,alwaysRaised=yes,depended=yes");
        });
    });

    <%--//弹出项目选择窗口--%>
    <%--$(function () {--%>
    <%--$("#accpitem").delegate(".projectTitle",'click',function(){--%>
    <%--//      tr = $(this).parents("tr");--%>
    <%--var iWidth = 900;--%>
    <%--var iHeight = 500;--%>
    <%--var iTop = (window.screen.availHeight - 30 - iHeight) / 2;--%>
    <%--var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;--%>
    <%--var win = window.open("${ctx}/cms/cmsProject/proChoose", "选择项目", "width=" + iWidth +--%>
    <%--", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +--%>
    <%--",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +--%>
    <%--"status=no,alwaysRaised=yes,depended=yes");--%>
    });
    });
</script>

</body>
</html>
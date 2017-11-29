<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>学前保教费免除登记修改</title>
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
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>

<ul class="nav nav-tabs">
    <li><a href="${ctx}/bt/bfPoorstudentsFeecollection/">学前保教费免除登记列表</a></li>
    <shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/edit?id=${feecollection.id}">学前保教费免除登记修改</a></li></shiro:hasPermission>
    <%--<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><li><a data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">个人补贴登记添加</a></li></shiro:hasPermission>--%>
</ul>

<div class="content tabs f-clear">
    <div id="tab-15" class="content-detail">

        <form:form id="inputForm" modelAttribute="feecollection" action="${ctx}/bt/bfPoorstudentsFeecollection/saveV"
                   method="post" class="form-horizontal">
            <form:hidden path="id"/>
            <sys:message content="${message}"/>
            <br/>
            <table>
                <tbody id="accpitem">
                <tr>
                    <td class="bg-white" colspan="2">
                        录入干部：${feecollection.createBy.name}
            <span style="float:right;">归属年度：
              <form:input path="years" disabled="true" style="background-color:#fff;width:100px;"/>
            </span>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>序号</span></td>
                    <td class="sec-td bg-white">
                        <form:input path="idx" maxlength="8" class="idx required int"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td"><span>姓名</span></td>
                    <td class="sec-td bg-white">
                        <form:hidden path="student.id" class="studentId"/>
                        <form:input path="student.name" class="studentName required"/>
                        <form:hidden path="type" value="2"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">性别</td>
                    <td  class="sec-td">
                        <form:input path="student.sex" disabled="true" class="studentSex"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">身份证号码</td>
                    <td  class="sec-td">
                        <form:input path="student.idNumber" disabled="true" class="studentIdNumber"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td" >入园日期</td>
                    <td  class="sec-td ">
                        <input name="studentHelpInfoEntranceDate" type="text" maxlength="20" class="studentHelpInfoEntranceDate input-medium Wdate  required"
                               value="<fmt:formatDate value="${feecollection.studentHelpInfo.entranceDate}" pattern="yyyy-MM-dd"/>"
                               disabled="true"/>
                            <%--<form:input path="studentHelpInfo.entranceDate" disabled="true" class="studentHelpInfoEntranceDate" />--%>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">家庭地址</td>
                    <td  class="sec-td">
                        <form:input path="card.address" disabled="true" class="cardAddress"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">建档立卡户主姓名</td>
                    <td  class="sec-td">
                        <form:input path="card.houseHolderName"  disabled="true" class="cardHouseHolderName"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">与户主关系</td>
                    <td  class="sec-td">
                        <form:input path="student.householderRelationship" disabled="true" class="studentHouseholderRelationship"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">幼儿园保教费（元/学期）</td>
                    <td  class="sec-td">
                        <form:input path="studentHelpInfo.tuition" disabled="true" class="studentHelpInfoTuition"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">自治区拨款（元）</td>
                    <td  class="sec-td bg-white">
                        <form:input path="municipatityAppropriation" maxlength="11"  class="bfMunicipatityAppropriation decimal required"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">市、县区拨款（元）</td>
                    <td  class="sec-td bg-white">
                        <form:input path="cityCountyAppropriation" maxlength="11" class="bfCityCountyAppropriation decimal required"/>
                    </td>
                </tr>
                <tr>
                    <td class="fir-td">是否为非本县户籍学生（是填1，否填0）</td>
                    <td  class="sec-td ">
                        <form:input path="studentHelpInfo.isLocalStudent" disabled="true" class="studentHelpInfoIsLocalStudent"/>
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="content-save">
                <shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit">
                    <input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
                </shiro:hasPermission>
                <input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
            </div>
        </form:form>
    </div>
</div>

<script >

    //  function chooseProject(project){
    //    $('.projectId').val(project.id);
    //    $('.projectTitle').val(project.title);
    //  }
    var years = ${feecollection.years};
    //修改选中人员信息
    function chooseMember(member){
        $('.studentName').val(member.name);
        $('.studentId').val(member.id);
        $('.studentIdNumber').val(member.idNumber);
    }
    //弹出户窗口
    $(function () {
        $("#accpitem").delegate(".studentName",'click',function(){
//      tr = $(this).parents("tr");
            var iWidth = 900;
            var iHeight = 500;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?selectMode=5&years="+years, "选择成员", "width=" + iWidth +
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
    <%--});--%>
    <%--});--%>

    $(function () {
        $("#accpitem").delegate(".subsidyType",'click',function(){
//			var cardId = $("#id").val();
            tr = $(this).parents("tr");
            var iWidth = 900;
            var iHeight = 500;
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
            var win = window.open("${ctx}/bf/bfSubsidyType/bfSubsidyTypeChoose", "选择资助项目", "width=" + iWidth +
            ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
            ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
            "status=no,alwaysRaised=yes,depended=yes");
        });
    });

    function chooseSubsidyType(member){
//		console.debug(member);
        $(".subsidyTypeId").val(member.id);
        $(".subsidyType").val(member.subsidyType);
    }
</script>

</body>
</html>
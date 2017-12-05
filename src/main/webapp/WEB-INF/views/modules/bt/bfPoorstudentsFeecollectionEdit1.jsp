<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>个人补贴修改</title>
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
  <li><a href="${ctx}/bt/bfPoorstudentsFeecollection/list1">个人补贴登记列表</a></li>
  <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
  <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
  <shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/edit1?id=${feecollection.id}">个人补贴登记修改</a></li></shiro:hasPermission>
  <%--<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit"><li><a data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">个人补贴登记添加</a></li></shiro:hasPermission>--%>
</ul>

<div class="content tabs f-clear">
  <div id="tab-15" class="content-detail">

    <form:form id="inputForm" modelAttribute="feecollection" action="${ctx}/bt/bfPoorstudentsFeecollection/saveV1"
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
          <td class="fir-td"><span>姓名</span></td>
          <td class="sec-td bg-white">
            <form:hidden path="student.id" class="studentId"/>
            <form:input path="student.name" class="studentName required"/>
            <form:hidden path="type" class="type" value="1"/>
          </td>
        </tr>
        <tr>
          <td class="fir-td">身份证号码</td>
          <td  class="sec-td">
            <form:input path="student.idNumber" disabled="true" class="studentIdNumber"/>
          </td>
        </tr>
        <tr>
          <td class="fir-td">资助项目</td>
          <td  class="sec-td bg-white">
            <%--<form:hidden path="cmsProject.id" class="projectId"/>--%>
            <%--<form:input path="cmsProject.title" class="projectTitle required" htmlEscape="false"/>--%>
            <form:hidden path="subsidyType.id" class="subsidyTypeId"/>
            <form:input path="subsidyType.subsidyType" class="subsidyType required" htmlEscape="false"/>
          </td>
        </tr>
        <tr>
          <td class="fir-td">资助金额（元）</td>
          <td  class="sec-td bg-white">
            <form:input path="capital" maxlength="11" class="capital decimal"/>
          </td>
        </tr>
        <tr>
          <td class="fir-td">资助时间</td>
          <td  class="sec-td bg-white">
            <input name="releaseTime" type="text" maxlength="20" class="releaseTime input-medium Wdate  required"
                   value="<fmt:formatDate value="${feecollection.releaseTime}" pattern="yyyy-MM-dd"/>"
            onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color: #FFF;"/>
          </td>
        </tr>
        <tr>
          <td class="fir-td">备注</td>
          <td  class="sec-td bg-white">
            <form:textarea path="remarks" class="remarks" cssStyle="width: 100%;height:50px; border: none;"/>
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
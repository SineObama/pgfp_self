<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>个人补贴登记管理</title>
  <meta name="decorator" content="default"/>
  <link rel="stylesheet" href="${ctxStatic}/pgfp/css/style.css"/>
  <script type="text/javascript">
    $(document).ready(function() {

      $("#select").click(function () {

        $("#inputForm").attr("action", "${ctx}/bt/bfPoorstudentsFeecollection/form1");
        //$("#inputForm").submit();
      });


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
<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>

<ul class="nav nav-tabs">
  <li><a href="${ctx}/bt/bfPoorstudentsFeecollection/list1">个人补贴登记列表</a></li>
  <%-- MemberId=${bfPoorstudentsFeecollection.student.id} --%>
  <li class="active"><a href="${ctx}/bt/bfPoorstudentsFeecollection/form1?office.id=${bfPoorstudentsFeecollection.office.id}&years=${bfPoorstudentsFeecollection.years}">个人补贴登记<shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit">${not empty bfPoorstudentsFeecollection.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bt:bfPoorstudentsFeecollection:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<div class="content tabs f-clear">
  <div id="tab-1" class="content-detail">
    <form:form id="select" modelAttribute="bfPoorstudentsFeecollection" action="${ctx}/bt/bfPoorstudentsFeecollection/form1" method="post" class="form-horizontal">
      <table style="border: 0px;">
        <tr style="border: 0px #FFFFFF; ">
          <td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">
            <div class="control-group" style="float: left">
              <label class="control-label">填报单位:</label>
              <div class="controls">
                <sys:treeselect id="office" name="office.id" value="${bfPoorstudentsFeecollection.office.id}" labelName="office.name" labelValue="${bfPoorstudentsFeecollection.office.name}"
                                title="填报单位" url="/sys/office/treeData" extId="${office.id}" cssClass="" allowClear="true" isAll="${bfPoorstudentsFeecollection.isAdminCadre }"/>

              </div>
            </div>
          </td>
          <td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">填报时间:</td>
          <td class="sec-td bg-white" style="border: 0px #FFFFFF;">
            <input name="years" id="years" type="text"  maxlength="20" class="input-medium Wdate required"
                   value="<fmt:formatDate value="${bfPoorstudentsFeecollection.yearDate}" pattern="yyyy"/>"
                   onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"  style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
          </td>
          <td class="sec-td bg-white" style="border: 0px #FFFFFF;">
            <input id="select" class="save-btn" style="margin-right:30px !important;" type="submit" value="查询"/>
          </td>
        </tr>
      </table>
    </form:form>
    <form:form id="inputForm" modelAttribute="collectionModel" action="${ctx}/bt/bfPoorstudentsFeecollection/save1" method="post" class="form-horizontal">
      <input type="hidden" id="sub-years" name="years" value="${bfPoorstudentsFeecollection.years}"/>
      <input type="hidden" id="sub-officeId" name="office.id" value="${bfPoorstudentsFeecollection.office.id}"/>
      <sys:message content="${message}"/>
      <table style="border: 0px;">
        <tbody id="accpitem">
        <tr>
          <td  width="80">序号</td>
          <td  width="100">姓名</td>
          <td  width="100">身份证号</td>
          <td  width="100">资助项目</td>
          <td  width="100">资金(元)</td>
          <td  width="100">发放时间</td>
          <td  width="100">备注</td>

          <!-- <td rowspan=2 style="text-align: center;">序号</td>
          <td rowspan=2 style="text-align: center;">学生姓名</td>
          <td rowspan=2 style="text-align: center;">性别</td>
          <td rowspan=2 style="text-align: center;">身份证号</td>
          <td rowspan=2 style="text-align: center;">入园时间</td>
          <td rowspan=2 style="text-align: center;">家庭住址</td>
          <td rowspan=2 style="text-align: center;">建档立卡户主姓名</td>
          <td rowspan=2 style="text-align: center;">与户主关系</td>
          <td rowspan=2 style="text-align: center;">幼儿园保教费（元/学期）</td>
          <td colspan=2 style="text-align: center;">财政补助（元）</td>
          <td rowspan=2 style="text-align: center;"> 是否为非县区户籍学生（是填1，否填0）</td> -->
          <td style="text-align: center;cursor: pointer;width: 132px;" class="add-tr-btn" >添加<span style="color: #fe0000;font-size: 16px;font-weight: bold;">+</span></td>
        </tr>
        <c:if test="${collectionModel.feeCollection!= null && !collectionModel.feeCollection.isEmpty()}">
          <c:forEach items="${collectionModel.feeCollection}" var="bfPoorstudentsFeecollection" varStatus="status">
            <tr class="bg-white">
                <%--序号 --%>
              <td>
                <input type="hidden" name="feeCollection[${status.index}].id" value="${bfPoorstudentsFeecollection.id}" class="id"/>
                <input type="hidden" name="feeCollection[${status.index}].basePoorerFamilyMemberId" class="basePoorerFamilyMemberId" value="${bfPoorstudentsFeecollection.basePoorerFamilyMemberId}"/>
                <form:input path="feeCollection[${status.index}].idx" htmlEscape="false" maxlength="200" class="idx input-xlarge "/>
              </td>
                <%--获取姓名 --%>
              <td>
                <form:hidden path="feeCollection[${status.index}].student.id" class="studentId"/>
                <form:input path="feeCollection[${status.index}].student.name" htmlEscape="false" maxlength="200" class="name input-xlarge  required"/>
              </td>
              <td style="background-color: #f5f5f5 !important;">
                <form:input path="feeCollection[${status.index}].student.idNumber" htmlEscape="false" maxlength="200" class="idNumber input-xlarge  " disabled="true"/>
              </td>
              <td>
                <form:hidden path="feeCollection[${status.index}].subsidyType.id" class="subTypeId"/>
                <form:input path="feeCollection[${status.index}].subsidyType.subsidyType" htmlEscape="false" maxlength="200" class="subsidyType input-xlarge required"/>
              </td>
              <td>
                <form:input path="feeCollection[${status.index}].capital" htmlEscape="false" maxlength="11" class="capital input-xlarge required decimal"/>
              </td>
              <td>
                <input name="feeCollection[${status.index}].releaseTime" type="text" readonly="readonly" maxlength="20" class="releaseTime input-medium Wdate  required"
                       value="<fmt:formatDate value="${collectionModel.feeCollection[status.index].releaseTime}" pattern="yyyy-MM-dd"/>"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" style="background-color:#fff !important;"/>
              </td>
              <td>
                <form:input path="feeCollection[${status.index}].remarks" htmlEscape="false" maxlength="200" class="remarks input-xlarge"/>
              </td>
              <td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td>
            </tr>
          </c:forEach>
        </c:if>
        </tbody>
      </table>
      <div class="content-save">
        <shiro:hasPermission name="bt:bfPoorstudentsFeecollection:edit">
          <input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
        </shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
          <%--<div class="content-save"><input type="submit" value="保 存" class="save-btn"></div>--%>
      </div>
    </form:form>
  </div>
</div>
<script>
  //保存前干的活
  //			$('.btnSubmit').click(function(){
  //				var officeId = $('#officeId').val();
  //				var year = $("#years").val();
  //				$('#sub-years').val(year);
  //				$('#sub-officeId').val(officeId);
  //				$('#inputForm').submit();
  //			});


  var tr;
  var years = ${bfPoorstudentsFeecollection.years};

  function chooseMember(member){
//				console.debug(member);
    tr.find(".studentId").val(member.id);
    tr.find(".name").val(member.name);
    tr.find(".idNumber").val(member.idNumber);
  }

  function chooseSubsidyType(member){
//				console.debug(member);
    tr.find(".subsidyTypeId").val(member.id);
    tr.find(".subsidyType").val(member.subsidyType);
  }

  //弹出个人窗口
  $(function () {
    $("#accpitem").delegate(".name",'click',function(){
//					var cardId = $("#id").val();
      tr = $(this).parents("tr");
      var iWidth = 900;
      var iHeight = 500;
      var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
      var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
      var win = window.open("${ctx}/record/basePoorerFamilyMember/familyMemberChoose?years=${bfPoorstudentsFeecollection.years}&selectMode=2", "选择个人", "width=" + iWidth +
      ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
      ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
      "status=no,alwaysRaised=yes,depended=yes");
    });
  });

  <%--//弹出资助项目窗口--%>
  <%--$(function () {--%>
  <%--$("#accpitem").delegate(".projectTitle",'click',function(){--%>
  <%--//					var cardId = $("#id").val();--%>
  <%--tr = $(this).parents("tr");--%>
  <%--var iWidth = 900;--%>
  <%--var iHeight = 500;--%>
  <%--var iTop = (window.screen.availHeight - 30 - iHeight) / 2;--%>
  <%--var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;--%>
  <%--var win = window.open("${ctx}/cms/cmsProject/proChoose", "选择资助项目", "width=" + iWidth +--%>
  <%--", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +--%>
  <%--",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +--%>
  <%--"status=no,alwaysRaised=yes,depended=yes");--%>
  <%--});--%>
  <%--});--%>


  $(function (){
    $(".add-tr-btn").click(function(){
      var _len=$("#accpitem tr").length - 1;
      var trHtml = '<tr>' +
              '<td class="bg-white">' +
              '<input type="hidden" name="feeCollection['+_len+'].id"  class="id">'+
              '<input id="feeCollection'+_len+'.idx" name="feeCollection['+_len+'].idx" class="idx input-mini required " type="text"  maxlength="10">'+
              '</td>' +
              '<td class="bg-white">' +
              '<input type="hidden" class="studentId" name="feeCollection['+_len+'].student.id"/>' +
              '<input id="feeCollection'+_len+'.name" name="feeCollection['+_len+'].student.name" class="name required" type="text" >'+
              '</td>' +
              '<td>' +
              '<input id="feeCollection'+_len+'.idNumber" name="feeCollection['+_len+'].student.idNumber" class="idNumber required" type="text" disabled="true">'+
              '</td>' +
              '<td class="bg-white">' +
//							'<input type="hidden" name="feeCollection['+_len+'].cmsProject.id" class="projectId"/>' +
//							'<input name="feeCollection['+_len+'].cmsProject.title" class="projectTitle required" type="text" >'+
              '<input type="hidden" name="feeCollection[' + _len + '].subsidyType.id" class="subTypeId">' +
              '<input id="feeCollection'+_len+'.subType.subsidyType" name="feeCollection[' + _len + '].subsidyType.subsidyType" type="text" class="subsidyType required">' +
              '</td>' +
              '<td class="bg-white">' +
              '<input id="feeCollection'+_len+'.capital" name="feeCollection['+_len+'].capital" maxlength="11" class="capital required decimal" type="text" >'+
              '</td>' +
              '<td class="bg-white">' +
              '<input id="feeCollection'+_len+'.releaseTime" name="feeCollection['+_len+'].releaseTime" type="text" readonly="readonly" maxlength="20" class="releaseTime input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="background-color:#fff !important;">'+
              '</td>' +
              '<td class="bg-white">' +
              '<input id="feeCollection'+_len+'.remarks" name="feeCollection['+_len+'].remarks" class="remarks" type="text" >'+
              '</td>' +
              '<td class="bg-white" style="text-align: center"><span class="del-thistd-btn">删除</span></td></tr>';
      $(this).parents("tbody").append(trHtml);
      rename();
    })
    $("#tab-1").delegate(".del-thistd-btn","click",function(){
      $(this).parents("tr").remove();
      rename();
    });
    function rename() {
      var i = -1;
      $('#accpitem tr').each(function () {
//						console.debug("i = "+i);
        $(this).children('td').children('.id').attr('name', 'feeCollection[' + i + '].id');
        $(this).children('td').children('.basePoorerFamilyMemberId').attr('name', 'feeCollection[' + i + '].basePoorerFamilyMemberId');
        $(this).children('td').children('.idx').attr('name', 'feeCollection[' + i + '].idx');
        $(this).children('td').children('.name').attr('name', 'feeCollection[' + i + '].student.name');
        $(this).children('td').children('.studentId').attr('name', 'feeCollection[' + i + '].student.id');
        $(this).children('td').children('.idNumber').attr('name', 'feeCollection[' + i + '].student.idNumber');
        $(this).children('td').children('.subTypeId').attr('name', 'feeCollection[' + i + '].subsidyType.id');
        $(this).children('td').children('.subsidyType').attr('name', 'feeCollection[' + i + '].subsidyType.subsidyType');
        $(this).children('td').children('.capital').attr('name', 'feeCollection[' + i + '].capital');
        $(this).children('td').children('.releaseTime').attr('name', 'feeCollection[' + i + '].releaseTime');
        $(this).children('td').children('.remarks').attr('name', 'feeCollection[' + i + '].remarks');
        i++;
      });
    };
  });
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
    tr.find(".subTypeId").val(member.id);
    tr.find(".subsidyType").val(member.subsidyType);
  }
  //			function chooseProject(project){
  //				tr.find('.projectId').val(project.id);
  //				tr.find('.projectTitle').val(project.title);
  //			}
</script>
</body>
</html>
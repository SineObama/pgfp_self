<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>选择户</title>
  <meta name="decorator" content="default"/>
  <script type="text/javascript">
    $(document).ready(function() {
        var data = ${fns:toJson(page.list)}
//      $("select").select2();
      $(".choose").click(function(){
        var id = $(this).attr("id") ;
          for(var i= 0 , n = data.length;i<n;i++){
              var regCard = data[i];
              if(id == regCard.id){
                  window.opener.chooseHolds(regCard);
                  window.close();
              }
          }
      });
    });
    function page(n,s){
      $("#pageNo").val(n);
      $("#pageSize").val(s);
      $("#searchForm").submit();
      return false;
    }
  </script>
</head>
<body>
<form:form id="searchForm" modelAttribute="regCard" action="${ctx}/record/basePoorerRegCard/maxYearByHouseId" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <ul class="ul-form">
    <li><label>农户姓名：</label>
      <%-- <form:hidden path="id"/> --%>
      <form:input path="houseHolderName" htmlEscape="false" maxlength="200" class="input-medium"/>
    </li>
    <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
    <li class="clearfix"></li>
  </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
  <thead>
  <tr>
    <th>农户姓名</th>
      <th>归属年度</th>
    <th>户口本号</th>
    <th>一折通账号</th>
    <th>开户银行</th>
    <th>家庭住址</th>
    <th>选择</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${page.list}" var="member" varStatus="status">
    <tr>
      <td>
        <a class="choose" id="${member.id}">${member.houseHolderName}</a>
      </td>
        <td>
            ${member.years}
        </td>
      <td>
          ${member.residenceBookletNumber}
      </td>
      <td>
          ${member.bankAccount}
      </td>
      <td>
          ${member.bankName}
      </td>
      <td>
          ${member.address}
      </td>
      <td>
        <a class="choose" id="${member.id}">选择</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>

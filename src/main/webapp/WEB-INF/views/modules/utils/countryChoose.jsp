<%--
  Created by IntelliJ IDEA.
  User: panda
  Date: 2017/11/7
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>选择自然村屯名</title>
  <meta name="decorator" content="default"/>
  <script type="text/javascript">
    $(document).ready(function() {
      var data = ${fns:toJson(page.list)};
//      $("select").select2();
      $(".choose").click(function(){
        var id = $(this).attr("id") ;
        for(var i= 0,len=data.length;i<len ;i++ ){
          var member = data[i];
          if(id == member.id){
            window.opener.chooseMember(member);
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
<form:form id="searchForm" modelAttribute="area" action="${ctx}/co/coCountryYear/countryChoose" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <ul class="ul-form">
      <%--<li><label>单位：</label>--%>
      <%--<form:input path="office.name" htmlEscape="false" maxlength="200" class="input-medium"/>--%>
      <%--</li>--%>
    <li><label>村名：</label>
      <form:hidden path="parent.id" htmlEscape="false" maxlength="200" class="input-medium"/>
      <form:input path="name" htmlEscape="false" maxlength="200" class="input-medium"/>
    </li>
    <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
    <li class="clearfix"></li>
  </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
  <thead>
  <tr>
    <th>村名</th>
    <th>选择</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${page.list}" var="country" varStatus="status">
    <tr>
      <td>
        <a class="choose" id="${country.id}">${country.name}</a>
      </td>
      <td>
        <a class="choose" id="${country.id}">选择</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>



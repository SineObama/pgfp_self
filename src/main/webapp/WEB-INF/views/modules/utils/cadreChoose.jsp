<%--
  Created by IntelliJ IDEA.
  User: change
  Date: 2017/3/30
  Time: 13:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>关联干部</title>
  <meta name="decorator" content="default"/>
  <script type="text/javascript">
    $(document).ready(function() {
      var data = ${fns:toJson(page.list)};
      $(".choose").click(function(){
        var id = $(this).attr("id") ;
        for(var i = 0,len = data.length; i<len ; i++){
          var cadre = data[i];
          if(id == cadre.id){
            window.opener.choose(cadre);
            window.close();
          }
        }
        <%--$.ajax({--%>
          <%--type:"POST",--%>
          <%--url:"${ctx}/record/workForceCadre/edit?id="+id,--%>
          <%--date:"JSON",--%>
          <%--success:function(cadre) {--%>
            <%--window.opener.choose(cadre);--%>
            <%--window.close();--%>
          <%--}--%>
        <%--});--%>
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
<form:form id="searchForm" modelAttribute="workForceCadre" action="${ctx}/record/workForceCadre/cadreChoose" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <ul class="ul-form">
    <li><label>单位：</label>
      <form:input path="office.name" htmlEscape="false" maxlength="200" class="input-medium"/>
    </li>
    <li><label>姓名：</label>
      <form:input path="b921Name" htmlEscape="false" maxlength="200" class="input-medium"/>
    </li>
    <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
    <li class="clearfix"></li>
  </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
  <thead>
  <tr>
    <th>姓名</th>
    <th>单位</th>
    <th>职务</th>
    <th>联系电话</th>
    <th>开始时间</th>
    <th>结束时间</th>
    <th>选择</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${page.list}" var="workForceCadre" varStatus="status">
    <tr>
      <td>
        <a class="choose" id="${workForceCadre.id}">${workForceCadre.b921Name}</a>
      </td>
      <td>
        ${workForceCadre.office.name}
      </td>
      <td>
        ${workForceCadre.b923Position}
      </td>
      <td>
        ${workForceCadre.b925Phone}
      </td>
      <td>
        <fmt:formatDate value="${workForceCadre.beginResidentDate}" pattern="yyyy-MM-dd"/>
      </td>
      <td>
        <fmt:formatDate value="${workForceCadre.endResidentDate}" pattern="yyyy-MM-dd"/>
      </td>
      <td>
        <a class="choose" id="${workForceCadre.id}">选择</a>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>

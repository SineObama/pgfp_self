<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/4/5
  Time: 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>选择家庭成员</title>
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
<form:form id="searchForm" modelAttribute="familyMember" action="${ctx}/record/basePoorerFamilyMember/familyMemberChoose" method="post" class="breadcrumb form-search">
  <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
  <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
  <ul class="ul-form">
    <%--<li><label>单位：</label>--%>
      <%--<form:input path="office.name" htmlEscape="false" maxlength="200" class="input-medium"/>--%>
    <%--</li>--%>
    <li>
      <label>查询方式</label>
      <select name="selectMode">
        <c:if test="${familyMember.poorerRegCardId != null and familyMember.poorerRegCardId ne ''}">
          <option value="0">查询本户所有成员</option>
          <option value="1">只查本户户主</option>
          <option value="2">只查本户学生</option>
        </c:if>
        <c:if test="${familyMember.poorerRegCardId == null or familyMember.poorerRegCardId eq ''}">
          <option value="3">查询所有户主</option>
          <option value="4">查询所有学生</option>
          <option value="5">查询所有人员</option>
        </c:if>
      </select>
    </li>
    <li><label>姓名：</label>
      <form:hidden path="poorerRegCardId"/>
      <form:hidden path="years"/>
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
    <th>姓名</th>
    <th>身份证</th>
    <th>性别</th>
    <th>与户主关系</th>
    <th>民族</th>
    <th>文化程度</th>
    <th>在校生情况</th>
    <th>选择</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach items="${page.list}" var="member" varStatus="status">
    <tr>
      <td>
        <a class="choose" id="${member.id}">${member.name}</a>
      </td>
      <td>
        ${member.idNumber}
      </td>
      <td>
          ${fns:getDictLabel(member.sex , 'sex' ,'' )}
      </td>
      <td>
          ${fns:getDictLabel(member.householderRelationship, 'relationship_with_householder', '')}
      </td>
      <td>
          ${member.nation}
      </td>
      <td>
          ${fns:getDictLabel(member.educationalLevel, 'degree_of_education', '')}
      </td>
      <td>
          ${fns:getDictLabel(member.studentStatus, 'students_situation', '')}
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

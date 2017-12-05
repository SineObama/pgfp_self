<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fns" uri="http://java.sun.com/jsp/jstl/functionss" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/11/13
  Time: 14:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>选择地区</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            var type = ${type};
            var data = ${fns:toJson(areaList)};
//      $("select").select2();
            $(".choose").click(function(){
                var id = $(this).attr("id") ;
                for(var i= 0,len=data.length;i<len ;i++ ){
                    var member = data[i];
                    if(id == member.id){
                        window.opener.chooseMember(member,type);
                        window.close();
                    }
                }
            });
        });
    </script>
</head>
<body>
<div>
    <h3 style="text-align: center">请选择地区</h3>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th>地区</th>
            <th>选择</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${areaList}" var="area" varStatus="status">
            <tr>
                <td>
                    <a class="choose" id="${area.id}">${area.name}</a>
                </td>
                <td>
                    <a class="choose" id="${area.id}">选择</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>




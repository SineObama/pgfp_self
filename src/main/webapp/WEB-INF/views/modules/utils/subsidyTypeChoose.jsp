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
    <title>选择资助项目</title>
  <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treetable.jsp" %>
  <script type="text/javascript">
    $(document).ready(function() {
        var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var data = ${fns:toJson(list)}, ids = [], rootIds = [];
        for (var i=0; i<data.length; i++){
            ids.push(data[i].id);
        }
        ids = ',' + ids.join(',') + ',';
        for (var i=0; i<data.length; i++){
            if (ids.indexOf(','+data[i].parentId+',') == -1){
                if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
                    rootIds.push(data[i].parentId);
                }
            }
        }
        for (var i=0; i<rootIds.length; i++){
            addRow("#treeTableList", tpl, data, rootIds[i], true);
        }
        $("#treeTable").treeTable({expandLevel : 5});



      $(".choose").click(function(){
        var id = $(this).parents("tr").attr("id") ;
//        console.debug("id : "+id);
          for( var i = 0 ; i<data.length ; i++){
              var member = data[i];
              if(data[i].id == id){
//                  console.debug(data[i]);
                  window.opener.chooseSubsidyType(member);
                  window.close();
              }
          }
      });
    });


    function addRow(list, tpl, data, pid, root){
        for (var i=0; i<data.length; i++){
            var row = data[i];
            if ((${fns:jsGetVal('row.parentId')}) == pid){
                $(list).append(Mustache.render(tpl, {
                    dict: {
                        blank123:0}, pid: (root?0:pid), row: row
                }));
                addRow(list, tpl, data, row.id);
            }
        }
    }
  </script>
</head>
<body>
<sys:message content="${message}"/>

<table id="treeTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>补贴名称</th>
        <th>责任部门</th>
        <th>备注</th>
        <shiro:hasPermission name="bf:bfSubsidyType:edit"><th>操作</th></shiro:hasPermission>
    </tr>
    </thead>
    <tbody id="treeTableList"></tbody>
</table>
<script type="text/template" id="treeTableTpl">
    <tr id="{{row.id}}"  pId="{{pid}}">
        <td class="">
            <a href="" class="choose"> {{row.code}}&nbsp;&nbsp;&nbsp;&nbsp;{{row.subsidyType}}</a>
        </a>
        </td>
        <td>
            {{row.office.name}}
        </td>
        <td>
            {{row.remarks}}
        </td>
        <td>
            <a class="choose">选择</a>
        </td>
    </tr>
</script>
<div class="pagination">${page}</div>
</body>
</html>

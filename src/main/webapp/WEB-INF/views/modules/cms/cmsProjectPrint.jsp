<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>项目档案管理</title>
  <meta name="decorator" content="default"/>
  <script type="text/javascript">
    $(document).ready(function() {
//        window.print();
      $("#btnMenu").css("display","none");
      $("#proPrint").click(function(){
        window.print();
      });
      });
  </script>
  <style type="text/css">
    .proTable{
      width: 90%;
      font-family: "微软雅黑", "宋体";
      font-size: 14px;
    }
    .proTable .proTitle{
      font-size: 28px ;
      text-align: center;
      height: 50px;
      /*background-color: #cccccc;*/

    }
    .proTable .proShow{
      font-size:20px;
      text-align: center;
    }
    .proTable th {
      width: 15%;
      text-align: right;
      margin-right: 10px;
    }
    .proTable td{
      width: 30%;
    }
  </style>


</head>
<body>
<div style="margin-left: 10px;margin-top: 10px;">
    <input type="button" id="proPrint" class="btn btn-primary" value=" 打印扶贫项目信息 "/>
</div>
 <br/>
<div style="margin-left: 10%">
  <table class="proTable table table-bordered ">
    <tbody>
    <tr>
      <td class="proTitle" colspan="4">${cmsProject.title}</td>
    </tr>
    <tr>
      <th>项目类型</th>
      <td>${fns:getDictLabel(cmsProject.type, 'project_type', '')}</td>
      <th>建设地址</th>
      <td>${cmsProject.address}</td>
    </tr>
    <tr>
      <th>负责单位</th>
      <td><c:if test="${cmsProject ne null && cmsProject.office ne null }">${cmsProject.office.name}</c:if></td>
      <th>投资估算</th>
      <td>${cmsProject.amount}&nbsp;元</td>
    </tr>
    <tr>
      <th>计划建设时间</th>
      <td><fmt:formatDate value="${cmsProject.scheduleTime}" pattern="yyyy年MM月dd日"/> </td>
      <th>开工时间</th>
      <td><fmt:formatDate value="${cmsProject.startTime}" pattern="yyyy年MM月dd日"/> </td>
    </tr>
    <tr>
      <th>建设内容</th>
      <td colspan="3">${cmsProject.content}</td>
    </tr>
    <tr>
      <th>承建单位</th>
      <td colspan="3">${cmsProject.constructionUnit}</td>
    </tr>
    <tr>
      <th>完成状态</th>
      <td>${fns:getDictLabel(cmsProject.finishedState,'finishedState' ,'' )}</td>
      <th>验收结果</th>
      <td>${fns:getDictLabel(cmsProject.checkFlag,'checkFlag' , '')}</td>
    </tr>
    <tr>
    <tr>
      <td class="proShow" colspan="4">工程形象和照片展示</td>
    </tr>
    <tr>
      <td colspan="4">
        <div id="articleContent">${fns:unescapeHtml(cmsProject.articleData.content)}</div>
      </td>
    </tr>
    </tbody>
  </table>
</div>
</body>
</html>
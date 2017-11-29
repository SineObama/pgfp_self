<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
  <title>贫困户惠农补贴管理</title>
  <meta name="decorator" content="default"/>
  <script type="text/javascript">
    $(document).ready(function() {
      $('#btnExport').click(function(){
        top.$.jBox.confirm("确认要导出数据吗？", "系统提示", function (v, h, f) {
//					console.debug("1"+v);
          if (v == "ok") {
           $("#searchForm").attr("action", "${ctx}/bf/bfPoorHouseholdsSubsidy/exportBfSub");
            $("#searchForm").submit();
          }
        });
     });
      $('#btnSubmit').click(function () {
        $("#searchForm").attr("action", "${ctx}/bf/bfPoorHouseholdsSubsidy/exportBfSub");
        page( 1 ,30);
      });

//      $("#btnExport").click(function(){
//        $.jBox($("#emportBox").html(), {title:"导出数据", buttons:{"关闭":true},
//          bottomText:""});
//      });
    });
    function page(n,s){
      $("#pageNo").val(n);
      $("#pageSize").val(s);
      $("#searchForm").submit();
      return false;
    }
  </script>
    <style>
        .btns{
            display: inline-block;
            float: none!important;
        }
    </style>
</head>
<body>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
<%--<div id="emportBox" class="hide">--%>
    <%--<form id="importForm" action="${ctx}/bf/bfPoorHouseholdsSubsidy/exportBfSub" method="post" enctype="multipart/form-data"--%>
          <%--class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导出，请稍等...');"><br/>--%>
        <%--<div class="control-group" style="margin-bottom: 5px;">--%>
            <%--<label class="control-label" style="width: 55px;">年份:</label>--%>
            <%--<input style="width: 60px;margin-left: -11px;" name="year" id="year" type="text" maxlength="20" class="input-medium Wdate required valid" required onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" data-original-title="" title="">--%>
        <%--</div>　　--%>
        <%--<input id="btnImportSubmit" class="btn btn-primary" type="button" onclick="importMethod()" value="   导    出   "/>--%>
    <%--</form>--%>
<%--</div>--%>
<form:form id="searchForm" modelAttribute="bfPoorHouseholdsSubsidy" action="${ctx}/bf/bfPoorHouseholdsSubsidy/exportBfSub?year=2017" method="post" class="breadcrumb form-search">
  <ul class="ul-form">
    <%--<li><label>姓名：</label>--%>
      <%--<input type="hidden" name="type" value="1" />--%>
      <%--<form:input path="regCard.houseHolderName" htmlEscape="false" maxlength="512" class="input-medium"/>--%>
    <%--</li>--%>

    <%--<li><label>年度：</label>--%>
        <%--&lt;%&ndash;<form:input path="years" htmlEscape="false" maxlength="512" class="input-medium"/>&ndash;%&gt;--%>
      <%--<input name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"--%>
             <%--value="${bfPoorHouseholdsSubsidy.years}"--%>
             <%--onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"--%>
             <%--style="background-color: #FFFFFF;border:1px solid #ccc;"/>--%>

    <%--</li>--%>
        <select id="type" name="type">
            <option value="1">1.人社局-建档立卡贫困户惠农补贴统计表</option>
            <option value="2">2.残联-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="3">3.建设局-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="4">4.教育局-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="5">5.林业局-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="6">6.移民局-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="7">7.农机局-扶贫惠农补贴统计表</option>
            <option value="8">8.平桂区建档立卡贫困户惠农补贴统计表（农村低保）</option>
            <option value="9">9.鹅塘财政所-建档立卡贫困户粮食直补补贴统计表</option>
            <option value="10">10.黄田财政所-直补</option>
            <option value="11">11.沙田财政所粮食直补-建档立卡贫困户惠农补贴统计表</option>
            <option value="12">12.水口财政所-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="13">13.羊头镇扶贫建档立卡贫困户惠农补贴统计表（直补订单）</option>
            <option value="14">14.平桂区-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="15">15.大平乡-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="16">16.公会镇-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="17">17.望高镇-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="18">18.西湾街道办-扶贫建档立卡贫困户惠农补贴统计表</option>
            <option value="19">19.平桂区建档立卡贫困户学生资助情况汇总表</option>
            <option value="20">20.2016年春季学期家庭经济困难寄宿生生活费补助统计表</option>
            <option value="21">21.空表2016年培训就业信息表</option>
            <option value="22">22.建设局危房改造模板</option>
            <option value="23">23.平桂区参加扶贫移民职业技能培训合格人员名单表</option>
            <option value="24">24.羊头镇学生贫困基本信息样表</option>
            <option value="25">25.广西学前教育免除保教费汇总表</option>
            <option value="26">26.广西普通高中免除学杂费汇总表</option>
        </select>
        <div class="control-group" style="margin-bottom: 5px;display: inline-block">
            <label class="control-label" style="width: 55px;margin-right: 10px;text-align: right">年份:</label>
            <input style="width: 60px;margin-left: -11px;" name="year" id="year" value="2017" type="text" maxlength="20" class="input-medium Wdate required valid " required onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" data-original-title="" title="">
        </div>
    <li class="btns"><input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>　
    <li class="clearfix"></li>
  </ul>
</form:form>
<%--<script>--%>
    <%--function importMethod() {--%>
        <%--var id = $(".select2-container").select2("data")["id"];--%>
        <%--var year = $dp.cal.date.y;--%>
        <%--&lt;%&ndash;$.ajax({&ndash;%&gt;--%>
            <%--&lt;%&ndash;url:"${ctx}/bf/bfPoorHouseholdsSubsidy/exportBfSub",&ndash;%&gt;--%>
            <%--&lt;%&ndash;type: "post",&ndash;%&gt;--%>
            <%--&lt;%&ndash;dataType: "json",&ndash;%&gt;--%>
            <%--&lt;%&ndash;data:{&ndash;%&gt;--%>
                <%--&lt;%&ndash;type: id,&ndash;%&gt;--%>
                <%--&lt;%&ndash;year: year&ndash;%&gt;--%>
            <%--&lt;%&ndash;},&ndash;%&gt;--%>
            <%--&lt;%&ndash;success: function(){&ndash;%&gt;--%>

            <%--&lt;%&ndash;}&ndash;%&gt;--%>
        <%--&lt;%&ndash;})&ndash;%&gt;--%>
    <%--}--%>
<%--</script>--%>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>贫困户建档立卡表管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery-validate.bootstrap-tooltip.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnExport").click(function () {
                var cards = $(document).find("input[type=checkbox]:checked");
                var cardId = "(";
                if(cards.length <= 0 ){
                    top.$.jBox.tip("至少选择一条记录！", "warning");
                } else {
                    cards.each(function(){
                        if($(this).attr("name") == "QRCode"){
                            cardId = cardId+"\'"+$(this).attr("value")+"\',";//这里找的其实是houseId拼接
                        }
                    });
                    cardId = cardId + "\'\')";

                    $("#searchForm").attr("action", "${ctx}/record/basePoorerRegCard/export");
                    var input = $("#searchForm").find("#cardId");
                    input.val(cardId);
                    $("#searchForm").submit();
                }
            });
            $('#btnSubmit').click(function () {
                $("#searchForm").attr("action", "${ctx}/record/basePoorerRegCard/");
                page( 1 ,30);
            });
            $("#btnImport").click(function(){
                $.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},
                    bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
            });
            $("#QRCode").click(function(){
                var cardId = "";
                $(document).find("input[type=checkbox]:checked").each(function(){
                    if($(this).attr("name") == "QRCode"){
                        cardId = cardId+$(this).attr("id")+",";
                    }
                });
                if(cardId.length <= 0 ){
                    top.$.jBox.tip("至少选择一条记录！", "warning");
                } else {
                    $("#searchForm").attr("action", "${ctx}/record/basePoorerRegCard/QRCode");
                    var input = $("#searchForm").find("#cardId");
                    input.val(cardId);
                    $("#searchForm").submit();
                }
            });

        });

        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>

</head>
<body>

<div id="importBox" class="hide">
    <form id="importForm" action="${ctx}/record/basePoorerRegCard/import2" method="post" enctype="multipart/form-data"
          class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
        <input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　
        　
        <input id="years" name="years" type="text" readonly="readonly" maxlength="20"
               class="input-medium Wdate required"
               onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});"
               style="width: 120px;background-color: #FFFFFF;"/>

        <input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
    </form>
</div>

<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/record/basePoorerRegCard/">贫困户建档立卡表列表</a></li>
    <shiro:hasPermission name="record:basePoorerRegCard:edit">
        <li><a href="${ctx}/record/basePoorerRegCard/form">贫困户建档立卡表添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="basePoorerRegCard" action="${ctx}/record/basePoorerRegCard/" method="post"
           class="breadcrumb form-search">
    <ul class="ul-form">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <input id="cardId" name="cardId" type="hidden" value=""/>
        <li>
            <label class="control-label">村名:</label>
            <sys:treeselect id="country" name="country.id" value="${basePoorerRegCard.country.id}"
                            labelName="country.name" labelValue="${basePoorerRegCard.country.name}"
                            title="村（屯）" url="/sys/area/treeData" extId="${country.id}" cssClass=""
                            allowClear="true"/>
        </li>
        <li>
            <label class="control-label">户主姓名:</label>
            <form:input path="houseHolderName"/>
        </li>
            </div>
            </div>

        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="btns">
        <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
        </li><li class="btns">
        <input id="btnImport" class="btn btn-primary" type="button" value="导入"/>
        </li>
        <li class="btns">
            <input id="QRCode" class="btn btn-primary" type="button" value="生成二维码"/>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th></th>
        <th>家庭住址</th>
        <th>户主姓名</th>
        <th>年度数据</th>
        <shiro:hasPermission name="record:basePoorerRegCard:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="basePoorerRegCard" varStatus="status">
        <tr>
            <td>
                <input type="checkbox" name="QRCode" id="${basePoorerRegCard.id}" value="${basePoorerRegCard.houseId}"/>
            </td>
            <td>
                <%--<input type="hidden" name="id" class="id" value=""/>--%>
                <input type="hidden" value="${basePoorerRegCard.id}" class="regCardId" id="${basePoorerRegCard.id}"/>
                    ${basePoorerRegCard.address}
                <input type="hidden" class="houseId" value="${basePoorerRegCard.houseId}"/>
            </td>
            <td>
                    ${basePoorerRegCard.houseHolderName}
            </td>
            <td>
                <c:forEach var="year" items="${basePoorerRegCard.yearsList}" varStatus="status" >
                        <a href="${ctx}/record/basePoorerRegCard/form?houseId=${basePoorerRegCard.houseId}&years=${year}">
                            &nbsp;${year}&nbsp;
                        </a>,
                    <%--四条记录一行--%>
                    <c:if test="${(status.index+1) % 3 ==0}">
                        <br/>
                    </c:if>

                </c:forEach>
            </td>
            <td>&nbsp;&nbsp;
            <shiro:hasPermission name="record:basePoorerRegCard:edit">

                    <a  data-toggle="modal" data-target="#myModal" id="addNewRecord" class="addNewRecord">添加新年度记录</a>&nbsp;&nbsp;
                    <a href="${ctx}/record/basePoorerRegCard/delete?id=${basePoorerRegCard.id}&years=${basePoorerRegCard.years}"
                       onclick="return confirmx('确认要删除该贫困户建档立卡表吗？', this.href)">删除</a>&nbsp;&nbsp;

            </shiro:hasPermission>
            <shiro:hasPermission name="record:helpContactPerRecord:edit">
                    <a href="${ctx}/record/helpContactPerRecord/form?regCardId=${basePoorerRegCard.id}">帮扶成效记录登记</a>&nbsp;&nbsp;
            </shiro:hasPermission>
            <%--<shiro:hasPermission name="bf:bfHelpRecord:edit">--%>
                <%--<a href="${ctx}/bf/bfHelpRecord/form?regCardId=${basePoorerRegCard.id}">帮扶记录登记</a>--%>
            <%--</shiro:hasPermission>--%>
            <shiro:hasPermission name="bf:bfHelpIncomePlan:edit">
                <a href="${ctx}/bf/bfHelpIncomePlan/form?card.id=${basePoorerRegCard.id}">帮扶计划填报</a>&nbsp;&nbsp;
            </shiro:hasPermission>
                <a href="" class="pdf">预览帮扶手册</a>&nbsp;&nbsp;
                <%--<a href="${ctx}/bf/manual/manual2017?regCardId=${basePoorerRegCard.id}&cardId=b96311557d904c60ae86ef09c80f55d8&recordIncomeId=b6c5cdf8c382488b90753a3670a1e3f9" >生成帮扶手册</a>&nbsp;&nbsp;--%>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
<%-- 模态框（Modal） --%>
<div class="modal fade"  style="display: none;width:400px;" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">添加户年度信息</h4>

            </div>
            <form:form action="${ctx}/record/basePoorerRegCard/saveNewYear" id="editSave" modelAttribute="basePoorerRegCard" method="post" >
                <input type="hidden" id="oldId" name="id"/>
                <div style="margin-top: 13px;text-align: center;">
                    新增年度：<input name="years" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
                       value="<fmt:formatDate value="${basePoorerRegCard.yearDate}" pattern="yyyy"/>"
                       onclick="WdatePicker({dateFmt:'yyyy',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>
                </div>
                <div style="text-align: center">
                    <font color="red">*仅用于复制生成本户其他年度的数据，<br/>不可用于复制生成其他贫困户数据！</font>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit"  class="btn btn-primary">增加</button>
                </div>
            </form:form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
<script>
    $(document).ready(function(){
    $(".addNewRecord").click(function(){
        var id = $(this).parents("tr").find(".regCardId").val();
        $("#oldId").val(id);
    });


        <%--$(".pdf").on("click",function(e){--%>
            <%--e.preventDefault();--%>
            <%--var regCardId = $(this).parent().parent("tr").find("td:eq(1)").find("input[type=hidden]").attr("id")--%>
            <%--&lt;%&ndash;console.warn("${basePoorerRegCard}");&ndash;%&gt;--%>
<%--//            var regCardId="";--%>
            <%--var recordIncomeId="b6c5cdf8c382488b90753a3670a1e3f9";--%>
            <%--var cardId="b96311557d904c60ae86ef09c80f55d8";--%>
            <%--$.ajax({--%>
                <%--url:'${ctx}/bf/manual/manual2017',--%>
                <%--data:{regCardId:regCardId,recordIncomeId:recordIncomeId,cardId:cardId},--%>
                <%--type:'post',--%>
                <%--async: false,--%>
                <%--success:function(url){--%>
                    <%--console.log(url)--%>
                    <%--if(url != "") {--%>
                        <%--window.open("${basePath}"+url);--%>
                    <%--}--%>
                    <%--else{--%>
                       <%--alert("操作失败!");--%>
                    <%--}--%>
                <%--}--%>
            <%--})--%>
        <%--})--%>

        $(".pdf").on("click",function(e){
            e.preventDefault();
            var regCardId = $(this).parent().parent("tr").find("td:eq(1)").find(".regCardId").attr("id")
            <%--console.warn("${basePoorerRegCard}");--%>
//            var regCardId="";
//            var recordIncomeId="b6c5cdf8c382488b90753a3670a1e3f9";
//            var cardId="b96311557d904c60ae86ef09c80f55d8";
            var houseId = $(this).parent().parent("tr").find("td:eq(1)").find(".houseId").val();
            console.warn(houseId);
            $.ajax({
                url:'${ctx}/bf/manual/manual2017',
                data:{houseId:houseId},
                type:'post',
                async: false,
                success:function(url){
                    console.log(url)
                    if(url != "") {
                        window.open("${basePath}"+url);
                    }
                    else{
                        alert("操作失败!");
                    }
                }
            })
        })

    });
</script>
<style>
    li label{
        margin-left: 0px !important;
    }
</style>
</body>
</html>
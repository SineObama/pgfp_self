<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>年度帮扶及收入计划管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            $("select").select2();

            $(".houseHolderName").click(function(){
                    var iWidth = 900;
                    var iHeight = 500;
                    var iTop = (window.screen.availHeight - 30 - iHeight) / 2;
                    var iLeft = (window.screen.availWidth - 10 - iWidth) / 2;
                    window.open("${ctx}/record/basePoorerRegCard/holdsChoose", "选择贫困户", "width=" + iWidth +
                    ", height=" + iHeight + ",top=" + iTop + ",left=" + iLeft +
                    ",toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, " +
                    "status=no,alwaysRaised=yes,depended=yes");
            });
        });
        function chooseHolds(regCard){
                window.location.href="${ctx}/bf/bfHelpIncomePlan/form?card.id="+regCard.id;
        }
    </script>
    <style type="text/css">
        .noBlock {
            background-color: #FFFFFF !important;
            border: 0px #FFFFFF !important;
        }

        .tr td {
            text-align: center !important;
            min-width: 80px !important;
        }

        .subTitle {
            border: 1px solid #cccccc;

        }

        .subTitle td {
            text-align: center;
            font-size: 16px;
            font-weight: bolder;
        }

        .record td {
            min-width: 80px !important;
        }

        .delBtn {
            text-align: center !important;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/bf/bfHelpIncomePlan/">年度帮扶及收入计划列表</a></li>
    <li class="active"><a href="${ctx}/bf/bfHelpIncomePlan/form?card.id=${plan.card.id}">年度帮扶及收入计划<shiro:hasPermission
            name="bf:bfHelpIncomePlan:edit">${not empty bfHelpIncomePlan.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="bf:bfHelpIncomePlan:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>

<div class="header">
    <a href="" class="header-lt">年度帮扶及收入计划表</a>
</div>
<div class="content tabs f-clear">
    <div id="tab-15" class="content-detail">
        <form:form id="inputForm" modelAttribute="plan" action="${ctx}/bf/bfHelpIncomePlan/save" method="post"
                   class="form-horizontal">
            <form:hidden path="id"/>
            <form:hidden path="card.id"/>
            <form:hidden path="card.houseId"/>
            <sys:message content="${message}"/>
            <br/>
            <table class="noBlock">
                <tbody id="accpitem" class="accpitem">
                <tr class="noBlock">
                    <td colspan="2" class="houseHolderName noBlock">
                        <%--<span id="houseHolderName">户主姓名：${plan.card.houseHolderName}</span>--%>
                            户主姓名：<form:input path="card.houseHolderName" style="width:100px;"/>
                    </td>
                    <td colspan="6" class="address noBlock">家庭地址：${plan.card.address}</td>
                    <td class="year noBlock ">年度：<form:input path="years" disabled="true" style="background-color:#FFF ;width:50px;"/><form:hidden path="years" /> </td>
                </tr>
                <tr class="subTitle">
                    <td colspan="9">
                        扶持生产
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="2">分类</td>
                    <td colspan="2">种类</td>
                    <td>规模<br>(数量)</td>
                    <td>种养时间</td>
                    <td>出产收入<br>年月</td>
                    <td>年收入(元)</td>
                    <td class="addBtn" style="text-align: center;cursor: pointer;" id="1">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '1'}">
                        <tr class="record bg-white">
                            <td colspan="2">
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:select path="details[${status.index}].type" class="type">
                                    <form:option value="1">种植</form:option>
                                    <form:option value="2">养殖</form:option>
                                    <form:option value="3">其他</form:option>
                                </form:select>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].string1" class="string1"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].decimal1" class="decimal1 decimal"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].string2" class="string2"/>
                            </td>
                            <td>
                                <input id="details[${status.index}].date1" name="details[${status.index}].date1"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date1 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td>
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        转移就业
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="2">分类</td>
                    <td colspan="2">就业人数</td>
                    <td>年就业时间<br/>(月)</td>
                    <td>就业工种</td>
                    <td colspan="2">年收入(元)</td>
                    <td class="addBtn" id="2" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '2'}">
                        <tr class="record bg-white">
                            <td colspan="2">
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:select path="details[${status.index}].type" class="type">
                                    <form:option value="1">临时工</form:option>
                                    <form:option value="2">季节工</form:option>
                                    <form:option value="3">长期工</form:option>
                                </form:select>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].decimal1" class="decimal1 decimal"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].decimal2" class="decimal2 decimal"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].string1" class="string1"/>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        移民搬迁
                    </td>
                </tr>
                <tr class="tr">
                    <td>是否属于<br/>移民搬迁户</td>
                    <td>安置方式</td>
                    <td>安置类型</td>
                    <td>搬迁原因</td>
                    <td>搬迁时间</td>
                    <td>安置点<br/>名称及地址</td>
                    <td colspan="2">搬迁补助</td>
                    <td class="addBtn" id="3" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '3'}">
                        <tr class="record bg-white">
                            <td>
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:radiobuttons path="details[${status.index}].string1" class="string1"
                                                   items="${fns:getDictList('yes_no')}" itemValue="value"
                                                   itemLabel="label"/>
                            </td>
                            <td>
                                <form:select path="details[${status.index}].string2" class="string2">
                                    <form:option value="1">集中安置</form:option>
                                    <form:option value="2">分散安置</form:option>
                                </form:select>
                            </td>
                            <td>
                                <form:select path="details[${status.index}].string3" class="string3">
                                    <form:option value="">------</form:option>
                                    <form:option value="1">有地安置</form:option>
                                    <form:option value="2">无地安置</form:option>
                                </form:select>
                            </td>
                            <td>
                                <form:select path="details[${status.index}].string4" class="string4">
                                    <form:option value="1">缺乏生存条件</form:option>
                                    <form:option value="2">生态脆弱</form:option>
                                    <form:option value="3">避灾避险</form:option>
                                    <form:option value="4">自然保护区</form:option>
                                </form:select>
                            </td>
                            <td>
                                <input id="details[${status.index}].date1" name="details[${status.index}].date1"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date1 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td>
                                <form:input path="details[${status.index}].string5" class="string5"/>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
                <tbody class="accpitem">

                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        生态补偿
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="2">种类</td>
                    <td colspan="2">面积(亩)</td>
                    <td colspan="2">补偿金额(元)</td>
                    <td colspan="2">补偿时间</td>
                    <td class="addBtn" id="4" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '4'}">
                        <tr class="record bg-white">
                            <td colspan="2">
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:select path="details[${status.index}].type" class="type">
                                    <form:option value="1">退耕还林</form:option>
                                    <form:option value="2">公益林</form:option>
                                    <form:option value="3">其他</form:option>
                                </form:select>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].decimal1" class="decimal1 decimal"/>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td colspan="2">
                                <input id="details[${status.index}].date1" name="details[${status.index}].date1"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date1 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
                <tbody class="accpitem">

                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        教育培训
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="2">学生姓名</td>
                    <td>类别</td>
                    <td colspan="2">就读学校、年级</td>
                    <td>毕业时间</td>
                    <td colspan="2">获得补助(元)</td>
                    <td class="addBtn" id="51" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '5'}">
                        <c:if test="${detail.type eq '1'}">
                            <tr class="record bg-white">
                                <td colspan="2">
                                    <input type="hidden" name="details[${status.index}].classify" class="classify"
                                           value="${detail.classify}"/>
                                    <form:hidden path="details[${status.index}].type" class="type"/>
                                    <form:hidden path="details[${status.index}].id" class="id"/>
                                    <form:input path="details[${status.index}].string1" class="string1"/>
                                </td>
                                <td>
                                    <form:select path="details[${status.index}].string2" class="string2">
                                        <form:option value="1">幼儿园</form:option>
                                        <form:option value="2">小学</form:option>
                                        <form:option value="3">初中</form:option>
                                        <form:option value="4">高中</form:option>
                                        <form:option value="5">中职</form:option>
                                        <form:option value="6">高职</form:option>
                                        <form:option value="7">本科</form:option>
                                    </form:select>
                                </td>
                                <td colspan="2">
                                    <form:input path="details[${status.index}].string3" class="string3"/>
                                </td>
                                <td>
                                    <input id="details[${status.index}].date1" name="details[${status.index}].date1"
                                           type="text" readonly="readonly" maxlength="20"
                                           class="date1 input-medium Wdate required"
                                           value="<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>"
                                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                           style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                                </td>
                                <td colspan="2">
                                    <form:input path="details[${status.index}].income" class="income decimal"/>
                                </td>
                                <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                            </tr>
                        </c:if>
                    </c:if>
                </c:forEach>

                </tbody>
                <tbody class="accpitem">
                <tr class="tr">
                    <td colspan="2">受培训人姓名</td>
                    <td>天数(天)</td>
                    <td colspan="2">培训内容</td>
                    <td>培训地点</td>
                    <td>培训单位<br/>、形式</td>
                    <td>培训金额<br/>(元)</td>
                    <td class="addBtn" id="52" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '5'}">
                        <c:if test="${detail.type eq '2'}">
                            <tr class="record bg-white">
                                <td colspan="2">
                                    <input type="hidden" name="details[${status.index}].classify" class="classify"
                                           value="${detail.classify}"/>
                                    <form:hidden path="details[${status.index}].type" class="type"/>
                                    <form:hidden path="details[${status.index}].id" class="id"/>
                                    <form:input path="details[${status.index}].string1" class="string1"/>
                                </td>
                                <td>
                                    <form:input path="details[${status.index}].decimal1" class="decimal1 decimal"/>
                                </td>
                                <td colspan="2">
                                    <form:input path="details[${status.index}].string2" class="string2"/>
                                </td>
                                <td>
                                    <form:input path="details[${status.index}].string3" class="string3"/>
                                </td>
                                <td>
                                    <form:input path="details[${status.index}].string4" class="string4"/>
                                </td>
                                <td>
                                    <form:input path="details[${status.index}].income" class="income decimal"/>
                                </td>
                                <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                            </tr>
                        </c:if>
                    </c:if>
                </c:forEach>

                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        医疗救助
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="2">患者姓名</td>
                    <td>患病种类</td>
                    <td>患病时间</td>
                    <td colspan="2">救助途径</td>
                    <td colspan="2">救助金额<br/>(元)</td>
                    <td class="addBtn" id="6" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '6'}">
                        <tr class="record bg-white">
                            <td colspan="2">
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:input path="details[${status.index}].string1" class="string1"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].string2" class="string2"/>
                            </td>
                            <td>
                                <input id="details[${status.index}].date1" name="details[${status.index}].date1"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date1 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td colspan="2">
                                <form:select path="details[${status.index}].string3" class="string3">
                                    <form:option value="1">资助参加医保（新农合）</form:option>
                                    <form:option value="2">医保（新农合）补偿</form:option>
                                    <form:option value="3">大病保险赔付</form:option>
                                    <form:option value="4">疾病应急救助</form:option>
                                    <form:option value="5">医疗救助（民政救助）</form:option>
                                    <form:option value="6">社会捐助</form:option>
                                    <form:option value="7">其他</form:option>

                                </form:select>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        低保救助
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="3">低保人姓名</td>
                    <td colspan="3">享受低保起始月份</td>
                    <td colspan="2">年享受低保总额(元)</td>
                    <td class="addBtn" id="7" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '7'}">
                        <tr class="record bg-white">
                            <td colspan="3">
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:input path="details[${status.index}].string1" class="string1"/>
                            </td>
                            <td colspan="3">
                                <form:input path="details[${status.index}].string2" class="string2"/>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        养老金、高龄补贴等
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="3">享受补贴人姓名</td>
                    <td colspan="3">享受补贴启始月份</td>
                    <td colspan="2">年享受低保总额(元)</td>
                    <td class="addBtn" id="8" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '8'}">
                        <tr class="record bg-white">
                            <td colspan="3">
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:input path="details[${status.index}].string1" class="string1"/>
                            </td>
                            <td colspan="3">
                                <form:input path="details[${status.index}].string2" class="string2"/>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        边贸政策
                    </td>
                </tr>
                <tr class="tr">
                    <td colspan="3">种类</td>
                    <td colspan="2">年营业额(元)</td>
                    <td colspan="2">年收入(元)</td>
                    <td>免税金额<br/>(元)</td>
                    <td class="addBtn" id="9" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '9'}">
                        <tr class="record bg-white">
                            <td colspan="3">
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                <form:input path="details[${status.index}].string1" class="string1"/>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].decimal1" class="decimal1 decimal"/>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].decimal2" class="decimal2 decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        金融扶持
                    </td>
                </tr>
                <tr class="tr">
                    <td>种类</td>
                    <td>贷款名称</td>
                    <td>贷款用途</td>
                    <td>贷款金额<br/>(元)</td>
                    <td>贴息<br/>(元)</td>
                    <td>贷款时间</td>
                    <td>还贷时间</td>
                    <td>年度获得收入<br/>(元)</td>
                    <td class="addBtn" id="10" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '10'}">
                        <tr class="record bg-white">
                            <td>
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                    <%--<form:select path="details[${status.index}].type" class="type"--%>
                                    <%--itemLabel="label" items="jrfc" itemValue="value"/>--%>
                                <form:select path="details[${status.index}].type" class="type">
                                    <form:option value="1">小额信贷</form:option>
                                    <form:option value="2">其他</form:option>
                                </form:select>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].string1" class="string1"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].string2" class="string2"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].decimal1" class="decimal1 decimal"/>
                            </td>
                            <td>
                                <form:input path="details[${status.index}].decimal2" class="decimal2 decimal"/>
                            </td>
                            <td>
                                <input id="details[${status.index}].date1" name="details[${status.index}].date1"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date1 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td>
                                <input id="details[${status.index}].date2" name="details[${status.index}].date2"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date2 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date2}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td>
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>

                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        危房改造
                    </td>
                </tr>
                <tr class="tr">
                    <td>类型</td>
                    <td colspan="2">改造面积(平方米)</td>
                    <td colspan="2">改造时间</td>
                    <td colspan="2">改造完成时间</td>
                    <td>补助金额<br/>(元)</td>
                    <td class="addBtn" id="11" style="text-align: center;cursor: pointer;">添加</td>
                </tr>
                <c:forEach items="${plan.details}" var="detail" varStatus="status">
                    <c:if test="${detail.classify eq '11'}">
                        <tr class="record bg-white">
                            <td>
                                <input type="hidden" name="details[${status.index}].classify" class="classify"
                                       value="${detail.classify}"/>
                                <form:hidden path="details[${status.index}].id" class="id"/>
                                    <%--<form:select path="details[${status.index}].type" class="type"--%>
                                    <%--itemLabel="label" items="wfgz" itemValue="value"/>--%>
                                <form:select path="details[${status.index}].type" class="type">
                                    <form:option value="1">修缮加固</form:option>
                                    <form:option value="2">原址翻建</form:option>
                                    <form:option value="3">异地非集中新建</form:option>
                                    <form:option value="4">异地相对集中新建</form:option>
                                    <form:option value="5">房屋置换</form:option>
                                </form:select>
                            </td>
                            <td colspan="2">
                                <form:input path="details[${status.index}].decimal1" class="decimal1 decimal"/>
                            </td>
                            <td colspan="2">
                                <input id="details[${status.index}].date1" name="details[${status.index}].date1"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date1 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date1}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td colspan="2">
                                <input id="details[${status.index}].date2" name="details[${status.index}].date2"
                                       type="text" readonly="readonly" maxlength="20"
                                       class="date2 input-medium Wdate required"
                                       value="<fmt:formatDate value="${detail.date2}" pattern="yyyy-MM-dd"/>"
                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"
                                       style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>

                            </td>
                            <td>
                                <form:input path="details[${status.index}].income" class="income decimal"/>
                            </td>
                            <td class="delBtn"><span class="del-thistd-btn">删除</span></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
                <tbody class="accpitem">
                <tr></tr>
                <tr class="subTitle">
                    <td colspan="9">
                        其他
                    </td>
                </tr>
                <tr>
                    <td colspan="9" style="background-color: #FFFFFF;">
                        <form:textarea path="other" style="width:100%;height:60px; margin-top:5px;margin-bottom:5px;"/>
                    </td>
                </tr>
                </tbody>
            </table>

            <div class="form-actions" style="width: 920px;margin-left: -35px;">
                <shiro:hasPermission name="bf:bfHelpIncomePlan:edit">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
                </shiro:hasPermission>
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>


        </form:form>
    </div>
</div>



<script>
    //扶持生产
    var trHtml1 = '<tr class="record bg-white">' +
            '<td colspan="2">' +
            '<input type="hidden" name="details[0].classify" class="classify" value="1"/>' +
            '<input id="details0.id" name="details[0].id" class="id" type="hidden"/>' +
            '<select id="details0.type" name="details[0].type" class="type select2-offscreen" tabindex="-1">' +
            '<option value="1">种植</option>' +
            '<option value="2">养殖</option>' +
            '<option value="3">其他</option>' +
            '</select>' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details0.string1" name="details[0].string1" class="string1" type="text"/>' +
            '</td>' +
            '<td>' +
            '<input id="details0.decimal1" name="details[0].decimal1" class="decimal1 decimal" type="text" />' +
            '</td>' +
            '<td>' +
            '<input id="details0.string2" name="details[0].string2" class="string2" type="text"/>' +
            '</td>' +
            '<td>' +
            '<input id="details[0].date1" name="details[0].date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;"/>' +
            '</td>' +
            '<td>' +
            '<input id="details0.income" name="details[0].income" class="income decimal" type="text"/>' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td></tr>';

    //转移就业
    var trHtml2 = '<tr class="record bg-white">' +
            '<td colspan="2">' +
            '<input type="hidden" name="details[3].classify" class="classify" value="2">' +
            '<input id="details3.id" name="details[3].id" class="id" type="hidden">' +
            '<select id="details3.type" name="details[3].type" class="type select2-offscreen" tabindex="-1">' +
            '<option value="1">临时工</option>' +
            '<option value="2">季节工</option>' +
            '<option value="3">长期工</option>' +
            '</select>' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details3.decimal1" name="details[3].decimal1" class="decimal1 decimal" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details3.decimal2" name="details[3].decimal2" class="decimal2 decimal" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details3.string1" name="details[3].string1" class="string1" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details3.income" name="details[3].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //移民搬迁
    var trHtml3 = '<tr class="record bg-white">' +
            '<td>' +
            '<input type="hidden" name="details[3].classify" class="classify" value="3">' +
            '<input id="details3.id" name="details[3].id" class="id" type="hidden">' +
            '<span>' +
            '<input id="details3.string11" name="details[3].string1" class="string1" type="radio">' +
            '<label for="details3.string11">是</label>' +
            '</span>' +
            '<span>' +
            '<input id="details3.string12" name="details[3].string1" class="string1" type="radio" value="0">' +
            '<label for="details3.string12">否</label>' +
            '</span>' +
            '</td>' +
            '<td>' +
            '<select id="details3.string2" name="details[3].string2" class="string2 select2-offscreen" tabindex="-1">' +
            '<option value="1">集中安置</option>' +
            '<option value="2">分散安置</option>' +
            '</select>' +
            '</td>' +
            '<td>' +
            '<select id="details3.string3" name="details[3].string3" class="string3 select2-offscreen" tabindex="-1">' +
            '<option value="1">有地安置</option>' +
            '<option value="2">无地安置</option>' +
            '</select>' +
            '</td>' +
            '<td>' +
            '<select id="details3.string4" name="details[3].string4" class="string4 select2-offscreen" tabindex="-1">' +
            '<option value="1" selected="selected">缺乏生存条件</option>' +
            '<option value="2">生态脆弱</option>' +
            '<option value="3">避灾避险</option>' +
            '<option value="4">自然保护区</option>' +
            '</select>' +
            '</td>' +
            '<td>' +
            '<input id="details[3].date1" name="details[3].date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td>' +
            '<input id="details3.string5" name="details[3].string5" class="string5" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details3.income" name="details[3].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    生态补偿
    var trHtml4 = '<tr class="record bg-white">' +
            '<td colspan="2">' +
            '<input type="hidden" name="details[4].classify" class="classify" value="4">' +
            '<input id="details4.id" name="details[4].id" class="id" type="hidden">' +
            '<select id="details4.type" name="details[4].type" class="type select2-offscreen" tabindex="-1">' +
            '<option value="1">退耕还林</option>' +
            '<option value="2">公益林</option>' +
            '<option value="3">其他</option>' +
            '</select>' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details4.decimal1" name="details[4].decimal1" class="decimal1 decimal valid" type="text" data-original-title="" title="">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details4.income" name="details[4].income" class="income decimal" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details[4].date1" name="details[4].date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    教育培训1
    var trHtml51 = '<tr class="record bg-white">' +
            '<td colspan="2">' +
            '<input type="hidden" name="details[51].classify" class="classify" value="5">' +
            '<input type="hidden" name="details[51].type" class="type" value="1"/>' +
            '<input id="details51.id" name="details[51].id" class="id" type="hidden">' +
            '<input id="details51.string1" name="details[51].string1" class="string1" type="text">' +
            '</td>' +
            '<td>' +
            '<select id="details51.string2" name="details[51].string2" class="string2 select2-offscreen" tabindex="-1">' +
            '<option value="1">幼儿园</option>' +
            '<option value="2">小学</option>' +
            '<option value="3">初中</option>' +
            '<option value="4">高中</option>' +
            '<option value="5">中职</option>' +
            '<option value="6">高职</option>' +
            '<option value="7">本科</option>' +
            '</select>' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details51.string3" name="details[51].string3" class="string3" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details[51].date1" name="details[51].date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details51.income" name="details[51].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    教育培训2
    var trHtml52 = '<tr class="record bg-white">' +
            '<td colspan="2">' +
            '<input type="hidden" name="details[52].classify" class="classify"value="5">' +
            '<input type="hidden" name="details[52].type" class="type" value="2" />' +
            '<input id="details52.id" name="details[52].id" class="id" type="hidden">' +
            '<input id="details52.string1" name="details[52].string1" class="string1" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details52.decimal1" name="details[52].decimal1" class="decimal1 decimal" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details52.string2" name="details[52].string2" class="string2" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details52.string3" name="details[52].string3" class="string3" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details52.string4" name="details[52].string4" class="string4" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details52.income" name="details[52].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    医疗救助
    var trHtml6 = '<tr class="record bg-white">' +
            '<td colspan="2">' +
            '<input type="hidden" name="details[6].classify" class="classify" value="6">' +
            '<input id="details6.id" name="details[6].id" class="id" type="hidden">' +
            '<input id="details6.string1" name="details[6].string1" class="string1" type="text" value="22">' +
            '</td>' +
            '<td>' +
            '<input id="details6.string2" name="details[6].string2" class="string2" type="text" value="2">' +
            '</td>' +
            '<td>' +
            '<input id="details[6].date1" name="details[6].date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate required" value="2017-04-11" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td colspan="2">' +
            '<select id="details6.string3" name="details[6].string3" class="string3 select2-offscreen" tabindex="-1">' +
            '<option value="1">资助参加医保（新农合）</option>' +
            '<option value="2" selected="selected">医保（新农合）补偿</option>' +
            '<option value="3">大病保险赔付</option>' +
            '<option value="4">疾病应急救助</option>' +
            '<option value="5">医疗救助（民政救助）</option>' +
            '<option value="6">社会捐助</option>' +
            '<option value="7">其他</option>' +

            '</select>' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details6.income" name="details[6].income" class="income decimal" type="text" value="1.0">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    低保救助
    var trHtml7 = '<tr class="record bg-white">' +
            '<td colspan="3">' +
            '<input type="hidden" name="details[7].classify" class="classify" value="7">' +
            '<input id="details7.id" name="details[7].id" class="id" type="hidden">' +
            '<input id="details7.string1" name="details[7].string1" class="string1" type="text">' +
            '</td>' +
            '<td colspan="3">' +
            '<input id="details7.string2" name="details[7].string2" class="string2" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details7.income" name="details[7].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    养老金、高龄补贴等
    var trHtml8 = '<tr class="record bg-white">' +
            '<td colspan="3">' +
            '<input type="hidden" name="details[8].classify" class="classify" value="8">' +
            '<input id="details8.id" name="details[8].id" class="id" type="hidden">' +
            '<input id="details8.string1" name="details[8].string1" class="string1" type="text">' +
            '</td>' +
            '<td colspan="3">' +
            '<input id="details8.string2" name="details[8].string2" class="string2" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details8.income" name="details[8].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    边贸政策
    var trHtml9 = '<tr class="record bg-white">' +
            '<td colspan="3">' +
            '<input type="hidden" name="details[11].classify" class="classify" value="9">' +
            '<input id="details11.id" name="details[11].id" class="id" type="hidden">' +
            '<input id="details11.string1" name="details[11].string1" class="string1" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details11.decimal1" name="details[11].decimal1" class="decimal1 decimal" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details11.income" name="details[11].income" class="income decimal" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details11.decimal2" name="details[11].decimal2" class="decimal2 decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    金融扶持
    var trHtml10 = '<tr class="record bg-white">' +
            '<td>' +
            '<input type="hidden" name="details[10].classify" class="classify" value="10">' +
            '<input id="details10.id" name="details[10].id" class="id" type="hidden">' +
            '<select id="details10.type" name="details[10].type" class="type select2-offscreen" tabindex="-1">' +
            '<option value="1">小额信贷</option>' +
            '<option value="2">其他</option>' +
            '</select>' +
            '</td>' +
            '<td>' +
            '<input id="details10.string1" name="details[10].string1" class="string1" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details10.string2" name="details[10].string2" class="string2" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details10.decimal1" name="details[10].decimal1" class="decimal1 decimal" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details10.decimal2" name="details[10].decimal2" class="decimal2 decimal" type="text">' +
            '</td>' +
            '<td>' +
            '<input id="details[10].date1" name="details[10].date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td>' +
            '<input id="details[10].date2" name="details[10].date2" type="text" readonly="readonly" maxlength="20" class="date2 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td>' +
            '<input id="details10.income" name="details[10].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //    危房改造
    var trHtml11 = '<tr class="record bg-white">' +
            '<td>' +
            '<input type="hidden" name="details[11].classify" class="classify" value="11">' +
            '<input id="details11.id" name="details[11].id" class="id" type="hidden">' +
            '<select id="details11.type" name="details[11].type" class="type select2-offscreen" tabindex="-1">' +
            '<option value="1">修缮加固</option>' +
            '<option value="2" selected="selected">原址翻建</option>' +
            '<option value="3">异地非集中新建</option>' +
            '<option value="3">异地相对集中新建</option>' +
            '<option value="3">房屋置换</option>' +
            '</select>' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details11.decimal1" name="details[11].decimal1" class="decimal1 decimal" type="text">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details[11].date1" name="details[11].date1" type="text" readonly="readonly" maxlength="20" class="date1 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td colspan="2">' +
            '<input id="details[11].date2" name="details[11].date2" type="text" readonly="readonly" maxlength="20" class="date2 input-medium Wdate required" onclick="WdatePicker({dateFmt:\'yyyy-MM-dd\',isShowClear:false});" style="width: 120px;height:90%;background-color: #FFFFFF;border:1px solid #ccc;">' +
            '</td>' +
            '<td>' +
            '<input id="details11.income" name="details[11].income" class="income decimal" type="text">' +
            '</td>' +
            '<td class="delBtn"><span class="del-thistd-btn">删除</span></td>' +
            '</tr>';
    //	删除按钮
    $(".accpitem").delegate(".delBtn", 'click', function () {
        var delBtn = $(this);
         confirmx('确认要删除记录吗？', function(){
             delBtn.parents("tr").remove();
             rename();
         });
    });
    //	添加按钮
    $(".addBtn").click(function () {
        var id = $(this).attr("id");
        if (id == '1') {//扶持生产
            $(this).parents("tbody").append(trHtml1);
        } else if (id == '2') {
            $(this).parents("tbody").append(trHtml2);
        } else if (id == '3') {
            $(this).parents("tbody").append(trHtml3);
        } else if (id == '4') {
            $(this).parents("tbody").append(trHtml4);
        } else if (id == '51') {
            $(this).parents("tbody").append(trHtml51);
        } else if (id == '52') {
            $(this).parents("tbody").append(trHtml52);
        } else if (id == '6') {
            $(this).parents("tbody").append(trHtml6);
        } else if (id == '7') {
            $(this).parents("tbody").append(trHtml7);
        } else if (id == '8') {
            $(this).parents("tbody").append(trHtml8);
        } else if (id == '9') {
            $(this).parents("tbody").append(trHtml9);
        } else if (id == '10') {
            $(this).parents("tbody").append(trHtml10);
        } else if (id == '11') {
            $(this).parents("tbody").append(trHtml11);
        }
        $('select').select2();
        rename();
    });
    //	重新起名字
    function rename() {
        var i = 0;
        $(".accpitem").find(".record").each(function () {
            $(this).find(".id").attr("name", "details[" + i + "].id");
            $(this).find(".classify").attr("name", "details[" + i + "].classify");
            $(this).find(".type").attr("name", "details[" + i + "].type");
            $(this).find(".string1").attr("name", "details[" + i + "].string1");
            $(this).find(".string2").attr("name", "details[" + i + "].string2");
            $(this).find(".string3").attr("name", "details[" + i + "].string3");
            $(this).find(".string4").attr("name", "details[" + i + "].string4");
            $(this).find(".string5").attr("name", "details[" + i + "].string5");
            $(this).find(".date1").attr("name", "details[" + i + "].date1");
            $(this).find(".date2").attr("name", "details[" + i + "].date2");
            $(this).find(".decimal1").attr("name", "details[" + i + "].decimal1");
            $(this).find(".decimal2").attr("name", "details[" + i + "].decimal2");
            $(this).find(".income").attr("name", "details[" + i + "].income");
//			cadres.log(this);
            i++;
        });
    }


</script>
</body>

</html>
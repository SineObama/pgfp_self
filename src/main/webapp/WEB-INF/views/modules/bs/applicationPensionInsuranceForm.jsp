<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>社会养老保险金申请表管理</title>
    <meta name="decorator" content="default"/>
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
        });
        $(function () {
            $("input").attr("readonly", "true");
            check();
        });
        function check(v) {
            var value = ${applicationPensionInsurance.checkState};
            if (value == null) {
                value = 0;
            }
            if (v) {
                value = v;
            }
            //判断状态
            if (value == '0') {
                $(".checkState").text("未处理");
            } else if (value == '1') {
                $(".checkState").text("已受理");
                alter(".back", false);
                alter(".accept", true);
            } else if (value == '2') {
                $(".checkState").text("已驳回");
                alter(".back", true);
                alter(".accept", false);
            }
        }
        ;

        function alter(str, b) {
            $(str).attr("disabled", b);
        }
    </script>
    <style>
        #inputForm {
            width: 900px;
            margin-left: 30px;
        }

        table {
            border: 2px solid #ccc;
        }

        td {
            height: 34px;
            min-width: 120px;
            text-align: center;
            border: 1px solid #ccc;
        }

        .table-title {
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            color: #000;
        }

        .table-subtitle {
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            color: #000;
        }

        .thead-r {
            float: right;
            margin-right: 100px;
            display: inline-block;
        }

        .border-none {
            border-width: 0 1px 0 1px;
        }

        .text-l {
            padding: 10px 8px;
            text-align: left;
        }

        .text-l .sig {
            text-align: right;
        }

        .text-l span {
            display: inline-block;
            text-indent: 2em;
        }

        .accept {
            margin-left: 500px;
            color: #333;
            background: #4b7ee6;
        }

        .accept:hover {
            color: #fff;
            background: #4b7ee6;
        }

        .back {
            color: #333;
            background: #ff3c2f;
        }

        .back:hover {
            color: #fff;
            background: #ff3c2f;
        }
		.btn.back[readonly]{
			color: #333;
		}
		.btn.back[readonly]:hover{
			color: #333;
			background-color: rgb(243,243,243);
		}

        .return {
            display: inline-block;
            padding: 4px 12px;
            border: 1px solid rgb(179, 179, 179);
            font-size: 14px;
            line-height: 20px;
            color: #333;
            text-align: center;
            text-shadow: 0 1px 1px rgba(255, 255, 255, 0.75);
            border-radius: 4px;
            text-decoration: none;
            vertical-align: top;
            margin-left: 20px;
        }

        .return:hover {
            color: #333;
            text-decoration: none;
        }

        .btn {
            text-shadow: none;
        }

        .audit {
            margin-left: 0px;
        }

        .year {
            margin-left: 120px;
        }

        .month {
            margin-left: 5px;
        }

        .day {
            margin-left: 5px;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/bs/applicationPensionInsurance/">社会养老保险金申请表列表</a></li>
    <li class="active"><a href="${ctx}/bs/applicationPensionInsurance/form?id=${applicationPensionInsurance.id}">社会养老保险金申请表详情</a>
    </li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="applicationPensionInsurance"
           action="${ctx}/bs/applicationPensionInsurance/save" method="post" class="form-horizontal">
    <form:hidden path="id" class="id"/>
    <sys:message content="${message}"/>
    <h2 class="table-title">平桂管理区领取城乡居民社会养老保险金申请表</h2>

    <h3 class="table-subtitle">（仅限2012年1月1日后年满60岁的人员使用）</h3>

    <div>
        <label>个人编号：</label>
        <span>${applicationPensionInsurance.number}</span>
		<span class="thead-r"><span>申请日期：</span>
				<span><fmt:formatDate value="${applicationPensionInsurance.applicationDate}"
                                      pattern="yyyy  年  MM  月 dd 日"/></span>
			</span>
    </div>
    <table>
        <tr>
            <td>姓名</td>
            <td colspan="2">${applicationPensionInsurance.name}</td>
            <td>性别</td>
            <td>${applicationPensionInsurance.sex}</td>
            <td>出生年月</td>
            <td><fmt:formatDate value="${applicationPensionInsurance.birthday}" pattern="yyyy年MM月dd日"/></td>
        </tr>
        <tr>
            <td colspan="2">身份证号码</td>
            <td colspan="3">${applicationPensionInsurance.idNumber}</td>
            <td>联系电话</td>
            <td colspan="2">${applicationPensionInsurance.phone}</td>
        </tr>
        <tr>
            <td colspan="2">户籍所在地址</td>
            <td colspan="6">${applicationPensionInsurance.domicile}</td>
        </tr>
        <tr>
            <td colspan="2">现居住地址</td>
            <td colspan="6">${applicationPensionInsurance.residence}</td>
        </tr>
        <tr>
            <td colspan="2">户籍性质</td>
            <td colspan="6">
                <c:choose>
                    <c:when test="${applicationPensionInsurance.householdNature == '1'}">
                        城镇居民(非农业户口)
                    </c:when>
                    <c:otherwise>
                        农业户口
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td colspan="2">参保时间</td>
            <td colspan="3"><fmt:formatDate value="${applicationPensionInsurance.insuredTime}"
                                            pattern="yyyy年MM月dd日"/></td>
            <td>到龄时间</td>
            <td colspan="2"><fmt:formatDate value="${applicationPensionInsurance.arrivalAge}"
                                            pattern="yyyy年MM月dd日"/></td>
        </tr>
        <tr>
            <td colspan="2">开户银行</td>
            <td colspan="3">${applicationPensionInsurance.openingBank}</td>
            <td>银行账号</td>
            <td colspan="2">${applicationPensionInsurance.bankAccount}</td>
        </tr>
        <tr>
            <td colspan="2">中断缴费年限</td>
            <td colspan="6">${applicationPensionInsurance.breakYears}</td>
        </tr>
        <tr>
            <td colspan="2">累计缴费年限</td>
            <td colspan="6">${applicationPensionInsurance.paymentYears}</td>
        </tr>
        <tr>
            <td class="border-none" rowspan="8">
                <div style="margin:0 auto;width: 20px">直系亲属参保情况</div>
            </td>
            <td>称谓</td>
            <td>姓名</td>
            <td colspan="2">身份证号码</td>
            <td colspan="3">参加社会保障情况</td>
        </tr>
        <c:forEach begin="0" end="6" varStatus="status">
            <c:set var="i" value="${status.count - 1}"/>
            <tr>
                <td>${applicationPensionInsurance.insureds[i].appellation}</td>
                <td>${applicationPensionInsurance.insureds[i].name}</td>
                <td colspan="2">${applicationPensionInsurance.insureds[i].idNumber}</td>
                <td colspan="3">${applicationPensionInsurance.insureds[i].socialSecurity}</td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="4" class="text-l">
                申请人声明：<br/>
                <span>以上填写内容正确无误。</span><br/><br/>

                <p class="sig"><span class="audit">申请人:</span><span class="year">年</span>
                    <span class="month">月</span><span class="day">日(签章)</span></p>

            </td>
            <td colspan="4" class="text-l">
                村委（社区）申报意见：<br/>
                <span>确认申请人生存，符合条件，同意办理。</span><br/><br/>

                <p class="sig"><span class="audit">经办人：</span><span class="year">年</span>
                    <span class="month">月</span><span class="day">日(签章)</span></p>
            </td>
        </tr>
        <tr>
            <td colspan="4" class="text-l">
                街道（乡镇）劳保所审核意见：<br/>
                <span>符合条件，同意办理。</span><br/><br/>

                <p class="sig"><span class="audit">审核人：</span><span class="year">年</span>
                    <span class="month">月</span><span class="day">日(签章)</span></p>
            </td>
            <td colspan="4" class="text-l">
                县（区）社保机构复核意见：<br/>
                <span>符合条件，同意办理。</span><br/><br/>

                <p class="sig"><span class="audit">审核人：</span><span class="year">年</span>
                    <span class="month">月</span><span class="day">日(签章)</span></p>
            </td>
        </tr>
    </table>
    <div class="control-group" style="margin:10px 60px;height: 60px;padding: 0px">
        <span class="text fb">审核状态:</span>
        <span class="text checkState fb" style="color: red;margin-left: 15px"></span>
    </div>
    <div class="control-group" style="margin:10px 60px;padding: 0px">
        <span class="text fb">审批意见:</span>
        <textarea id="remarks" name="remarks" style="min-width:350px;">${applicationPensionInsurance.remarks}</textarea>
    </div>
    <div class="control-group" style="margin:20px 60px;height: 60px;padding: 0px">
        <input class="btn accept" type="button" data-tar="1" value="同意">
        <input class="btn back" type="button" data-tar="2" style="margin-left: 20px;" value="驳回">
        <a class="return" href="${ctx}/bs/applicationPensionInsurance/">返回</a>
            <%--<input class="btn" type="button" style="margin-left: 20px" onclick="history.go(-1)" value="返回">--%>
    </div>
</form:form>
<script>
    $(".accept,.back").on("click", function () {
        var sta = $(this).data("tar");
        var id = $("input[class='id']").val();
        var remarks = $("textarea[id='remarks']").val();
        $.ajax({
            url: '${basePath}/a/bs/applicationPensionInsurance/check',
            type: 'post',
            dataType: 'json',
            data: {
                id: id,
                sta: sta,
                remarks:remarks
            },
            success: function (res) {
                if (res.sta === '1') {
                    check(1);
                } else if (res.sta == '2') {
                    check(2);
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    })
</script>
</body>
</html>
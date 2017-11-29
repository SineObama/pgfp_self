<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html style="overflow-x:auto;overflow-y:auto;">
<head>
    <title>登录系统-${fns:getConfig('productName')}</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10"/>
    <meta http-equiv="Expires" content="0">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-store">
    <script src="${ctxStatic}/pgfp/js/jquery-1.js" type="text/javascript"></script>
    <link href="${ctxStatic}/pgfp/css/bootstrap.css" type="text/css" rel="stylesheet"/>
    <!--[if lte IE 7]>
    <link href="${ctxStatic}/bootstrap/2.3.1/awesome/font-awesome-ie7.css" type="text/css" rel="stylesheet"/>
    <![endif]-->
    <!--[if lte IE 6]>
    <link href="${ctxStatic}/static/bootstrap/bsie/css/bootstrap-ie6.min.css" type="text/css" rel="stylesheet"/>
    <script src="${ctxStatic}/bootstrap/bsie/js/bootstrap-ie.min.js" type="text/javascript"></script><![endif]-->
    <script src="${ctxStatic}/pgfp/js/jquery.validate.min.js" type="text/javascript"></script>
    <link href="${ctxStatic}/pgfp/css/login.css" type="text/css" rel="stylesheet"/>
    <script src="${ctxStatic}/pgfp/js/jquery.placeholder.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/pgfp/js/login.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#loginForm").validate({
                rules: {
                    validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
                },
                messages: {
                    username: {required: "请填写用户名."}, password: {required: "请填写密码."},
                    validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
                },
                errorLabelContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    error.appendTo($("#loginError").parent());
                }
            });
        });
        // 如果在框架或在对话框中，则弹出提示并跳转到首页
        if (self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0) {
            alert('未登录或登录超时。请重新登录，谢谢！');
            top.location = "${ctx}";
        }
    </script>
    <style>
        .QR-code{
            position: absolute;
            right: 170px;
            bottom: -120px;
        }
        .QR-code div{
            float: left;
            width: 100px;
            height: 100px;
            background: url("../${ctxStatic}/images/pgfp_app_android.png") no-repeat;
            background-size: 100%;
        }
        .QR-code span{
            display: inline-block;
            margin-top: 5px;
            color: #fff;
        }
    </style>
</head>
<body>
<h1 class="form-signin-heading"><img src="${ctxStatic}/pgfp/images/blogo.png"/></h1>

<div id="change-bg"
     style="background: url(${ctxStatic}/pgfp/images/bg1.jpg) center center no-repeat #fff;background-size: cover"></div>
<div id="bg-white"></div>
<div class="login-middle">
    <div id="loginForm-wrapper">
        <form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
            <h2 class="form-login-head">用户登录</h2>

            <div class="form-row">
                <input type="text" id="username" name="username" placeholder="用户名" autocomplete="off"
                       class="input-block-level required" value="${username}">
            </div>
            <div class="form-row">
                <input type="password" id="password" name="password" placeholder="密码" autocomplete="off"
                       class="input-block-level required">
            </div>
            <c:if test="${isValidateCodeLogin}">
                <div class="form-row">
                    <label class="input-label mid" for="validateCode" style="color: #FFFFFF;">验证码</label>
                    <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                </div>
            </c:if>
            <div class="form-row ">
                <input class="btn btn-large btn-primary" type="submit" value="登 录"/>
            </div>
            <div class="form-row last-row">
                <label for="rememberMe" title="下次不需要再登录"><input type="checkbox" id="rememberMe"
                                                                name="rememberMe" ${rememberMe ? 'checked' : ''}/>
                    记住我（公共场所慎用）</label>
            </div>
        </form>
        <div class="QR-code">
            <div class="img-wrapper" style="margin-right: 60px;">
                <div class="andriod"></div>
                <span>Andriod</span>
            </div>
            <%--<div class="img-wrapper">--%>
                <%--<div class="apple"></div>--%>
                <%--<span>IOS</span>--%>
            <%--</div>--%>
        </div>
    </div>
</div>
<div class="footer">
    Copyright &copy; 2016-2020 <a href="http://www.pinggui.gov.cn">贺州市平桂区人民政府</a>
</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>干部签到记录管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

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
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/bf/bfCadreAttendanceRecord/">干部签到记录列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="bfCadreAttendanceRecord" action="${ctx}/bf/bfCadreAttendanceRecord/"
           method="post" class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <ul class="ul-form">
        <li>
            <label class="control-label">干部名:</label>
            <form:input path="createBy.name"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<div class="leader_box_2 fl_list clear">
<ul class="f-clear">
    <c:forEach items="${page.list}" var="record">
        <li>
            <a class="f-clear" href="">
                <div class="leader_pic leader_left">
                    <img src="${record.imagePath}" alt="${record.createBy.name}"/>
                </div>
                <div class="leader_right">
                    <div class="leader_name1 leader_name">${record.createBy.name}</div>
                    <div class="leader_name1 font-black address">${record.address}</div>
                    <div class="leader_name1 font-black"><fmt:formatDate value="${record.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                </div>
            </a>
        </li>
    </c:forEach>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="D:/1111111.jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25 12:00:01</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="http://www.pinggui.gov.cn/userfiles/1/_thumbs/images/cms/article/2016/12/%E6%9C%B1%E5%BB%BA%E5%86%9B(%E8%93%9D%E5%BA%95%EF%BC%89(1).jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="http://www.pinggui.gov.cn/userfiles/1/_thumbs/images/cms/article/2016/12/%E6%9C%B1%E5%BB%BA%E5%86%9B(%E8%93%9D%E5%BA%95%EF%BC%89(1).jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="http://www.pinggui.gov.cn/userfiles/1/_thumbs/images/cms/article/2016/12/%E6%9C%B1%E5%BB%BA%E5%86%9B(%E8%93%9D%E5%BA%95%EF%BC%89(1).jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="http://www.pinggui.gov.cn/userfiles/1/_thumbs/images/cms/article/2016/12/%E6%9C%B1%E5%BB%BA%E5%86%9B(%E8%93%9D%E5%BA%95%EF%BC%89(1).jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="http://www.pinggui.gov.cn/userfiles/1/_thumbs/images/cms/article/2016/12/%E6%9C%B1%E5%BB%BA%E5%86%9B(%E8%93%9D%E5%BA%95%EF%BC%89(1).jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="http://www.pinggui.gov.cn/userfiles/1/_thumbs/images/cms/article/2016/12/%E6%9C%B1%E5%BB%BA%E5%86%9B(%E8%93%9D%E5%BA%95%EF%BC%89(1).jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>
    <%--<li>--%>
        <%--<a class="f-clear" href="">--%>
            <%--<div class="leader_pic leader_left">--%>
                <%--<img src="http://www.pinggui.gov.cn/userfiles/1/_thumbs/images/cms/article/2016/12/%E6%9C%B1%E5%BB%BA%E5%86%9B(%E8%93%9D%E5%BA%95%EF%BC%89(1).jpg" alt="朱建军">--%>
            <%--</div>--%>
            <%--<div class="leader_right">--%>
                <%--<div class="leader_name1 leader_name">龙霞</div>--%>
                <%--<div class="leader_name1">鹅塘镇新塘村上坪片村委楼</div>--%>
                <%--<div class="leader_name1">2017-06-25</div>--%>
            <%--</div>--%>
        <%--</a>--%>
    <%--</li>--%>

</ul>
</div>
<style>
    ul,li{list-style: none}
    .f-clear{
        zoom: 1;}
    .f-clear:after{
        content: "";
        display: block;
        height: 0;
        clear: both;
        visibility: hidden;
    }
    .leader_box_2{
        display: block;
    }
    .leader_box_2 .leader_pic{
        height: 110px;
        overflow: hidden;
        vertical-align: middle;
        font-size: 0;
    }
    .leader_box_2 .leader_pic img{
        display: inline-block;
        width: 80px;
        height: 100px;
        vertical-align: middle;
    }
    .leader_box_2 ul{
        width: 1205px;
        font-size: 0;
    }
    .leader_box_2 li{
        float: left;
        width: 231px;
        margin-right: 10px;
        font-size: 0;
    }
    .leader_box_2 li a{
        display: block;
    }
    .leader_box_2 p{
        padding: 10px 20px;
    }
    .leader_name{
        font-weight: bold;
        background-color: #e1f0f8;
        padding: 4px 0;
    }
    .leader_name1{
        font-size: 12px;
    }
    .leader_left{
        float: left;
        width: 81px;
        overflow: hidden;
    }
    .leader_right{
        float: right;
        width: 150px;
        position: relative;
    }
    .leader_right div{
        padding: 5px 4px;
    }
    .leader_desc{
        position: absolute;
        right: 0px;
        bottom: 0px;
    }
    .font-black{
        color: #000;
    }
    .address{
        height: 40px;
        overflow: hidden;
        padding: 0!important;
        margin: 5px 4px;
    }
</style>
<div class="pagination">${page}</div>
</body>
</html>
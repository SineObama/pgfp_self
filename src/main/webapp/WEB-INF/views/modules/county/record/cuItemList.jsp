<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<script>
    $(document).ready(function () {
        // setting .content-nav height
        var tarUl = $(".content-nav"); // target ul
        var frameObj = $("body"); // #jerichotabiframe_2
        if (tarUl.height() > frameObj.height() - 510) {
            tarUl.css({
                "height": frameObj.height() - 510,
                "overflow-x": "hidden",
                "overflow-y": "scroll"
            });
        }
    })
</script>

<ul class="content-nav">
    <%--1--%>
    <li id="specialty">
        <a href="${ctx}/record/cuCountySpecialtyIndustry/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=1">
            县特色产业情况统计表
        </a>
    </li>

    <%--2--%>
    <li id="industry">
        <a href="${ctx}/record/cuHouseIndustryRegister/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=2&department=${cuTable.department.id}">
            乡镇贫困户产业登记表
        </a>
    </li>

    <%--3--%>
    <li id="labour1">
        <a href="${ctx}/county/record/countyIncapabilityOrWorkout/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=3">
            县劳动力情况统计表
        </a>
    </li>

    <%--4--%>
    <li id="labour2">
        <a href="${ctx}/county/record/cuHouseIncapabilityOrWorkout/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=4">
            乡镇劳动力情况表
        </a>
    </li>

    <%--5--%>
    <li id="artel">
        <a href="${ctx}/record/cuCountyFarmerCooperation/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=5">
            县贫困村农民合作社
        </a>
    </li>

    <%--6--%>
    <li id="industrialBase">
        <a href="${ctx}/record/cuCountyIndustrialBase/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=6">
            县贫困村产业基地一览表
        </a>
    </li>

    <%--7--%>
    <li id="houseQ">
        <a href="${ctx}/record/cuCountyHouseQualified/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=7">
            县住房保障达标情况表
        </a>
    </li>

    <%--8--%>
    <li id="HouseUnqualified">
        <a href="${ctx}/record/cuCountyHouseUnqualified/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=8">
            住房保障未达标户名单
        </a>
    </li>

    <%--9--%>
    <li id="relocation">
        <a href="${ctx}/record/cuCountyRelocation/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=9">
            异地搬迁户住房保障情况
        </a>
    </li>
    <%--10--%>
    <li id="Dilapidated">
        <a href="${ctx}/record/cuCountyDilapidatedHouses/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=10">
            县存量危房改造统计表
        </a>
    </li>
    <%--11--%>
    <li id="DilapidatedInfo">
        <a href="${ctx}/record/cuHouseDilapidatedInfo/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=11&department=${cuTable.department.id}">
            镇贫困户存量危房情况
        </a>
    </li>

    <%--12--%>
    <li id="insurance">
        <a href="${ctx}/record/cuCountyInsurance/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=12">
            农村居民购买保险情况统计
        </a>
    </li>

    <%--13--%>
    <li id="noInsurance">
        <a href="${ctx}/record/cuCountyNoInsurance/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=13">
            农村居民未购买保险名单
        </a>
    </li>

    <%--14--%>
    <li id="sick">
        <a href="${ctx}/record/cuCountySickPoorer/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=14">
            因病致贫减少户数情况统计
        </a>
    </li>

    <%--15--%>
    <li id="CureSubsidy">
        <a href="${ctx}/record/cuCountyCureSubsidy/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=15">
            患病救治和补助报销统计
        </a>
    </li>
    <%--16--%>
    <li id="educationPolicy">
        <a href="${ctx}/record/cuCountyEducationPolicy/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=16">
            县学生享受义务教育统计表
        </a>
    </li>
    <%--17--%>
    <li id="CompulsoryEducation">
        <a href="${ctx}/record/cuCountyCompulsoryEducation/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=17">
            适龄儿童接受义务教育统计
        </a>
    </li>
    <%--18--%>
    <li id="ChildrenNoEducation">
        <a href="${ctx}/record/cuCountyChildrenNoEducation/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=18">
            应接受义务教育未接受名单
        </a>
    </li>
    <%--19--%>
    <li id="SafeWater">
        <a href="${ctx}/record/cuCountySafeWater/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=19">
            安全饮水达标情况统计表
        </a>
    </li>
    <%--20--%>
    <li id="NoSafeWater">
        <a href="${ctx}/record/cuCountyNoSafeWater/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=20">
            未达到安全饮水名单统计
        </a>
    </li>
    <%--21--%>
    <li id="HardeningRoad">
        <a href="${ctx}/record/cuCountyHardeningRoad/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=21">
            县行政村通硬化路情况表
        </a>
    </li>
    <%--22--%>
    <li id="RoadSituation">
        <a href="${ctx}/record/cuCountyTwentyRoadSituation/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=22">
            自然村屯通路情况表
        </a>
    </li>
    <%--23--%>
    <li id="PowerQualified">
        <a href="${ctx}/record/cuCountyPowerQualified/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=23">
            有电用达标情况统计表
        </a>
    </li>
    <%--24--%>
    <li id="NoPowerHouse">
        <a href="${ctx}/record/cuCountyNoPowerHouse/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=24">
            未接通生活用电户名单
        </a>
    </li>
    <%--25--%>
    <li id="Hospital">
        <a href="${ctx}/record/cuCountyHospital/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=25">
            县辖区公立医院情况表
        </a>
    </li>
    <%--26--%>
    <li id="Health">
        <a href="${ctx}/record/cuCountyHealthCenter/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=26">
            乡镇卫生院情况表
        </a>
    </li>

    <%--27--%>
    <li id="VillageClinic">
        <a href="${ctx}/record/cuCountyVillageClinic/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=27">
            行政村卫生室情况表
        </a>
    </li>
    <%--28--%>
    <li id="OfficeBulletinBoard/">
        <a href="${ctx}/record/cuCountyOfficeBulletinBoard/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=28">
            行政村办公场所宣传栏情况
        </a>
    </li>
    <%--29--%>
    <li id="EntertainmentVenues">
        <a href="${ctx}/record/cuCountyEntertainmentVenues/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=29">
            行政村有篮球场等活动场所情况
        </a>
    </li>
    <%--30--%>
    <li id="Networking">
        <a href="${ctx}/record/cuCountyNetworking/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=30">
            行政村通网络宽带情况统计表
        </a>
    </li>
    <%--31--%>
    <li id="TelevisionInternet">
        <a href="${ctx}/record/cuCountyTelevisionInternet/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=31">
            农户能看电视或上网情况统计
        </a>
    </li>
    <%--32--%>
    <li id="NoTelevisionInternet">
        <a href="${ctx}/record/cuCountyNoTelevisionInternet/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=26">
            未有电视机、智能手机上网名单
        </a>
    </li>

        <%--33--%>
        <li id="LowIncome">
            <a href="${ctx}/record/cuCountyLowIncomeInfo/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=33">
                农村低保户情况统计表
            </a>
        </li>
        <%--34--%>
        <li id="EndowmentInsurance">
            <a href="${ctx}/record/cuCountyEndowmentInsurance/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=34">
                养老保险参保情况统计表
            </a>
        </li>
        <%--35--%>
        <li id="NoEndowmentInsurance">
            <a href="${ctx}/record/cuCountyNoEndowmentInsurance/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=35">
                养老保险未参保人员名单
            </a>
        </li>
        <%--36--%>
        <li id="PovertyIncidence">
            <a href="${ctx}/record/cuCountyPovertyIncidence/form?cuMainId=${cuTable.cuMainId}&year=${cuTable.year}&type=36">
                县贫困发生率统计表
            </a>
        </li>
</ul>

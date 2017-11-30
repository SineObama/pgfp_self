<%@page pageEncoding="UTF-8"%>
<ul class="content-nav">
    <li id="coCountryYearNav"><a href="${ctx}/co/coCountryYear/form?id=${not empty coMain ? coMain.coId : coCountryYear.id}">村名与年度</a></li>
    <li id="coCharacterIndustryNav"><a href="${ctx}/co/coCharacterIndustry/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=1">特色产业情况统计表</a></li>
    <li id="coPoorHouIndustryNav"><a href="${ctx}/co/coPoorHouIndustry/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=2">贫困户产业登记表</a></li>
    <li id="coLaborOutNav"><a href="${ctx}/co/coLaborOut/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">贫困户劳动力统计表</a></li>
    <li id="coLaborSituationNav"><a href="${ctx}/co/coLaborSituation/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">贫困户劳动力情况表</a></li>
    <li id="coHouseSecurityNav"><a href="${ctx}/co/coHouseSecurity/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=5">住房保障达标情况统计表</a></li>
    <li id="coHouseSituationNav"><a href="${ctx}/co/coHouseSituation/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">住房保障未达标户名单情况表</a></li>
    <li id="coPovertyRelocationNav"><a href="${ctx}/co/coPovertyRelocation/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=7">易地扶贫搬迁户住房保障情况表</a></li>
    <li id="coBuyMedicalInsuranceNav"><a href="${ctx}/co/coBuyMedicalInsurance/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=8">居民购买医疗或商业保险情况</a></li>
    <li id="coInsuranceNameListNav"><a href="${ctx}/co/coInsuranceNameList/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">未购买医疗或商业保险情况名单</a></li>
    <li id="coIllTreatmentNav"><a href="${ctx}/co/coIllTreatment/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">患病救治和补助报销情况统计</a></li>
    <li id="coChildHaveEducationNav"><a href="${ctx}/co/coChildHaveEducation/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=11">适龄儿童接受义务教育</a></li>
    <li id="coNoEducationNav"><a href="${ctx}/co/coNoEducation/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=12">适龄儿童未接受义务教育</a></li>
    <li id="coPoorStudentPolicyNav"><a href="${ctx}/co/coPoorStudentPolicy/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=13">学生享受教育精准扶贫政策</a></li>
    <li id="coSafeDrinkNav"><a href="${ctx}/co/coSafeDrink/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">安全饮水达标情况统计</a></li>
    <li id="coDrinkSituationNav"><a href="${ctx}/co/coDrinkSituation/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">未达到安全饮水户名单</a></li>
    <li id="coRoadSituationNav"><a href="${ctx}/co/coRoadSituation/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">通硬化路情况表</a></li>
    <li id="coTwentyRoadNav"><a href="${ctx}/co/coTwentyRoad/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">20户以上通路情况表</a></li>
    <li id="coHaveElectricNav"><a href="${ctx}/co/coHaveElectric/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=18">村有电用达标情况统计表</a></li>
    <li id="coNoElectricNav"><a href="${ctx}/co/coNoElectric/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=19">全村未接通生活用电户名单</a></li>
    <li id="coCultureSituationNav"><a href="${ctx}/co/coCultureSituation/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">篮球场，文化室或戏台情况表</a></li>
    <li id="coNetworkNav"><a href="${ctx}/co/coNetwork/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">通网络宽带情况表</a></li>
    <li id="coEndowmentInsuredNav"><a href="${ctx}/co/coEndowmentInsured/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=22">城乡居民养老保险参保情况</a></li>
    <li id="coNoEndowmentInsuredNav"><a href="${ctx}/co/coNoEndowmentInsured/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=23">城乡居民养老保险未参保名单</a></li>
    <li id="coAllowancesNav"><a href="${ctx}/co/coAllowances/form?coMain.coId=${not empty coMain ? coMain.coId : coCountryYear.id}&coMain.type=24">贫困户纳入农村低保情况</a></li>
    <li id="coTvOnlineNav"><a href="${ctx}/co/coTvOnline/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">农户能看电视或上网情况统计表</a></li>
    <li id="coDigitalCountNav"><a href="${ctx}/co/coDigitalCount/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">未有数码设备名单</a></li>
    <li id="coIncidenceOfPovertyNav"><a href="${ctx}/co/coIncidenceOfPoverty/form?coId=${not empty coMain ? coMain.coId : coCountryYear.id}&countryId=${countryId}">贫困发生率统计表</a></li>
</ul>

<script type="text/javascript">
    $(function () {
        $("#"+"${tableName}"+"Nav").addClass("active")
        $("#"+"${tableName}"+"Nav a").removeAttr("href")
    })
</script>
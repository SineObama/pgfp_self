<%@ taglib prefix="html" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/16
  Time: 20:42
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>贫困村脱贫摘帽认定分析表</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
    <script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
    <script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
    <link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>


    <script type="text/javascript">
        $(document).ready(function () {

        });
    </script>
    <style>
        .inputType{
            width:80px !important;
            height: 30px !important;
            border-bottom: inherit !important;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="">贫困村脱贫摘帽认定分析表</a></li>
    <li class="active"><a
            href="">贫困村脱贫摘帽认定分析表${not empty basePoorerRegCard.id?'修改':'添加'}</a></li>
</ul>
<div class="header">
    <a href="" class="header-lt">贫困村脱贫摘帽认定分析表</a>
</div>
<div class="content tabs f-clear">
    <div id="tab-1" class="content-detail">
            <sys:message content="${message}"/>
            <br/>
        <form:form id="inputForm" modelAttribute="countryIdentification" action="${ctx}/report/countryIdentification/save" method="post" class="form-horizontal">
                <%--<form:hidden path="id"/>
                <sys:message content="${message}"/>--%>
                <br/>
                <table style="border: 0px #FFFFFF; width: 1000px;" class="table">
                    <tbody>
                    <tr style="border: 0px #FFFFFF; ">
                        <td class="sec-td bg-white" colspan="2" style="border: 0px #FFFFFF;">
                        <div class="control-group" style="float: left;border-bottom: 0px;">
                            <label class="control-label" style="font-size: 12px;font-family: 'Microsoft Yahei',arial;font-weight: lighter;">村名:</label>
                            <div class="controls">
                                <sys:treeselect id="country" name="country.id" value="${basePoorerRegCard.country.id}"
                                                labelName="country.name" labelValue="${basePoorerRegCard.country.name}"
                                                title="村（屯）" url="/sys/area/treeData" extId="${country.id}" cssClass="" allowClear="true"/>
                            </div>
                        </div>
                    </td>

                        <td class="sec-td bg-white" style="border: 0px #FFFFFF; text-align: right;">全村农户</td>

                        <td class="sec-td bg-white" style="border: 0px #FFFFFF;">

                        </td>
                    </tr>
                    <tr>
                        <td style="">
                            序号
                        </td>
                        <td style="">
                            指标
                        </td>
                        <td style="">
                            目标值
                        </td>
                        <td style="">
                            现状情况
                        </td>
                        <td>
                            指标难度分析
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            1
                        </td>
                        <td class="sec-td bg-white">
                            有特色产业
                        </td>
                        <td class="sec-td bg-white">
                            以行政村为单位，同时满足以下两项条件：
                            <br>
                            （1）有1-3个特色产业（在该县确定的2-5个特色产业中选定），且覆盖全村60%以上（含）贫困户
                            （无劳动能力或者主要劳动力长期外出务工的贫困户除外）。
                            <br>
                            （2）有农民合作社等新型农业经营主体或有产业基地（园）覆盖

                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            [1.特色产业名称:<input type="text" class="inputType"/> <br/>
                            2.全村贫困户<input type="text" class="inputType"/>户，有特色产业贫困户
                            <input type="text"  class="inputType"/>户，无劳动能力或主要劳动力长期外出务工贫困户<input type="text"  class="inputType"/>户，
                            特色产业覆盖贫困户比例为<input type="text"  class="inputType"/>%。<br/>
                            3.农民合作社等新型农业经营主体或产业基地(园)名称：<input type="text"  class="inputType"/><br/>
                            4.其他情况：<input type="text"  class="inputType"/>]<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            2
                        </td>
                        <td class="sec-td bg-white">
                            有稳固房住
                        </td>
                        <td class="sec-td bg-white">
                            （1）行政村内98%以上（含）农户有钢混、砖混、砖木、土木或者木制结构的住房，房屋主体稳固安全[按照《广西壮族自治区农村危房评定技术导则（试行）》评定，达到房屋安全A、B级标准]，人均建筑面积13平方米以上（含）（包括厅堂、厨房、卫生间等生活用房面积），属新建住房（含危旧房改造）的，达到入住的基本条件（安装好门、窗等）。
                            <br>
                            （2）易地扶贫搬迁户，属集中安置的，房屋质量合格并达到入住基本条件（安装好水、电、门、窗等），且已正式交付钥匙；属分散安置的，房屋质量合格并已搬迁入住。
                            <br>
                            备注：父母与子女拆户分户的，按父母与子女住房总面积预算，人均达到13平方米以上（含）稳固住房的，视为有住房保障。
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (1.全村农户<input type="text" class="inputType"/>户 <br/>
                            其中：有住房保障的<input type="text" class="inputType"/>户，占
                            <input type="text"  class="inputType"/>%<br/>
                            2.易地扶贫搬迁的<input type="text"  class="inputType"/>户，
                            有住房保障的<input type="text"  class="inputType"/>户。
                            其中：属于集中安置的，房屋质量合格已达到入住基本条件且交钥匙<input type="text"  class="inputType"/>户；
                            属于分散安置的，房屋质量合格并已搬迁入住<input type="text"  class="inputType"/>户。<br/>
                            3.其他情况：<input type="text"  class="inputType"/>)
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            3
                        </td>
                        <td class="sec-td bg-white">
                            有基本医疗保障
                        </td>
                        <td class="sec-td bg-white">
                            （1）行政村内98%以上（含）农村居民参加当年城乡居民基本医疗保险（含大病保险）或者商业保险等。
                            <br>
                            （2）贫困人口患病（含慢性病、地方病等大病）就医能得到有效治疗，医疗费在政策规定范围内能得到补助报销，能看得上病、看得起病。
                            <br>
                            （3）医疗救助政策得到有效落实。
                            <br>
                            备注：购买商业保险，且购买金额和报销比例等于或高于城乡居民基本医疗保险的，视为有基本医疗保障。
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (1.全村农村居民<input type="text" class="inputType"/> 人。其中：参加当年城乡居民基本医疗保险
                            <input type="text" class="inputType"/>人，参加商业保险且购买金额和报喜哦啊比例等于或高于城乡居民基本医疗保险
                            <input type="text" class="inputType"/>人，两项合计共<input type="text" class="inputType"/>人，
                            占<input type="text" class="inputType"/>%<br/>
                            2.落实医疗救助政策<input type="text" class="inputType"/>
                            <input type="text"  class="inputType"/>户，无劳动能力或主要劳动力长期外出务工贫困户<input type="text"  class="inputType"/>户，
                            特色产业覆盖贫困户比例为<input type="text"  class="inputType"/>%。<br/>
                            3.其他情况：<input type="text"  class="inputType"/>)<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            4
                        </td>
                        <td class="sec-td bg-white">
                            有义务教育保障
                        </td>
                        <td class="sec-td bg-white">
                            （1）行政村内适龄儿童少年能接受义务教育且没有因经济困难原因缀学。
                            <br>
                            （2）教育扶贫政策得到有效落实。
                            <br>
                            备注：适龄儿童少年，九年义务教育阶段非因经济困难原因缀学的，家长、教育部门、帮扶联系人要积极主动耐心做好儿童少年的动员劝返工作，教育部门、帮扶联系人入户次数要达到2次以上（含），经动员劝返仍不愿返校的，须家长（监护人）、学校、帮扶联系人“三方”共同签字确认。

                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (1.全村适龄儿童少年:<input type="text" class="inputType"/>人，按接受义务教育的适龄儿童少年，
                            未能正常上学的义务教育阶段适龄儿童少年<input type="text" class="inputType"/>人，
                            未能正常上学的原因<input type="text" class="inputType"/>。<br/>
                            2.落实教育扶贫政策：<input type="text" class="inputType"/><br/>
                            3.其他情况：<input type="text"  class="inputType"/>)<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            5
                        </td>
                        <td class="sec-td bg-white">
                            有硬化路
                        </td>
                        <td class="sec-td bg-white">
                            （1）行政村村委会或行政村中心学校所在地就近连接上级路网或其他乡镇路网，同行政村的道路达到硬化（沥青/水泥）要求，原则上路基宽度不小于6.5米、路面宽度不小于4.5米。20户以上（含）的自然村（屯）通沙石路以上（含）的路，路面宽度不小于3.5米，机动车能通行。
                            <br>
                            （2）位于自然保护区范围内的道路建设按自然保护区相关规定执行
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (1.行政村通<input type="text" class="inputType"/>硬化路。<br/>
                            2.道路路基宽<input type="text" class="inputType"/>米，路面宽<input type="text" class="inputType"/>米。<br/>
                            3.20户以上(含)的自然村(屯)<input type="text" class="inputType"/>个，
                            其中通砂石路以上(含)的自然村(屯)<input type="text" class="inputType"/>个，其中通砂石路以上(含)且路面宽
                            3.5米以上(含)的<input type="text" class="inputType"/>个。<br/>
                            4.其他情况：<input type="text"  class="inputType"/>)<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            6
                        </td>
                        <td class="sec-td bg-white">
                            有饮用水
                        </td>
                        <td class="sec-td bg-white">
                            行政村内98%以上(含)农户通过打井，建水柜、水窖，引用山泉水，自来水等方式解决饮水问题且达到安全用水标准。<br/>
                            备注：根据安全用水标准综合判定饮水达标情况：水质感官性状良好，无色、无异味或异臭，水体清洁干净，
                            经烧开饮用不会对健康造成不良影响，每人每天可获得的水量不低于35升，
                            人力取水往返时间不超过20分钟(可折算成去睡的水品距离不超过800米或垂直高不超过80米)，供水保证率不低于90%。
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            [1.全村农户<input type="text" class="inputType"/>户，其中打井<input type="text" class="inputType"/>
                            户，建水柜<input type="text" class="inputType"/>户，建水窖<input type="text" class="inputType"/>户，
                            引用山泉水<input type="text" class="inputType"/>户，自来水<input type="text" class="inputType"/>户，
                            其他方式<input type="text" class="inputType"/>户。<br/>
                            2.全村饮水安全<input type="text" class="inputType"/>户，占<input type="text" class="inputType"/>%。<br/>
                            3.其他情况：<input type="text"  class="inputType"/>]<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            7
                        </td>
                        <td class="sec-td bg-white">
                            有电用
                        </td>
                        <td class="sec-td bg-white">
                            行政村内98%以上(含)农户家中接通生活用电。
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            [1.全村农户<input type="text" class="inputType"/>户，其中接通生活用电<input type="text" class="inputType"/>户，
                            占<input type="text" class="inputType"/>%。
                            2.其他情况：<input type="text"  class="inputType"/>]<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            8
                        </td>
                        <td class="sec-td bg-white">
                            有公共服务设施
                        </td>
                        <td class="sec-td bg-white">
                            (1)行政村村委会有办公场所、宣传栏。<br/>
                            (2)行政村内有标准化卫生室(乡镇人民政府所在地的行政村可不设村卫生室)。<br/>
                            (3)行政村内有篮球场，有文化室(农家书屋)或戏台等。<br/>
                            (4)行政村村委会或行政村中心学校所在地通有线或无线网络宽带。<br/>
                            (5)城乡居民养老保险参保率90%以上(含)，60周岁以上(含)参保老年人100%享受养老保险待遇。<br/>
                            (6)符合当地农村低保条件的贫困户纳入农村低保范围。
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (1.公共服务设施:<input type="checkbox"/>有办公场所；<input type="checkbox"/>有宣传栏；<input type="checkbox"/>
                            有卫生室；<input type="checkbox"/>有篮球场；<input type="checkbox"/>有文化室(农家书屋);<input type="checkbox"/>有戏台；
                            <input type="checkbox"/>其他<br/>
                            2.网络接通点：<input type="checkbox"/>村委会所在地；<input type="checkbox"/>村中心学校所在地。
                            3.城乡居民养老保险参保率为<input type="text" class="inputType"/>%，60周岁以上(含)参保老年人享受养老保险待遇比例为
                            <input type="text" class="inputType"/>。<br/>
                            4.符合当地农村低保条件的贫困户<input type="text" class="inputType"/>户，
                            其中纳入农村低保<input type="text" class="inputType"/>户。<br/>
                            5.其他情况：<input type="text"  class="inputType"/>]<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            9
                        </td>
                        <td class="sec-td bg-white">
                            有电视看
                        </td>
                        <td class="sec-td bg-white">
                            行政村内98%农户有电视机或电脑或智能手机，能收看中央和广西电视频道或上网，了解中央和自治区方针政策、新闻信息。
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (1.全村农户:<input type="text" class="inputType"/>户，其中有电视看或者有电脑上网或有只能手机上网<input type="text" class="inputType"/>户。 <br/>
                            2.其他情况：<input type="text"  class="inputType"/>)<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            10
                        </td>
                        <td class="sec-td bg-white">
                            有村集体经济收入
                        </td>
                        <td class="sec-td bg-white">
                            (1)行政村有村民合作社，依托村级集体所有的资源、资产和资金，采取自主经营、合作经营、入股、租赁、劳务服务等形式，获得稳定的收入。<br/>
                            (2)2017年村集体经济收入达2万元以上(含)并逐年提高，到2020年达5万元以上(含)。

                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (1.村民合作社名称:<input type="text" class="inputType"/> <br/>
                            2.村集体经济收入<input type="text" class="inputType"/>元。<br/>
                            3.其他情况：<input type="text"  class="inputType"/>)<br/>
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            11
                        </td>
                        <td class="sec-td bg-white">
                            有好的“两委”班子
                        </td>
                        <td class="sec-td bg-white">
                            (1)行政村“两委”班子能较好地履行职责，较好的完成脱贫攻坚任务。<br/>
                            (2)“两委”班子没有自治区党委组织部《关于印发（推行农村基层党组织“星级化”管理的方案）的通知》（桂组通字[2016]32号）中所列举软弱涣散村党组织的12种情形，或者已经整顿到位
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (<input type="checkbox"/>1.无软弱涣散党组织的情形；
                            <input type="checkbox"/><br/>2.有软弱涣散村党组织的情形
                            <input type="text"  class="inputType"/>,但已整顿到位，
                            整顿情况：<input type="checkbox"/>良好，<input type="checkbox"/>较好)。
                            未达标<input type="checkbox"/>
                            (原因:<input type="checkbox"/>1.无软弱涣散党组织的情形；
                            <input type="checkbox"/>，且整顿不到位，整顿情况
                            <input type="checkbox"/>一般，<input type="checkbox"/>较差。<br/>
                            <input type="checkbox"/>其他情况：<input type="text" class="inputType"/> )
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="sec-td bg-white">
                            12
                        </td>
                        <td class="sec-td bg-white">
                            贫困率发生率低于3%
                        </td>
                        <td class="sec-td bg-white">
                            贫困发生率低于国家规定的3%标准
                        </td>
                        <td class="sec-td bg-white">
                            达标<input type="checkbox" />
                            (全村人口<input type="text" class="inputType"/>人，剩余贫困人口<input type="text" class="inputType"/>人，贫困发生率为<input type="text" class="inputType"/>%)
                            未达标<input type="checkbox"/>
                            (原因:<input type="text"  class="inputType"/>)
                        </td>
                        <td  class="sec-td bg-white">
                            <input type="text"/>
                        </td>
                    </tr>

                    </tbody>
                </table>

                <div class="content-save">
                    <shiro:hasPermission name="record:basePoorerRegCard:edit">
                        <input id="btnSubmit" class="save-btn" style="margin-right:30px !important;" type="submit" value="保 存"/>
                    </shiro:hasPermission>
                    <input id="btnCancel" class="btn" type="button" style="margin-right:30px !important;" value="返 回" onclick="history.go(-1)"/>
                </div>
            </form:form>

    </div>
</div>


</body>
</html>

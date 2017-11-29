<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
	<title>贫困县脱贫摘帽认定表</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			// 页面进入时 判断
//			if($(".db-btn").attr("checked")){
//				$(".db-btn").attr("checked",false);
//				clearChoose($(".dbWrapper-content"));
//				addChoose($(".wdbWrapper-content"));
//			}
//			if($(".wdb-btn").attr("checked")){
//				$(".db-btn").attr("checked",false);
//				clearChoose($(".dbWrapper-content"));
//				addChoose($(".wdbWrapper-content"));
//			}
//			// 取消next的checkbox选中和value值
//			function clearChoose(){
//				$(this).parent("span").next().find("input").val("").attr({"disabled":true,"checked":false})
//			}
//			// 重置当前点击的内容disabled
//			function addChoose(){
//				$(this).parent("span").next().find("input").val("").attr({"disabled":false})
//			}
//			$(".db-btn").click(function(){
//				if($(this).attr("checked")){
//					$(this).parents("td").find(".wdb-btn").attr("checked",false);
//					addChoose();
//					clearChoose();
//				}else{
//					clearChoose($(".dbWrapper-content"));
//				}
//			})
//			$(".wdb-btn").click(function(){
//				if($(this).attr("checked")){
//					$(".db-btn").attr("checked",false);
//					clearChoose($(".dbWrapper-content"));
//					addChoose($(".wdbWrapper-content"));
//				}else{
//					clearChoose($(".wdbWrapper-content"));
//				}
//			})
			/**
			 * 达标未达标的取消选中
			 * @param .db-btn 达标按钮
			 * @param .wdb-btn 未达标按钮
			 */
			$(".db-btn").click(function(){
				if($(this).attr("checked")){
					$(this).parents("td").find(".wdb-btn").attr("checked",false);
				}
			})
			$(".wdb-btn").click(function(){
				if($(this).attr("checked")){
					$(this).parents("td").find(".db-btn").attr("checked",false);
				}
			})
		})
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

		.line-bottom{
			border-bottom:1px solid black;
		}

		.margin-left{
			margin-left:60px;
		}

		.all-border{
			border:1px solid black;
			width:40px;
			height:24px;
			margin:3px;
		}

		.text-center{
			text-align:center !important;
		}

		.font-style-header{
			font-size: 16px;
			font-weight: bold;
		}
		.font-light-content{
			font-size: 14px;
			font-weight: bold;
		}
		span{
			padding: 0 2px;
		}
		.content-detail .line-bottom>input{
			width: auto!important;
		}
		.content-save{
			padding-right: 160px;
		}
		.content-save input{
			width: 66px;
			height: 30px;
			box-sizing: border-box;
			margin: 0 0 0 20px;

		}
	</style>
</head>
<body>
<br/>
<div style="font-size: 20px;color: #4882ab;font-weight: bold;">
	<center>贫困县脱贫摘帽认定表</center>
	<a href="${ctx}/report/poorCountyIdentification/reports?flash=true&&years=${poorCountyIdentification.years}" style="background: #6196bb;color: #fff;text-shadow: none;margin-left: 50px;float: right;margin-right: 110px" class="btn btn-primary">点击重新生成报表</a>
</div>

<div class="content tabs f-clear">
	<center>
		<div class="content-detail" style="max-width:1200px !important;float:none !important;border-left:none !important;margin-bottom:20px;">
			<br/>
			<table class="noBlock" style="width:100% !important;">
				<tbody id="accpitem" class="accpitem">
				<tr class="noBlock" style="height: 60px;">
					<td colspan="4" class="noBlock">
						<%--<span class="line-bottom" style="padding:2px 10px;">大平瑶族</span>乡--%>
						<%--<span class="line-bottom" style="padding:2px 10px;">大平</span>村民小组自然村屯--%>
						<%--<span class="line-bottom" style="padding:2px 10px;">大平村平街村屯桂新村民小组自然村</span>屯--%>
						<form:form id="inputForm" modelAttribute="poorCountyIdentification" action="${ctx}/report/poorCountyIdentification/save" method="post" class="form-horizontal" style="text-align:center">
						<span class="line-bottom" style="padding:2px 10px;">贺州</span>市
						<span class="line-bottom" style="padding:2px 10px;">平桂</span>县（市、区）
						<span class="margin-left">脱贫年度：</span><span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path=""/></span><span>年</span><br>
						<span class="margin-left">全县农户：</span><span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path="totalHou" class="int"/></span><span>万户</span><span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path="totalPer" class="int"/></span><span>万人</span>
						其中：贫困户<span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path="poorHou" class="int"/></span>万户<span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path="poorPer" class="int"/></span><span>万人</span>
					</td>
				</tr>
				<tr class="tr">
					<td width="10%!important;" class="font-style-header">序号</td>
					<td width="10%!important" class="font-style-header">托贫指标</td>
					<td width="40%!important" class="font-style-header">验收标准</td>
					<td width="40%!important;" class="font-style-header">认定情况</td>
				</tr>
				<tr class="record bg-white">
					<td class="text-center">1</td>
					<td class="text-center font-light-content">
						<strong>有特色产业</strong>
					</td>
					<td>
						以县为单位，同时满足以下两项条件：<br/>
						（1）有 2—5 个特色产业，特色产业覆盖贫困 户比例达 60%以上（含）（无劳动能力或主要劳动 力长期外出务工的贫困户除外）。<br/>
						（2）县内所有贫困村均有农民合作社等新型农 业经营主体或有产业基地（园）覆盖。<br>
					</td>
					<form:hidden path="id"/>
					<sys:message content="${message}"/>
					<td>
						达标<span><form:checkbox path="characterSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							〔1.特色产业名称：<span class="line-bottom"><form:input path="characterName" style="width:340px!important"/></span>。<br>
							2.全县贫困户<span class="line-bottom"><form:input path="countyPoorHou" style="width:50px!important"/></span>
							万户，有特色产业贫困户 <span class="line-bottom"><form:input path="characterPoorHou" style="width:50px!important"/></span>
							户，无劳动能力或主要劳动力长期外出务工贫困户<span class="line-bottom"><form:input path="noOrOutWorker" style="width:50px!important"/></span>
							户，特色产业覆盖贫困 户比例为 <span class="line-bottom"><form:input path="characterPercent" style="width:50px!important"/></span>
							。<br/>
							3.全县贫困村<span class="line-bottom"><form:input path="countyPoorCountry" style="width:50px!important"/></span>
							个，有农民合作社等新型农 业经营主体或有产业基地（园）覆 盖的贫困村<span class="line-bottom"><form:input path="cooperativeCountry" style="width:50px!important"/></span>
							个。<br/>
							4. 其他情况：<span class="line-bottom"><form:input path="o1Other"/></span>〕。
						</div>
						未达标<span><form:checkbox path="characterSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							（原因:<span class="line-bottom"><form:input path="o1Reason"/></span>）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">2</td>
					<td class="text-center font-light-content">
						<strong>有住房保障</strong>
					</td>
					<td>
						（1）全县 98%以上（含）农户有钢混、砖混砖木、土木或木制结构的住房，房屋主体稳固安全〔按照《广西壮族自治区农村危房评定技术导则（试行）》评定，
						达到房屋安全 A、B 级标准〕，人均建筑面积 13 平方米以上（含）（包括厅堂、厨房、卫生间等生活用房面积），属新建住房（含危旧房改造）的，达到入住基本条件（安装好门、窗等）。
						（2）易地扶贫搬迁户，属集中安置的，房屋质量合 格并达到入住基本条件（安装好水、电、门、窗等）， 且已正式交付钥匙；属分散安置的，房屋质量合格并已搬迁入住。<br/>
						（3）2017  年贫困户存量危房改造率达 90%以上（含）并逐年提高，到 2020 年达到100%。<br/>
						　　<strong>备注：</strong>父母与子女拆户分户的，按父母与子女住房总面积测算，人均达到 13 平方米（含）以上稳固住房的，视为有住房保障。
					</td>
					<td>
						达标<span><form:checkbox path="houseSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							(1.全县农户<span class="line-bottom"><form:input path="countyFarmerHou1" style="width:50px!important"/></span>万户，其中有住房保障的<span class="line-bottom"><form:input path="houseHou" style="width:50px!important"/></span>
							户，占<span class="line-bottom"><form:input path="housePercent" style="width:50px!important"/></span>
							%。<br/>
							2.异地扶贫搬迁的<span class="line-bottom"><form:input path="relocationHou" style="width:50px!important"/></span>
							户，有住房保障的<span class="line-bottom"><form:input path="relocationHouseHou" style="width:50px!important"/></span>
							户。其中：属于集中安置的，房屋质量合格已达到入住基本条件且交钥匙 <span class="line-bottom"><form:input path="focusHou" style="width:50px!important"/> </span>户；属于分散安置的，房屋质量合格并已搬 迁入住 <span class="line-bottom"><form:input path="dispersedHou" style="width:50px!important"/></span>
							户。<br/>
							3.贫困户存量危房改造率为<span class="line-bottom"><form:input path="reconstruction" style="width:50px!important"/></span>
							%。<br/>
							4.其他情况：<span class="line-bottom"><form:input path="o2Other"/></span>。】 <br/>
							未达标<span><form:checkbox path="houseSta" value="0" class="wdb-btn"/></span>
						</div>
						<div class="wdbWrapper-content">
							（原因:<span class="line-bottom"><form:input path="o2Reason"/></span>）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">3</td>
					<td class="text-center font-light-content">
						<strong>有基本医疗保障</strong>
					</td>
					<td>
						（1）全县 98%以上（含）农村居民参加当年城乡居民基本医疗保险（含大病保险）或商业保险等。<br/>
						（2）患病（含慢性病、地方病等大病）就医能得到有效治疗，医疗费在政策规定范围内能得到补助报销，能看得上病，看得起病,医疗救助政策得到有效落实。<br/>
						（3）贫困户因病致（返）贫问题基本解决。 <br/>
						<strong>　　备注：</strong>购买商业保险，且购买金额和报销比例等于或高于城乡居民基本医疗保险的，视为有基本医疗保障。
					</td>
					<td>
						达标<span><form:checkbox path="medicalSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							〔1.全县农村居民<span class="line-bottom"><form:input path="countyFarmerPer" style="width:95px!important"/></span>
							人。其中：参加当年城乡居民基本医疗保险<span class="line-bottom"><form:input path="medicalPer" style="width:50px!important"/></span>
							人，参加其他商业保险，且购买金额和报销比例等于或高于城乡居民基本医疗保险<span class="line-bottom"><form:input path="commercialInsurance" style="width:50px!important"/></span>
							人，两项合计共<span class="line-bottom"><form:input path="medicalAndCommercial" style="width:50px!important"/></span>
							人，占<span class="line-bottom"><form:input path="insurancePercent" style="width:50px!important"/></span>
							%。<br/>
							2.落实医疗救助政策：<span class="line-bottom"><form:input path="medicalHelp"/></span><br/>
							3.其他情况：<span class="line-bottom"><form:input type="text" path="o3Other"/></span>
							。〕
						</div>
						未达标<span><form:checkbox path="medicalSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							（原因：<span class="line-bottom"><form:input type="text" path="o3Reason"/></span>
							）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">4</td>
					<td class="text-center font-light-content">
						<strong>有义务教育保障</strong>
					</td>
					<td>
						（1）有健全的中小学（幼儿园）教育发展保障体系、健全的师资队伍、完善的贫困学生资助体系。<br>
						（2）全县适龄儿童少年能接受义务教育且没有因经济困难原因辍学，教育扶贫政策得到有效落实。<br>
						（3）2017 年全县义务教育巩固率达 90%以上（含）并逐年提高，到 2020 年达 93%以上（含）。<br>
						<strong>　　备注：</strong>适龄儿童少年，九年义务教育阶段非因经济困难原因辍学的，家长、教育部门、帮扶联系人要积极主动耐心做好儿童少年的动员劝返工作，教育部门、帮扶联系人入户次数要达到2次以上（含），经动员劝返仍不愿返校的，须家长（监护人）、学校、帮扶联系人“三方”共同签字确认。
					</td>
					<td>
						达标<span><form:checkbox path="educationSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							〔1.<span><form:checkbox path="haveSoundSchool" value="1" class="db-btn"/></span>
							有健全的中小学（幼儿园）教育发展保障体系、健全的师资队伍、完善的贫困学生资助体系。<br/>
							2.全县适龄儿童少年 <span class="line-bottom"><form:input path="schoolAgeChild" style="width:50px!important"/></span>
							人，按受义务教育的适龄儿童少年 <span class="line-bottom"><form:input path="atSchoolNumber" style="width:50px!important"/></span>
							人，未能正常上学的义务教育阶段适龄儿童少年  <span class="line-bottom"><form:input path="noAtSchoolNumber" style="width:50px!important"/></span>
							人，原因 <span class="line-bottom"><form:input path="noAtSchoolReason"/></span><br/>
							3.落实教育扶贫政策：<span class="line-bottom"><form:input path="educationHelp"/></span><br/>
							4.全县义务教育巩固率为<span class="line-bottom"><form:input path="eduConsolidation" style="width:50px!important"/></span>
							%。<br/>
							5.其他情况<span class="line-bottom"><form:input type="text" path="o4Other"/></span>
							。〕
						</div>
						未达标<span><form:checkbox path="educationSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							(原因：<span class="line-bottom"><form:input type="text" path="o4Reason"/></span>。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">5</td>
					<td class="text-center font-light-content">
						<strong>有安全饮水</strong>
					</td>
					<td>
						全县 98%以上（含）农户通过打井，建水柜、 水窖，引用山泉水，自来水等方式解决饮水问题且 达到安全用水标准。
						<strong>　　备注：</strong>根据安全用水标准综合判定饮水达标情况：水质感官性状良好，无色、无异味或异臭，水体清洁干净，经烧开饮用不会对健康造成不良影响，每人每天可获得的水量不低于35升，人力取水往返时间不超过20分钟（可折算成取水的水平距离不超过800米或垂直高差不超过80米），供水保证率不低于90%。
					</td>
					<td>
						达标<span><form:checkbox path="drinkSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							（1.全县农户<span class="line-bottom"><form:input path="countyFarmerHou2" style="width:50px!important"/></span>
							户，其中解决饮水问题且达到安全用水标准的<span class="line-bottom"><form:input path="safetyDrinkHou" style="width:50px!important"/></span>
							户，占<span class="line-bottom"><form:input path="safetyDrinkPercent" style="width:50px!important"/></span>
							%。<br/>
							2.其他情况：<span class="line-bottom"><form:input type="text" path="o5Other"/></span>
							。）
						</div>
						未达标<span><form:checkbox path="drinkSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							（原因：<span class="line-bottom"><form:input type="text" path="o5Reason"/></span>
							）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">6</td>
					<td class="text-center font-light-content">
						<strong>有路通村屯</strong>
					</td>
					<td>
						（1）全县 98%以上（含）行政村村委会或行政村中心学校所在地就近连接上级路网或其他乡镇路网，通行政村的道路达到硬化（沥青/水泥）要求，原则上路基宽度不小于 6.5 米、路面宽度不小于米。20 户以上（含）的自然村（屯）通砂石路以上（含）的路，路面宽度不小于 3.5 米，机动车能通行。
						（2）位于自然保护区范围内的道路建设按自然保护区相关规定执行。
					</td>
					<td>
						达标<span><form:checkbox path="roadSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							（1.全县行政村<span class="line-bottom"><form:input path="totalCountry" style="width:50px!important"/></span>
							个，其中通硬化路的行政村<span class="line-bottom"><form:input path="roadCountry" style="width:50px!important"/></span>
							个，占<span class="line-bottom"><form:input path="roadPercent" style="width:50px!important"/></span>
							%。其中通砂石路以上（含）的<form:input path="gravelRoad" style="width:50px!important"/>个<br/>
							2.20户以上（含）的自然村（屯）<span class="line-bottom"><form:input path="twentyHouNumber" style="width:50px!important"/></span>
							个。<br/>
							3.其他情况：<span class="line-bottom"><form:input type="text" path="o6Other"/></span>。）
						</div>
						未达标<span><form:checkbox path="" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							(原因：<span class="line-bottom"><form:input type="text" path="o6Reason"/></span>
							）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">7</td>
					<td class="text-center font-light-content">
						<strong>有电用</strong>
					</td>
					<td>
						全县 98%以上（含）农户家中接通生活用电。
					</td>
					<td>
						达标<span><form:checkbox path="electSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							(1.全县农户<span class="line-bottom"><form:input path="countyFarmerHou3" style="width:50px!important"/></span>
							户，其中家中接通生活用电<span class="line-bottom"><form:input path="electHou" style="width:50px!important"/></span>
							户，占<span class="line-bottom"><form:input path="electPercent" style="width:50px!important"/></span>
							%。<br/>
							2.其他情况：<span class="line-bottom"><form:input type="text" path="o7Other"/></span>）。
						</div>
						未达标<span><form:checkbox path="electSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							（原因：<span class="line-bottom"><form:input type="text" path="o7Reason"/></span>
							）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">8</td>
					<td class="text-center font-light-content">
						<strong>有基本公共服务</strong>
					</td>
					<td>
						（1）全县至少有 1所二级及以上公立医院，辖区内所有乡镇有标准化卫生院，所有行政村有标准化卫生室（乡镇人民政府所在地的行政村可不设村卫生室）。<br/>
						（2）所有行政村村委会均有办公场所、宣传栏。<br/>
						（3）所有行政村内有篮球场，有文化室（农家书屋）或戏台等。<br/>
						（4）所有行政村村委会或行政村中心学校所在地通有线或无线网络宽带。<br/>
						（5）全县98%以上（含）农户有线电视或电脑或智能手机，能收看中央和广西电视频道或上网，了解中央和自治区方针政策、新闻信息。<br/>
					</td>
					<td>
						达标<span><form:checkbox path="publicServiceSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							（1.全县有<span class="line-bottom"><form:input path="publicHospital" style="width:50px!important"/></span>
							所二级及以上公立医院；有乡镇<span class="line-bottom"><form:input path="countyNumber" style="width:50px!important"/></span>
							个，其中有标准化乡镇卫生院的乡镇有<span class="line-bottom"><form:input path="hospitalCounty" style="width:50px!important"/></span>个；
							有行政村<span class="line-bottom"><form:input path="natureVillage" style="width:50px!important"/></span>
							个，其中有卫生室的行政村<span class="line-bottom"><form:input path="hospitalNatureVillage" style="width:50px!important"/></span>
							个，有办公室场所、宣传栏的行政村<span class="line-bottom"><form:input path="officeSpace" style="width:50px!important"/></span>
							个，有篮球场的行政村<span class="line-bottom"><form:input path="basketballSpace" style="width:50px!important"/></span>
							个，有文化室（农家书屋）或戏台等的行政村<span class="line-bottom"><form:input path="cultureSpace" style="width:50px!important"/></span>
							个，通有线或无线网络宽带的行政村<span class="line-bottom"><form:input path="network" style="width:50px!important"/></span>
							个。<br/>
							2.全县农户有<span class="line-bottom"><form:input path="countyFarmerHou4" style="width:50px!important"/></span>
							户，其中家中有电视机或电脑或智能手机<span class="line-bottom"><form:input path="digitalHou" style="width:50px!important"/></span>
							户，占<span class="line-bottom"><form:input path="digitalPercent" style="width:50px!important"/></span>
							%。<br/>
							3.其他情况：<span class="line-bottom"><form:input type="text" path="o8Other"/></span>）。
						</div>
						未达标<span><form:checkbox path="" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							（原因：<span class="line-bottom"><form:input type="text" path="o8Reason"/></span>
							）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">9</td>
					<td class="text-center font-light-content">
						<strong>有社会救助</strong>
					</td>
					<td>
						（1）农村低保标准达到或超过国家扶贫标准。符合当地农村低保条件的贫困户纳入农村低保范围。<br/>
						（2）城乡居民养老保险参保率90%以上（含），60周岁以上（含）参保老年人100%享受养老保险待遇。
					<td>
						达标<span><form:checkbox path="socialAssistanceSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							〔1.农村低保标准为 <span class="line-bottom"><form:input path="lowLivingStandard" style="width:50px!important"/></span>
							元。<br/>
							2.全县符合当地农村居民低保条件的贫困户<span class="line-bottom"><form:input path="complianceHou" style="width:50px!important"/></span>
							户，其中纳入农村低保的<span class="line-bottom"><form:input path="lowInsured" style="width:50px!important"/></span>户<br/>
							3.全县城乡居民养老保险参保率为<span class="line-bottom"><form:input path="endowmentInsurance" style="width:50px!important"/></span>
							%，60周岁以上（含）参保老年人享受养老保险待遇比例为<span class="line-bottom"><form:input path="sixtyYearPercent" style="width:50px!important"/></span>%
							。<br/>
							4.其他情况：<span class="line-bottom"><form:input type="text" path="o9Other"/></span>。〕
						</div>
						未达标<span><form:checkbox path="socialAssistanceSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							（原因：<span class="line-bottom"><form:input type="text" path="o9Reason"/></span>
							）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">10</td>
					<td class="text-center font-light-content">
						<strong>农村贫困发生率低于3%</strong>
					</td>
					<td>
						（1）贫困发生率低于国家规定的3%标准。<br/>
						（2）全县农村居民人均可支配收入年均增速高于全国平均水平。
					<td>
						达标<span><form:checkbox path="povertyRateSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
							〔1.全县乡村人口为<span class="line-bottom"><form:input path="allNumber" style="width:50px!important"/></span>
							人，剩余贫困人口<span class="line-bottom"><form:input path="allPoorNumber" style="width:50px!important"/></span>
							人，农村贫困发生率为<span class="line-bottom"><form:input path="povertyRate" style="width:50px!important"/></span>
							%。<br/>
							2.农村居民人均可支配收入年均增速为<span class="line-bottom"><form:input path="insertRate" style="width:50px!important"/></span>
							%）。<br/>
						</div>
						未达标<span><form:checkbox path="povertyRateSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
							（原因：<span class="line-bottom"><form:input type="text" path="o10Reason"/></span>
							）。
						</div>
					</td>
				</tr>


				<tr class="record bg-white">
					<td class="text-center">县级申请意见</td>
					<td colspan="3">
						<br><br>
						<div style="margin:40px 100px;">
						   <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;对照自治区制定的贫困县脱贫摘帽标准，经自评，本县（市、区）各项指标均达到
				                                脱贫摘帽标准，申请 <span class="line-bottom"><form:input path="" style="width:50px!important"/></span>年脱贫摘帽。 </span>
						</div>
						<div style="margin:80px 50px;">
							<span style="margin:50px 200px;"><form:input path="" style="width:50px!important"/></span>
							县（市、区）扶贫开发领导小组（盖章）
							<br>
							<div style="margin-top:15px;">
								<span style="margin-left:500px;">
									&nbsp;&nbsp;年
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
								</span>
							</div>
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">设区市 初审意见</td>
					<td colspan="3">
						<br><br>
						<div style="margin:80px 50px;">
							<span style="margin:50px 200px;"><form:input path="" style="width:50px!important"/></span>
							市扶贫开发领导小组（盖章）
							<br>
							<div style="margin-top:15px;">
								<span style="margin-left:500px;">
									&nbsp;&nbsp;年
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
								</span>
							</div>
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">自治区意见</td>
					<td colspan="3">
						<br><br>
						<div style="margin:40px 100px;">
						   <span >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  经自治区组成的联合工作组核查，该县各项脱贫摘帽指标均达到标准。经自治区扶
				                                贫开发领导小组研究，批准<span class="line-bottom"><form:input path="" style="width:50px!important"/></span> 	
				                                     县<span class="line-bottom"><form:input path="" style="width:50px!important"/></span> 	
				                                     年脱贫摘帽。
						</div>
						<div style="margin:80px 50px;">
							<span style="margin:50px 200px;"><form:input path="" style="width:50px!important"/></span>
							县（市、区）扶贫开发领导小组（盖章）
							<br>
							<div style="margin-top:15px;">
								<span style="margin-left:500px;">
									&nbsp;&nbsp;年
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
								</span>
							</div>
						</div>
					</td>
				</tr>
				</tbody>
			</table>
			<a style="margin-left:50px;">填表说明：此表一式 3 份，县扶贫办、设区市扶贫办、自治区扶贫办各执 1 份。</a>
			<a style="margin-right:10px;">广西壮族自治区扶贫开发领导小组印制</a>
		</div>
		<div class="content-save">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
			<input type="submit" value="提 交" class="save-btn">
		</div>

	</center>
	</form:form>
</div>
<script>

</script>
</body>

</html>
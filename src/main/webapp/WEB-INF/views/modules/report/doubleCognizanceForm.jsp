<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
	<title>贫困户脱贫摘帽“双认定”分析表</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}\ckeditor\adapters\jquery.js"></script>
	<script src="${ctxStatic}\pgfp\js\jquery.tabslet.min.js"></script>
	<link rel="stylesheet" href="${ctxStatic}\pgfp\css\style.css"/>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery.validate.method.js"></script>
	<script src="${ctxStatic}\jquery-validation\1.11.1\jquery-validate.bootstrap-tooltip.js"></script>
	<script type="text/javascript">
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
		$(document).ready(function(){
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
	<center>贫困户脱贫摘帽“双认定”分析表</center>
	<a href="${ctx}/report/doubleCognizance/reports?flash=true&&id=${doubleCognizance.regcardId}" style="background: #6196bb;color: #fff;text-shadow: none;margin-left: 50px;float: right;margin-right: 110px" class="btn btn-primary">点击重新生成报表</a>
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
						<form:form id="inputForm" modelAttribute="doubleCognizance" action="${ctx}/report/doubleCognizance/save" method="post" class="form-horizontal" style="text-align:center">
						住址：<span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 400px!important" path="country"/></span>
						<span class="margin-left">户主：</span><span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path="houseName"/></span><br>
						<span class="margin-left">人口：</span><span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path="familyNumber" class="int"/></span><span>人</span>
						　其中有劳动能力<span class="line-bottom" style="padding:2px 10px;"><form:input type="text" style="width: 50px!important" path="labNumber" class="int"/></span>人
						　贫困户属性：<form:radiobuttons   path="poorProperty"
												  items="${fns:getDictList('poor_households_attributes')}" itemLabel="label" itemValue="value"/>
					</td>

				</tr>
				<tr class="tr">
					<td width="30px;" class="font-style-header">序号</td>
					<td class="font-style-header">托贫指标</td>
					<td class="font-style-header">验收标准</td>
					<td width="300px;" class="font-style-header">分析情况</td>
				</tr>
				<tr class="record bg-white">
					<td class="text-center">1</td>
					<td class="text-center font-light-content">
						有收入来源
					</td>
					<td>
						（1）有劳动能力的家庭，具备下列条件之一的视为达标：
						①人均耕地0.5亩以上（含）,或人均旱地1亩以上（含），或人均经济林地1.5亩以上（含），或人均山林地5亩以上（含），通过耕作或流转获得了稳定的收入；
						②有经营场地（铺面）等，获得稳定的资产收入；
						③养殖有一定规模，获得稳定的收入；
						④家庭成员中有外出务工半年以上或者自主创业,获得稳定的收入；
						⑤有其他稳定的收入。
						<br>
						完全或部分丧失劳动能力、生活自理能力的家庭，享受农村低保政策（获得A类或B类低保金），有最低生活保障，视为有稳定的收入。
						<br>
						（2）不愁吃不愁穿。通过生产经营或购买获得主粮、副食、衣物，能满足日常生活需求。
					</td>
					<form:hidden path="id"/>
					<sys:message content="${message}"/>
					<td>
							达标<span><form:checkbox path="incomeSta" value="1" class="db-btn"/></span>
							<div class="dbWrapper-content">
								【1.收入来源：<span ><form:checkbox path="isfield" value="1"/></span>人均水田0.5亩以上（含），或人均旱地1亩以上（含），或人均经济林地1.5亩以上（含），或人均山林地5亩以上（含），通过耕作或流转获得了稳定的收入；
								<span ><form:checkbox path="isproduct" value="1"/></span>有经营场地（铺面）等，获得稳定的资产收入；
								<span ><form:checkbox path="isbreed" value="1"/></span>养殖有一定规模，获得稳定的收入；
								<span ><form:checkbox path="isworker" value="1"/></span>家庭成员中有外出务工半年以上或者自主创业,获得稳定的收入；
								<span ><form:checkbox path="isotherincome" value="1"/></span>有其他稳定的收入<span class="line-bottom"><form:input path="othertype"/></span><br>
								家庭成员享受低保政策（获得A类或B类低保金）的人数、姓名<span class="line-bottom"><form:input path="lowAllowSituation"/></span>
								<br>
								2.<form:checkbox path="foodAndClothing" value="1"/>不愁吃不愁穿。3.其他情况：<span class="line-bottom"><form:input path="o1Other"/></span>
								<br>
							</div>
							未达标<span><form:checkbox path="incomeSta" value="0" class="wdb-btn"/></span>
							<div class="wdbWrapper-content">
								（原因:</span><span class="line-bottom"><form:input path="o1Reason"/></span>）。
							</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">2</td>
					<td class="text-center font-light-content">
						有住房保障
					</td>
					<td>
						（1）有钢混、砖混、砖木、土木或木制结构的住房，房屋主体稳固安全〔按照《广西壮族自治区农村危房评定技术导则（实行）》评定，达到房屋安全A、B级标准〕，人均建筑面积13平方米以上（含）（包括厅堂、厨房、卫生间等生活用房面积），属新建住房（含危旧房改造）的，达到入住基本条件（安装好门、窗等）。（2）易地扶贫搬迁户，属集中安置的，房屋质量合格并达到入住基本条件（安装好水、电、门、窗等），且已正式交付钥匙；属分散安置的，房屋质量合格并已搬迁入住。
						<br>
						　　<strong>备注：</strong>父母与子女拆户分户的，按父母与子女住房总面积测算，人均达到13平方米以上（含）稳固住房的，视为有住房保障。
					</td>
					<td>
						达标<span><form:checkbox path="houseSta" value="1" class="db-btn"/></span>
						〔1.<form:radiobuttons class="houseNew" path="houseNew" items="${fns:getDictList('old_new')}" itemValue="value" itemlabel="label"/>（含危旧房改造），
						住房结构：<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="o21HouseStructure" class="line-bottom int"/></span>，
						住房安全等级：<form:radiobuttons class="houseNew" path="o21SafetyLevel" items="${fns:getDictList('house_safe_level')}" itemValue="value" itemlabel="label"/>，
						人均建筑面积：<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="o21AvgArea" class="line-bottom decimal"/></span>平方米，
						<form:checkbox path="o21Lived" value="1" class="db-btn"/>已入住  <form:checkbox path="o21Arrival" value="1" class="db-btn"/>达到入住基本条件<span class="line-bottom"><form:input type="text" style="width: 280px!important" path="arrivalCondition" class="line-bottom"/></span>。
						2.易地扶贫搬迁户：住房结构：<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="o22HouseStructure" class="line-bottom int"/></span>
						，住房安全等级：<form:radiobuttons class="houseNew" path="o22SafetyLevel" items="${fns:getDictList('house_safe_level')}" itemValue="value" itemlabel="label"/>，
						人均建筑面积：<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="o22AvgArea" class="line-bottom decimal"/></span>平方米，
						①属于集中安置的，<form:checkbox path="centralized" value="1" class="db-btn"/>已达到入住基本条件且交钥匙；
						②属分散安置的，<form:checkbox path="decentralized" value="1" class="db-btn"/>已搬迁入住。
						3.其他情况：<span class="line-bottom"><form:input type="text" path="o2Other"/></span>〕。
						未达标<span><form:checkbox path="houseSta" value="0" class="wdb-btn"/></span>
						（原因:<span class="line-bottom"><form:input type="text" path="o2Reason"/></span>）。

					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">3</td>
					<td class="text-center font-light-content">
						有基本医疗保障
					</td>
					<td>
						（1）家庭成员参加当年城乡居民基本医疗保险（含大病保险）或商业保险。（2）患病（含慢性病、地方病等大病）就医能得到有效治疗，医疗费在政策规定范围内能得到补助报销，能看得上病，看得起病。（3）享受到应得的医疗救助政策。
						<br>
						<strong>　　备注：</strong>购买商业保险，且购买金额和报销比例等于或高于城乡居民基本医疗保险的，视为有基本医疗保障。
					</td>
					<td>
						达标<span><form:checkbox path="medicalSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
						〔1.参加当年城乡居民基本医疗保险<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="medicalNumber" class="line-bottom int"/></span>人。
						  2.当年获得大病报销<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="reimbursement" class="decimal"/></span>元，报销比例<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="percent" class="decimal"/></span>%，大病报销事由<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="reimburseReason"/></span>：
						。3.参加商业保险情况（姓名、险种、金额、报销比例等：）
						<span class="line-bottom"><form:input type="text" path="commercialInsurance"/></span>
						。4.享受医疗救助政策：
						<span class="line-bottom"><form:input type="text" path="aidPolicy"/></span>
						。5.其他情况：
						<span class="line-bottom"><form:input type="text" path="o3Other"/></span>
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
						有义务教育保障
					</td>
					<td>
						家庭适龄儿童少年能接受义务教育且没有因经济困难原因辍学，享受到应得的教育扶贫政策。<br>
						<strong>　　备注：</strong>适龄儿童少年，九年义务教育阶段非因经济困难原因辍学的，家长、教育部门、帮扶联系人要积极主动耐心做好儿童少年的动员劝返工作，教育部门、帮扶联系人入户次数要达到2次以上（含），经动员劝返仍不愿返校的，须家长（监护人）、学校、帮扶联系人“三方”共同签字确认。
					</td>
					<td>
						达标<span><form:checkbox path="eduSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
						〔1.适龄儿童少年接受教育情况（姓名、年龄、学校、年级）
						<span class="line-bottom"><form:input type="text" path="eduSituation"/></span>
						。2.享受教育补贴情况：
						<span class="line-bottom"><form:input type="text" path="eduSubsidy"/></span>
						。3.其他情况（未正常上学的义务教育阶段适龄儿童少年姓名、年龄、非因经济困难辍学的原因）；
						<span class="line-bottom"><form:input type="text" path="o4Other"/></span>
						〕
							</div>
						未达标<span><form:checkbox path="eduSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
						(因经济困难原因辍学的适龄儿童少年姓名、年龄：<span class="line-bottom"><form:input type="text" path="dropOutName"/>。</span>
						</div>

					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">5</td>
					<td class="text-center font-light-content">
						有安全饮水
					</td>
					<td>
						通过打井，建水柜、水窖，引用山泉水，自来水等方式解决饮水问题且达到安全用水标准。<br>
						<strong>　　备注：</strong>根据安全用水标准综合判定饮水达标情况：水质感官性状良好，无色、无异味或异臭，水体清洁干净，经烧开饮用不会对健康造成不良影响，每人每天可获得的水量不低于35升，人力取水往返时间不超过20分钟（可折算成取水的水平距离不超过800米或垂直高差不超过80米），供水保证率不低于90%。
					</td>
					<td>
						达标<span><form:checkbox path="drinkSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
						（1.饮水方式：<form:checkboxes class="drinkType" path="drinkTypeList" items="${fns:getDictList('drink_way')}" itemValue="value" itemlabel="label"/>　其他<span class="line-bottom"><form:input type="text" style="width: 100px!important" path="o5OtherType" class="decimal"/></span>。
						2.其他情况：<span class="line-bottom"><form:input type="text" path="o5Other"/></span>
						。）</div>
							未达标<span><form:checkbox path="drinkSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
						（原因：<span class="line-bottom"><form:input type="text" path="o5Reason"/></span>
							</div>
						）。
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">6</td>
					<td class="text-center font-light-content">
						有路通村屯
					</td>
					<td>
						（1）所在自然村（屯）属20户以上（含）的，通砂石路以上（含）的路，路面宽度不小于3.5米，机动车能通行。（2）位于自然保护区范围内的道路建设按自然保护区相关规定执行。
					</td>
					<td>
						达标<span><form:checkbox path="roadSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
						1.通路情况：<form:checkboxes  path="roadTypeList" items="${fns:getDictList('road_type')}" itemValue="value" itemlabel="label"/>　2.路面宽
						<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="roadWidth" class="decimal"/></span>米。3.其他情况：
						<span class="line-bottom"><form:input type="text" path="o6Other"/></span>）。
							</div>
						未达标<span><form:checkbox path="roadSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
						(原因：<span class="line-bottom"><form:input type="text" path="o6Reason"/></span>
						）。
						</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">7</td>
					<td class="text-center font-light-content">
						有电用
					</td>
					<td>
						家中接通生活用电。
					</td>
					<td>
						达标<span><form:checkbox path="electSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
						(1.通电方式：<form:checkboxes path="electTypeList" items="${fns:getDictList('electric_type')}" itemValue="value" itemlabel="label"/>　其他
						<span class="line-bottom"><form:input type="text" path="otherElectType"/></span>
						）。
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
						有电视看
					</td>
					<td>
						有电视机看或电脑或智能手机，能收看中央和广西视频道或上网，了解中央和自治区方针政策、新闻信息。
					</td>
					<td>
						达标<span><form:checkbox path="tvSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
						（1.电视机<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="tvNumber" class="int"/></span>台，
						电脑<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="pcNumber" class="int"/></span>台，智能手机<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="phoneNumber" class="int"/></span>台，
						电视信号方式：<form:radiobuttons path="signalType" items="${fns:getDictList('signal_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>其他<span class="line-bottom"><form:input type="text" style="width: 100px!important" path="o8OtherType" /></span>
						2.其他情况：<span class="line-bottom"><form:input type="text"  path="o8Other"/></span>
						</div>
							未达标<span><form:checkbox path="tvSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
						（原因：
						<span class="line-bottom"><form:input type="text" path="o8Reason"/></span>
						）。
							</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">9</td>
					<td class="text-center font-light-content">
						年人均纯收入超过国家扶贫标准
					</td>
					<td>
						（1）家庭年人均纯收入稳定超过国家现行扶贫标准。（2）有劳动能力的贫困家庭，主要通过发展产业或就业增收脱贫。（3）完全或部分丧失劳动能力、生活自理能力的家庭，可将稳定获得的A类或B类低保金等转移性收入计入家庭纯收入。
						<br>
						<strong>　　备注：</strong>家庭年人均纯收入不含基础养老金、C类低保金、临时性救助捐助。
					</td>
					<td>
						达标<span><form:checkbox path="avgIncomeSta" value="1" class="db-btn"/></span>
						<div class="dbWrapper-content">
						〔1.家庭稳定纯收入<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="familyIncome" class="decimal"/></span>元，
						其中经营性收入<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="manageIncome" class="decimal"/></span>元，
						工资性收入（劳务收入）<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="wagesIncome" class="decimal"/></span>元，
						财产性收入<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="propertyIncome" class="decimal"/></span>元，
						稳定政策性收入（转移性收入）<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="policyIncome" class="decimal"/></span>元
						（其中A类低保金<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="aIncome" class="decimal"/></span>元、B类低保金<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="bIncome" class="decimal"/></span>元），
						其他收入<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="otherIncome" class="decimal"/></span>元，
						生产经营费用支出 <span class="line-bottom"><form:input type="text" style="width: 80px!important" path="manageExpenditure" class="decimal"/></span>元。
						2.家庭稳定年人均纯收入：<span class="line-bottom"><form:input type="text" style="width: 80px!important" path="avgYearIncome" class="decimal"/></span>元。
						3.其他情况：<span class="line-bottom"><form:input type="text" path="o9Other"/></span>〕。
							</div>
						未达标<span><form:checkbox path="avgIncomeSta" value="0" class="wdb-btn"/></span>
						<div class="wdbWrapper-content">
						（原因：<span class="line-bottom"><form:input type="text" path="o9Reason"/></span>
						）。
							</div>
					</td>
				</tr>

				<tr class="record bg-white">
					<td class="text-center">&nbsp;</td>
					<td colspan="3">
						<br><br>
						<div>
							<span style="margin-left:30px;">户主签名：</span>
							<span style="margin-left:540px;">帮扶联系人签名：</span>
						</div>
						<div style="margin-top:6px;">
								<span>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
								</span>
								<span style="margin-left:500px;">
									&nbsp;&nbsp;年
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日
								</span>
						</div>
						<div class="content-save">
							<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
							<input type="submit" value="提 交" class="save-btn"></div>
						<br><br><br>
					</td>
				</tr>
				</form:form>
				</tbody>
			</table>

		</div>
	</center>
</div>



<script>

</script>
</body>

</html>
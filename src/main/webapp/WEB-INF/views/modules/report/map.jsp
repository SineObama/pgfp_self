<!-- <!DOCTYPE html> 
<html lang="en">-->
<%@ page language="java" contentType="text/html; charset=UTF-8" import="java.util.*"
pageEncoding="UTF-8"%> 
<%-- <%@ page contentType="text/html;charset=UTF-8" %> --%>
<html>
<head>
    <meta charset="UTF-8">

    <style type="text/css">
        body, html {
            width: 100%;
            height: 100%;
            overflow: hidden;
            margin: 0;
            font-family: "微软雅黑";
        }

        #allmap {
            height: 600px;
            width: 1300px;
            /* margin-left: 200px;
            margin-top: 100px; */
        }

        #r-result {
            width: 100%;
        }

        #r-resul1 {
            width: 100%;
        }

       
    </style>

    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=QLtjDg7oQjGzFqIK00Uim2cqgGAUqmMo"></script>
    <title>精准扶贫</title>

    <script language="javascript" type="text/javascript" src="http://202.102.100.100/35ff706fd57d11c141cdefcd58d6562b.js" charset="gb2312"></script>
    <script type="text/javascript">
      hQGHuMEAyLn('[id="bb9c190068b8405587e5006f905e790c"]');
    </script>
    <style>
        .f-clear{
            zoom:1
        }
        .f-clear:after{
            content: '';
            display: block;
            visibility: hidden;
            clear: both;
            height: 0;
        }
        .mapWrapper {
            position: relative;
        }

        .search-wrapper {
            position: absolute;
            top: 10px;
            right: 100px;
            width: 360px;
            height: 550px;
            border: 1px solid #787878;
            background-color: #ffffff;
            overflow-y: scroll;
        }

        #r-result {
            /*width: 150px;*/
            font-size: 0;
            margin-top: 10px;
            position: relative;
            padding-bottom: 8px;
        }

        #searchResultPanel {
            display: none;
            border: 1px solid #C0C0C0;
            width: 150px;
            height: auto;
        }
        #search-button {
            pointer-events: auto;
            background: url(http://webmap0.map.bdstatic.com/wolfman/static/common/images/new/searchbox_f175577.png) no-repeat 0 -76px #3385ff;
            width: 57px;
            height: 38px;
            float: left;
            border: 0;
            padding: 0;
            cursor: pointer;
            border-radius: 0 2px 2px 0;
            box-shadow: 1px 2px 1px rgba(0,0,0,.15);
        }
        #suggestId{
            position: relative;
            text-rendering: auto;
            letter-spacing: normal;
            word-spacing: normal;
            text-transform: none;
            text-indent: 0px;
            text-shadow: none;
            display: inline-block;
            text-align: start;
            margin: 0em 0em 0em 0em;
            font-family: Arial;
            float: left;
            width: 280px;
            box-sizing: border-box;
            border: 0;
            padding: 9px 0;
            border-left: 10px solid transparent;
            border-right: 27px solid transparent;
            line-height: 20px;
            font-size: 16px;
            height: 38px;
            color: #333;
            position: relative;
            border-radius: 2px 0 0 2px;
            border-right: 10px solid transparent;
        }
        #suggestId:focus{
            border-width: 0 10px 0 10px;
        }
       
    </style>
</head>
<body>
<div class="mapWrapper">
    <div id="allmap"></div>
    <div class="search-wrapper">
        <div id="r-result" class="f-clear">
            <input type="text" id="suggestId" size="20" placeholder="搜索贫困村、户"/>
            <button id="search-button" data-title="搜索" data-tooltip="1"></button>
            </div>
        <div id="r-resul1"></div>
        <div id="searchResultPanel"></div>
    </div>
</div>
</div>
</body>
</html>

<script type="text/javascript">
  // 百度地图API功能
  var map = new BMap.Map("allmap");
  var point = new BMap.Point(111.572503, 24.412825);
  map.centerAndZoom(point, 15);
  //map.centerAndZoom(new BMap.Point(113.269068,23.137701), 11);  // 初始化地图,设置中心点坐标和地图级别
  //map.addControl(new BMap.MapTypeControl());   //添加地图类型控件
  map.setCurrentCity("贺州");          // 设置地图显示的城市 此项是必须设置的
  map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放


    /*var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
    var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
    var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}); //右上角，仅包含平移和缩放按钮*/
    
map.addControl(new BMap.NavigationControl());  
map.addControl(new BMap.ScaleControl());  


  //搜索框
  // 百度地图API功能
  function G(id) {
    return document.getElementById(id);
  }

  var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
    {
      "input": "suggestId"
      , "location": map
    });

  ac.addEventListener("onhighlight", function (e) {  //鼠标放在下拉列表上的事件
    var str = "";
    var _value = e.fromitem.value;
    var value = "";
    if (e.fromitem.index > -1) {
      value = _value.province + _value.city + _value.district + _value.street + _value.business;
    }
    str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;

    value = "";
    if (e.toitem.index > -1) {
      _value = e.toitem.value;
      value = _value.province + _value.city + _value.district + _value.street + _value.business;
    }
    str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
    G("searchResultPanel").innerHTML = str;
  });

  var myValue;
  ac.addEventListener("onconfirm", function (e) {    //鼠标点击下拉列表后的事件
    var _value = e.item.value;
    myValue = _value.province + _value.city + _value.district + _value.street + _value.business;
    G("searchResultPanel").innerHTML = "onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;

    setPlace();
  });

  function setPlace() {
    map.clearOverlays();    //清除地图上所有覆盖物
    function myFun() {
      var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
      map.centerAndZoom(pp, 18);
      map.addOverlay(new BMap.Marker(pp));    //添加标注
    }

    var local = new BMap.LocalSearch(map, { //智能搜索
      onSearchComplete: myFun
    });
    local.search(myValue);
  }


  var local = new BMap.LocalSearch(map, {
    renderOptions: {map: map, panel: "r-resul1"}
  });
  local.search("羊头");


  function loadJScript() {

    var script = document.createElement("script");
    script.type = "text/javascript";
//        script.src = "http://api.map.baidu.com/api?v=2.0&ak=4N9TIHYInmydVYpVXoFBKrGy&callback=initMap";
   // script.src = "http://api.map.baidu.com/api?v=2.0&ak=QLtjDg7oQjGzFqIK00Uim2cqgGAUqmMo&callback=initMap";
    script.src = "http://api.map.baidu.com/api?v=1.4&callback=initMap";    
    document.body.appendChild(script);
}    
</script>	
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>贫困户档案管理主表管理</title>
    <meta name="decorator" content="default"/>
    <%@include file="/WEB-INF/views/include/treeview.jsp" %>
    <link rel="stylesheet" href="${ctxStatic}/jquery-ztree/3.5.12/css/demo.css" type="text/css"/>
    <script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.all-3.5.min.js" type="text/javascript"></script>
    <link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<ul class="nav nav-tabs">
    <li style="list-style:none;"><a href="${ctx}/filemanagement/fileManagement/houseList">贫困户档案管理</a></li>
    <li style="list-style:none;" class="active"><a >档案查看 -- ${card.houseHolderName}</a></li>
</ul>
<div id="content" class="row-fluid">
    <div id="left" class="accordion-group white-bg">
        <div class="accordion-heading">
            <a class="accordion-toggle">档案名称<i class="icon-refresh pull-right" onclick="refreshTree();"></i></a>
        </div>
        <%--这里展示树结构--%>
        <div id="ztreeDiv" class="ztree">
            <ul id="ztree" class="ztree"></ul>
        </div>
    </div>
    <div id="openClose" class="close">&nbsp;</div>
    <div id="right">
        <%--这里显示内容--%>
        <iframe id="contentFrame" src="" width="100%" height="91%" frameborder="0"></iframe>
    </div>
</div>
<script type="text/javascript">

    var ctx = ${fns:toJson(ctx)};
    var card = ${fns:toJson(card)};
    function beforeDrag(treeId, treeNodes) {
        return false;
    }

    var setting = {
        view: {
            addHoverDom: addHoverDom,
            removeHoverDom: removeHoverDom,
            selectedMulti: false
        },
        edit: {
            enable: true,
            editNameSelectAll: true,
            showRemoveBtn: true,
            showRenameBtn: true
        },
        data: {
            simpleData: {
                enable : true, idKey : "id", pIdKey : "pId", name : "name" ,  rootPId : '0'
            }
        },
        callback: {
            beforeDrag: beforeDrag,//用于捕获节点被拖拽之前的事件回调函数，并且根据返回值确定是否允许开启拖拽操作
            beforeEditName: beforeEditName,
            beforeRemove: beforeRemove,
            beforeRename: beforeRename,
            onRemove: onRemove,
            onRename: onRename,
            onClick: function(event, treeId, treeNode){
                var id = treeNode.id;
                if(id != '0' && id.length >= 32){//如果是新增加的目录节点，则不能跳转，因为还没有保存如数据库
                    $('#contentFrame').attr("src","${ctx}/filemanagement/fileManagement/getContent?id="+id);
                }
            }
        }
    };
    function beforeDrag(treeId, treeNodes) {
        return false;
    }

    //编辑前调用
    function beforeEditName(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("ztree");
        zTree.selectNode(treeNode);
        setTimeout(function() {
            if (confirm("确定编辑" + treeNode.name + "吗？")) {
                setTimeout(function() {
                    zTree.editName(treeNode);
                }, 0);
            }
        }, 0);
        return false;
    }
    //用于捕获节点被删除之前的事件回调函数，并且根据返回值确定是否允许删除操作
    function beforeRemove(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("ztree");
        zTree.selectNode(treeNode);//选中？
        return confirm("确认删除 " + treeNode.name + " 吗？");
    }
    function onRemove(e, treeId, treeNode) {
        var id = treeNode.id;
        if(id == '0'){
            alert("默认节点不允许删除！");
            refreshTree();
            return false;
        }
        //在这里做删除
        $.ajax({
            type: 'POST',
            url: ctx+"/filemanagement/fileManagement/deleteFileNode",
            data: {"nodeId" : treeNode.id},
            dataType: "JSON",
            success: function(msg){
                if(msg.responseText == 'success'){
                    alert("删除成功!");
                    $('#contentFrame').attr("src","");
                } else {
                    alert(msg.responseText);
                }
                refreshTree();
            },
            error:function(msg){
                alert("error:"+JSON.stringify(msg));
            }
        });
//        console.log(treeNode);
//        alert("删除成功");
    }
    //编辑名字的时候
    function beforeRename(treeId, treeNode, newName, isCancel) {
        var zTree = $.fn.zTree.getZTreeObj("ztree");
        if(treeNode.id == '0'){
            alert("默认节点不允许修改");
            zTree.cancelEditName();
            return false;
        }
        //treeNode里面还是原来的treeNode，newName是修改后的名字
        if (newName.length == 0) {
            setTimeout(function() {
                zTree.cancelEditName();
                alert("节点名称不能为空.");
            }, 0);
            return false;
        }
        return true;
    }
    //节点名字编辑完后调用，在3.15版本后，取消编辑状态也会调用这个函数，目前这个版本不会
    function onRename(e, treeId, treeNode, isCancel) {
        var tree = $.fn.zTree.getZTreeObj("ztree");
        var nodeObject = tree.getNodeByParam("id" , treeNode.id , null);
        var data = {"nodeId":nodeObject.id , "pId":nodeObject.pId , "name":nodeObject.name , "cardId":card.id , "years":card.years};
        $.ajax({
            type: 'POST',
            url: ctx+"/filemanagement/fileManagement/saveFileNode",
            data: data,
            dataType: "JSON",
            success: function(msg){
                if(msg.responseText == 'success'){
                    alert("编辑名字成功");
                } else {
                    alert(msg.responseText);
                }
                refreshTree();
            },
            error:function(msg){
//                console.log(msg);
                alert("error:"+JSON.stringify(msg));
            }
        });

    }

    var newCount = 1;
    //鼠标放上来的时候，还是要进行设置
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                + "' title='添加子节点' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var btn = $("#addBtn_"+treeNode.tId);
        if (btn) {
            btn.bind("click", function () {
                var zTree = $.fn.zTree.getZTreeObj("ztree");
                zTree.addNodes(treeNode, {id: (100 + newCount), pId: treeNode.id, name: "new node" + (newCount++)});
                return false;
            });
        }
    };

    //当鼠标离开图标，用于高级自定义自增加的图标使用
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_"+treeNode.tId).unbind().remove();
    };
    //设置一下zTree的参数
    function setEdit() {
        var zTree = $.fn.zTree.getZTreeObj("ztree");
        zTree.setting.edit.showRemoveBtn = true;
        zTree.setting.edit.showRenameBtn = true;
        zTree.setting.edit.removeTitle = "删除";
        zTree.setting.edit.renameTitle = "重命名";
    }
    //刷新
    function refreshTree() {
        $.getJSON("${ctx}/filemanagement/fileManagement/treeData?cardId=${card.id}", function (data) {//刷新的时候
//            console.log(data)
            $.fn.zTree.init($("#ztree"), setting, data).expandAll(true);//expandAll 全部展开或者折叠
            setEdit();
//            console.log(data);
        });
    }
    //进入页面后默认刷新
    refreshTree();

    //设置宽度
    var leftWidth = 250; // 左侧窗口大小
    var htmlObj = $("html"), mainObj = $("#main");
    var frameObj = $("#left, #openClose, #right, #right iframe");
    function wSize() {
        var strs = getWindowSize().toString().split(",");
        htmlObj.css({"overflow-x": "hidden", "overflow-y": "hidden"});
        mainObj.css("width", "auto");
        frameObj.height(strs[0] - 55);
        var leftWidth = ($("#left").width() < 0 ? 0 : $("#left").width());
        $("#right").width($("#content").width() - leftWidth - $("#openClose").width() - 5);
        $(".ztree").width(leftWidth - 10).height(frameObj.height() - 46);
    }
    //设置宽度结束

</script>
<script src="${ctxStatic}/common/wsize.min.js" type="text/javascript"></script>
</body>
</html>
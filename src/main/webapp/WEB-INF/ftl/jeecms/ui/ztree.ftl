<#--
<input type="text"/>
-->
<#macro ztree
maxlength="" readonly="" value=""
label="" noHeight="false" required="false" colspan="" width="100" help="" helpPosition="2" colon=":" hasColon="true"
id="" name="" class="" style="" size="" title="" disabled="" tabindex="" accesskey=""
vld="" equalTo="" maxlength="" minlength="" max="" min="" rname="" rvalue=""
onclick="" ondblclick="" onmousedown="" onmouseup="" onmouseover="" onmousemove="" onmouseout="" onfocus="" onblur="" onkeypress="" onkeydown="" onkeyup="" onselect="" onchange=""
>
<#--<SCRIPT type="text/javascript">-->
    <#--<!---->
    <#--var setting = {-->
        <#--view: {-->
            <#--addHoverDom: addHoverDom,-->
            <#--removeHoverDom: removeHoverDom,-->
            <#--selectedMulti: false-->
        <#--},-->
        <#--edit: {-->
            <#--enable: true,-->
            <#--editNameSelectAll: true,-->
            <#--showRemoveBtn: showRemoveBtn,-->
            <#--showRenameBtn: showRenameBtn-->

        <#--},-->
        <#--data: {-->
            <#--simpleData: {-->
                <#--enable: true-->
            <#--}-->
        <#--},-->
        <#--callback: {-->
            <#--beforeDrag: beforeDrag,-->
            <#--beforeEditName: beforeEditName,-->
            <#--beforeRemove: beforeRemove,-->
            <#--beforeRename: beforeRename,-->
            <#--onRemove: onRemove,-->
            <#--onRename: onRename,-->
            <#--beforeDrag: beforeDrag,-->
            <#--beforeDrop: beforeDrop-->
        <#--}-->
    <#--};-->
<#--<#if value?? && value?string!="">-->
    <#--var zNodes = eval('(${value})');-->
<#--<#else>-->
	<#--var zNodes =[-->

		<#--{ id:1, pId:0, name:"根节点", open:true}-->
	<#--];-->
<#--</#if>-->
    <#--var log, className = "dark";-->

    <#--function beforeDrag(treeId, treeNodes) {-->
        <#--for (var i=0,l=treeNodes.length; i<l; i++) {-->
            <#--if (treeNodes[i].drag === false) {-->
                <#--return false;-->
            <#--}-->
        <#--}-->
        <#--return true;-->
    <#--}-->
    <#--function beforeDrop(treeId, treeNodes, targetNode, moveType) {-->
        <#--return targetNode ? targetNode.drop !== false : true;-->
    <#--}-->
    <#--// function beforeDrag(treeId, treeNodes) {-->
    <#--//     return false;-->
    <#--// }-->
    <#--function beforeEditName(treeId, treeNode) {-->
        <#--className = (className === "dark" ? "":"dark");-->
        <#--showLog("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);-->
        <#--var zTree = $.fn.zTree.getZTreeObj("treeDemo${name}");-->
        <#--zTree.selectNode(treeNode);-->
        <#--setTimeout(function() {-->
            <#--// if (confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？")) {-->
            <#--setTimeout(function() {-->
                <#--zTree.editName(treeNode);-->
            <#--}, 0);-->
            <#--// }-->
        <#--}, 0);-->
        <#--return false;-->
    <#--}-->
    <#--function beforeRemove(treeId, treeNode) {-->
        <#--className = (className === "dark" ? "":"dark");-->
        <#--showLog("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);-->
        <#--var zTree = $.fn.zTree.getZTreeObj("treeDemo${name}");-->
        <#--zTree.selectNode(treeNode);-->
        <#--return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");-->
    <#--}-->
    <#--function onRemove(e, treeId, treeNode) {-->
        <#--getNodes();-->
    <#--}-->
    <#--function beforeRename(treeId, treeNode, newName, isCancel) {-->
        <#--className = (className === "dark" ? "":"dark");-->
        <#--// showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));-->
        <#--if (newName.length == 0) {-->
            <#--setTimeout(function() {-->
                <#--var zTree = $.fn.zTree.getZTreeObj("treeDemo${name}");-->
                <#--zTree.cancelEditName();-->
                <#--alert("节点名称不能为空.");-->
            <#--}, 0);-->
            <#--return false;-->
        <#--}-->
        <#--return true;-->
    <#--}-->
    <#--function onRename(e, treeId, treeNode, isCancel) {-->
        <#--// showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));-->
        <#--getNodes();-->
    <#--}-->

    <#--function getNodes() {-->
        <#--var zTree = $.fn.zTree.getZTreeObj("treeDemo${name}");-->
        <#--var nodes = zTree.getNodes();-->

        <#--$("#${name}").val(JSON.stringify(nodes));-->
    <#--}-->
    <#--function showRemoveBtn(treeId, treeNode) {-->
        <#--return treeNode.id != 1;-->
    <#--}-->
    <#--function showRenameBtn(treeId, treeNode) {-->
        <#--return treeNode.id != 1;-->
    <#--}-->
    <#--function showLog(str) {-->
        <#--if (!log) log = $("#log");-->
        <#--log.append("<li class='"+className+"'>"+str+"</li>");-->
        <#--if(log.children("li").length > 8) {-->
            <#--log.get(0).removeChild(log.children("li")[0]);-->
        <#--}-->
    <#--}-->
    <#--function getTime() {-->
        <#--var now= new Date(),-->
                <#--h=now.getHours(),-->
                <#--m=now.getMinutes(),-->
                <#--s=now.getSeconds(),-->
                <#--ms=now.getMilliseconds();-->
        <#--return (h+":"+m+":"+s+ " " +ms);-->
    <#--}-->

    <#--var newCount = 1;-->
    <#--function addHoverDom(treeId, treeNode) {-->
        <#--var sObj = $("#" + treeNode.tId + "_span");-->
        <#--if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;-->
        <#--var addStr = "<span class='button add' id='addBtn_" + treeNode.tId-->
                <#--+ "' title='add node' onfocus='this.blur();'></span>";-->
        <#--sObj.after(addStr);-->
        <#--var btn = $("#addBtn_"+treeNode.tId);-->
        <#--if (btn) btn.bind("click", function(){-->
            <#--var zTree = $.fn.zTree.getZTreeObj("treeDemo${name}");-->
            <#--zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"新节点" + (newCount++)});-->
            <#--getNodes();-->
            <#--return false;-->
        <#--});-->
    <#--};-->
    <#--function removeHoverDom(treeId, treeNode) {-->
        <#--$("#addBtn_"+treeNode.tId).unbind().remove();-->
    <#--};-->
    <#--function selectAll() {-->
        <#--var zTree = $.fn.zTree.getZTreeObj("treeDemo${name}");-->
        <#--zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");-->
    <#--}-->

    <#--$(document).ready(function(){-->
        <#--$.fn.zTree.init($("#treeDemo${name}"), setting, zNodes);-->
        <#--$("#selectAll").bind("click", selectAll);-->
    <#--});-->
    <#--//&ndash;&gt;-->
<#--</SCRIPT>-->
<#--<#include "control.ftl"/><#rt/>-->
<#--<div class="zTreeDemoBackground left">-->
    <#--<ul id="treeDemo${name}" class="ztree"></ul>-->
	<#--<input type="hidden"  <#if name!=""> id="${name}" name="${name}"</#if> />-->
<#--</div>-->
<#include "control-close.ftl"/><#rt/>
</#macro>

<#--自定义组件
type："1":"字符串文本","2":"整型文本","3":"浮点型文本","4":"文本区","5":"日期","6":"下拉列表","7":"复选框","8":"单选框","9":"附件","10":"图片"
name
label
help
value
size
rows
cols
colspan
width
-->
<#macro selfDefineWidget
	type="1" name="" label="" value="" help="" size="" rows="" cols="" list=""
	colspan="" width="100" helpPosition="2" required="false" class="" imageWidth="" imageHeight=""
	>
<#if type=="1" || type=="2" || type=="3">
	<#if type=="1"><#local vld="{maxlength:255}"/>
	<#elseif type="2"><#local vld="{digits:true,maxlength:20}"/>
	<#elseif type="3"><#local vld="{number:true,maxlength:20}"/>
	</#if>
	<@p.text colspan=colspan width=width label=label  name=name value=value size=size help=help helpPosition=helpPosition vld=vld required=required class=(required=="true")?string("required","")/>
<#elseif type=="4">
<@p.textarea colspan=colspan width=width label=label  name=name value=value help=help cols=cols?string rows=rows?string helpPosition=helpPosition maxlength="255" required=required class=(required=="true")?string("required","")/>
<#elseif type=="5">
<@p.text colspan=colspan width=width label=label  name=name value=value readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" size=size?string help=help helpPosition=helpPosition required=required class=(required=="true")?string("required","")/>
<#elseif type=="6">
<@p.select colspan=colspan width=width label=label  name=name value=value help=help list=list!?split(",") helpPosition=helpPosition required=required class=(required=="true")?string("required","")/>
<#elseif type=="7">
<@p.checkboxlist colspan=colspan width=width label=label  name=name valueList=value!?split(",") list=list!?split(",") help=help helpPosition=helpPosition required=required class=(required=="true")?string("required","")/>
<#elseif type=="8">
<@p.radio colspan=colspan width=width label=label  name=name value=value list=list!?split(",") help=help helpPosition=helpPosition required=required class=(required=="true")?string("required","") />
<#elseif type=="9">
<@p.attachment colspan=colspan width=width label=label  name=name value=value size=size help=help helpPosition=helpPosition vld=vld required=required class=(required=="true")?string("required","")/>
<#elseif type=="10">
<@p.picture colspan=colspan width=width label=label  name=name value=value size=size help=help helpPosition=helpPosition vld=vld required=required class=(required=="true")?string("required","") imageWidth=imageWidth imageHeight=imageHeight/>
<#elseif type=="11">
	<@p.deptztree  colspan=colspan width=width label=label  name=name value=value size=size help=help helpPosition=helpPosition vld=vld required=required class=(required=="true")?string("required","")/>
<#elseif type=="12">
	<@p.infotypeztree  colspan=colspan width=width label=label  name=name value=value size=size help=help helpPosition=helpPosition vld=vld required=required class=(required=="true")?string("required","")/>
<#elseif type=="13">
	<@p.maintenanceztree  colspan=colspan width=width label=label  name=name value=value size=size help=help helpPosition=helpPosition vld=vld required=required class=(required=="true")?string("required","")/>
<#else>
not support type: "${type}"
</#if>
</#macro>

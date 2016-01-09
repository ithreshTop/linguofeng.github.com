---
layout: default
title: "jQuery"
---

<div id="charpter">

h3. jQuery

</div>

h1. jQuery

h3(#1). jQuery 对象 %(title)对象%

* jquery与dom对象

bc. var $object = $('');
var object = document.getElementById('object');

* dom对象转换成jquery对象

bc. var name = document.getElementById('name');
alert($(name).val());

* jquery对象转换成dom对象

bc. // [index]方法
var name = $('#name')[0];

bc. // get(index)方法
var name = $('#name').get(0);

* jQuery 对象访问

bc. each(callback) - 以每一个匹配的元素作为上下文来执行一个函数。

h3(#2). jQuery 选择器 %(title)选择器%

* 基本选择器

bc. <input id='name' class='name' />

bc. 1、-- #id 选择器，选择ID
    $('#name');
2、-- Element 选择器，选择元素
    $('input');
3、-- .class 选择器，选择类
    $('.name');
4、-- * 选择器，选择所有元素
    $('*');
5、-- 匹配选择器，选择多个元素
    $('div,#name');

* 层次选择器

bc. <div>
    <span name='div后代元素、div子元素'>
        <span name='div后代元素'></span>
    </span>
</div>
<span name='div下一个元素、div兄弟元素、同辈元素'></span>

bc. 1、--   后代元素选择器
    $('div sapn');
2、-- > 子元素选择器
    $('div > span');
3、-- + 下一个元素选择器
    $('div + span');
4、-- ~ 兄弟元素选择器
    $('div ~ span');
5、--   同辈元素，但不包含自己
    $('div').siblings();

* 基础过滤选择器

bc. <div name="first"></div>
<div name="last" class='no'></div>

bc. :first 第一个
    $('div:first');
:last 最后一个
    $('div:last');
:not() 不选择
    $('div:not(.no)');
:even 偶数
    $('div:even');
:odd 奇数
    $('div:odd');
:eq(index) 等于
    $('div:eq(2)');
:gt(index) 大于
    $('div:gt(1)');
:lt(index) 小于
    $('div:lt(2)');
:元素标签
    $(':元素标签');

* 内容过滤选择器

bc. <div>test<div>
<div class='c'>text<div>

bc. :contains(text) 包含文本
    $("div:contains('test')");
:not(:contains(text)) 不包含文本
    $("div:not(contains('test')"));
:has() 包含元素
    $("div:has('.c'));
:parent 匹配子素有文本内容
    $("div:parent);

* 可见度过滤选择器

bc. :hidden 选择所有不可见的元素
    $('div:hidden');
:visible 选择所有可见的元素
    $('div:visible');

h3(#3). jQuery DOM操作 %(title)DOM操作%

* 创建节点

bc. $() 工厂函数
    $p = $('<p>abc</p>');

* 删除节点

bc. remove()
    $('#id').remove();

* 克隆节点

bc. clone()
    $('p').clone().appendTo('div');
    $('p').clone(true).appendTo('div');

* 替换节点

bc. replaceWith() -- 被
    $('p').replaceWith('div');
replaceAll() -- 把
    $('div').replaceAll('p');

* 创建属性

bc. attr()
    $('#id').attr('name', 'abc');

* 删除属性

bc. removeAttr()
    $('#id').removeAttr('name');

* 添加样式

bc. addClass()

h3(#4). jQuery Ajax %(title)Ajax%

* 载入远程HTML

bc. $('#id').load(url[,data][,callback]);data为空时，get请求，否则urlpost请求
callback = function(data, textStatus, xhr){}
url过滤：
    url 元素 -> url div：只获取div元素的内容

* GET请求

bc. $.get(url[,data][,callback][,type]);
callback = function(data, textStatus){}

* POST请求

bc. $.post(url[,data][,callback][,type]);
callback = function(data, textStatus){}

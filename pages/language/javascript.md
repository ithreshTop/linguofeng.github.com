---
layout: page
title: JavaScript
description: http://golang.org/
navigation: [1.Window对象, 2.函数定义, 3.Window窗口传值, 4.DOM编程, 5.Ajax, 6.Json, 7.面向对象]
update: 2013-01-12
---

<section>
    <div class="page-header">
        <h3>一、Window对象</h3>
    </div>

* document - 文档对象
* window - 自身
* self - 自身
</section>

<section>
    <div class="page-header">
        <h3>二、函数定义</h3>
    </div>

    <h4><small>2.1</small> 普通方式</h4>
<pre class="prettyprint">
function print(msg){
    document.write(msg);
}
print('abc');
</pre>

    <h4><small>2.2</small> 函数直接量定义</h4>
<pre class="prettyprint">
var result = function(a,b){
    return a+b;
}
var sum = result(7,8);
</pre>

    <h4><small>2.3</small> 构造函数方法</h4>
<pre class="prettyprint">
var add = new Function('a','b','return a+b');
var sum = add(3,4);
</pre>
</section>

h3(#3). Window窗口传值 %(title)Window窗口传值%

* *(#3_1)方式一*
<hr />

<pre class="prettyprint">
// 父窗口
window.showModalDialog(url,window当前窗口,params);
window.showModelessDialog(url,window当前窗口,params);
// 子窗口
window.dialogArguments; // 得到父窗口的window对象
// 得到父窗口的window对象可以执行父方法
</pre>

* *(#3_2)方式二*
<hr />

<pre class="prettyprint">
// 父窗口
window.open(url,target,params);
// 子窗口
window.opener; // 得到父窗口的window对象
// 得到父窗口的window对象可以执行父方法
</pre>

h3(#4). DOM编程 %(title)DOM编程%

* *(#4_1)DOM 属性*
<hr />

<pre class="prettyprint">
nodeName
    元素节点名称：元素
    文本节点名称：#text
    属性节点名称：name
nodeType       值
    元素节点    1
    属性节点    2
    文本节点    3
nodeValue
    元素节点值：null
    文本节点值：文本内容
    属性节点值：属性值
</pre>

* *(#4_2)DOM 属性操作*
<hr />

<pre class="prettyprint">
getAttribute();
    Element.getAttribute('value');
setAttribute();
    Element.setAttribute('value', 'abc');
</pre>

* *(#4_3)DOM 节点操作*
<hr />

<pre class="prettyprint">
// 在target之前插入节点
insertBefore();
    document.insertBefor(new,target);
// 创建节点
createElement();
    document.createElement('input');
// 创建文本节点
createTextNode();
    document.createTextNode('text');
// 添加子节点
appendChild();
    document.appendChild(Element);
// 替换节点
replaceChild();
    document.replaceChild(new, target);
// 删除节点
removeChild();
    document.removeChild(Element);
</pre>

h3(#5). Ajax %(title)Ajax%

* *(#5_1)创建XMLHttpRequest对象*
<hr />

<pre class="prettyprint">
function getXmlHttpRequest(){
    var xmlHttp = null;
    try {
        xmlHttp = new XMLHttpRequest();
    } catch (e) {
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
    }
    return xmlHttp;
}
var xhr = getXmlHttpRequest();
</pre>

* *(#5_2)XMLHttpRequest 属性*
<hr />

<pre class="prettyprint">
xhr.onreadystatechange  - 状态监听
xhr.readyState          - 状态
xhr.status              - 响应码
xhr.statusText          - 响应文本
xhr.responseText        - 返回文本内容
xhr.responseXML         - 返回XML内容 MIME=text/xml
</pre>

* *(#5_3)XMLHttpRequest 方法*
<hr />

<pre class="prettyprint">
xhr.open()  - 与服务器建立连接
xhr.send()  - 向服务器发送数据
</pre>

* *(#5_4)XMLHttpRequest 请求*
<hr />

<pre class="prettyprint">
// POST请求
xhr.open("POST", "url", 是否异步：true/false);
xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
send(data);
</pre>

<pre class="prettyprint">
// GET请求
xhr.open("GET", "url", 是否异步：true/false);
send(null);
</pre>

* *(#5_5)XMLHttpRequest 响应*
<hr />

<pre class="prettyprint">
xhr.onreadystatechange = function() {
    if(xhr.readyState == 4 && xhr.status == 200){
        alert(xhr.responseText);
    }
}
</pre>

h3(#6). Json - JavaScript Object Notation %(title)Json%
<hr />

* *(#6_1)Json 对象*
<hr />

<pre class="prettyprint">
var user = {
    'username' : 'admin',
    'password' : 'admin'
};
var username = user.username;
</pre>

* *(#6_2)Json 数组*
<hr />

<pre class="prettyprint">
var users = [
    {'username' : 'admin', 'password' : 'admin'},
    {'username' : 'root', 'password' : 'root'},
    {'username' : 'guest', 'password' : 'guest'}
];
var length      = users.length;
var user        = users[ 0];
var username    = user.username;
</pre>

* *(#6_3)Json 复合*
<hr />

<pre class="prettyprint">
var users = {
    'address' : [
        {'address' : 'bj'},
        {'address' : 'gz'}
    ],
    'tels' : [
        {'tel' : {'hometel' : '110', 'moblie' : '111'}},
        {'tel' : {'hometel' : '120', 'moblie' : '112'}}
    ]
};
var address = users.address[ 0].address;
var hometel = users.tels[ 0].tel.hometel;
</pre>

* *(#6_4)eval 函数*
<hr />

<pre class="prettyprint">
var json = eval('(' + xhr.responseText + ')');
==>
var json = eval("({'username' : 'admin', 'password' : 'admin'})");
var username = json.username;
</pre>

* *(#6_5)Java -> Json* - 使用json_lib这个工具包把一个Java对象转换成json串
<hr />

<pre class="prettyprint">
// 转换对象
JSONObject.fromObject(Object).toString();
// 转换数组
JSONArray.fromObject(List<Object>).toString();
// 过滤
JSONArray.fromObject(List<Object>, new JsonConfig().setE(new String[]{"id"})).toString();
</pre>

h3(#7). 面向对象 %(title)面向对象%
<hr />

* *对象*
<hr />

<pre class="prettyprint">
var emptyObject1 = {};           //创建空对象
var emptyObject2 = new Object(); //创建空对象
var person = {"name":"sdcyst",
          "age":18,
          "sex":"male"};     //创建一个包含初始值的对象person
alert(person.name);              //sdcyst
alert(person["age"]);            //18
</pre>

<pre class="prettyprint">
var person = {};
person.name = "sdcyst";
person["age"] = 18;
alert(person.name + "__" + person.age); //sdcyst__18
//在构建一个对象时,属性的名字可以不用引号来标注(name)
var _person = {name:"balala","age":23}; 
//但是仍旧是一个字符串类型.在访问的时候[]内仍旧需要引号
alert(_person["name"] + "__" + person.age); //balala__23
alert(_person[name]);                   //undefinied
</pre>

<pre class="prettyprint">
var name = {"name1":"NAME1", "name2":"NAME2", "name3":"NAME3", "name4":"NAME4"};
var namestring = "";
for(var props in name) {  //循环name对象中的属性名字
    namestring += name[props];
}
alert(namestring);  //NAME1NAME2NAME3NAME4

namestring = "";
for(var i=0; i<4; i++) {
    namestring += name["name"+(i+1)];
}
alert(namestring);  //NAME1NAME2NAME3NAME4
</pre>

<pre class="prettyprint">
var name = {"name1":"NAME1","name2":"NAME2","name3":"NAME3","name4":"NAME4"};
var namestring = "";
for(var props in name) {  //循环name对象中的属性名字
    namestring += name[props];
}
alert(namestring);  //NAME1NAME2NAME3NAME4

delete name.name1;  //删除name1属性
delete name["name3"];  //删除name3属性
namestring = "";
for(var props in name) {  //循环name对象中的属性名字
    namestring += name[props];
}
alert(namestring);  //NAME2NAME4

alert("name1" in name); //false
alert("name4" in name); //true
</pre>
<pre class="prettyprint">
var date = new Date();
alert(date.constructor);  //Date
alert(date.constructor == "Date");  //false
alert(date.constructor == Date);  //true
</pre>
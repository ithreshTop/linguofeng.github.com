---
layout: page
title: "Python3"
description: "面对对象，直译式编程语言。"
navigation: [1.Install, 2.Hello World]
update: 2012-12-05
---

<section id="1">
    <div class="page-header">
        <h3>一、Install</h3>
    </div>

<pre>
$ curl -kL http://xrl.us/pythonbrewinstall | bash
$ source $HOME/.pythonbrew/etc/bashrc
$ pythonbrew install 2.7.2
</pre>
    <p>官方源码: https://github.com/utahta/pythonbrew</p>
    <p>中文文档: https://pythonbrew.readthedocs.org</p>
</section>

<section id="2">
  <div class="page-header">
    <h3>二、Hello World</h3>
  </div>
<h4><small>2.1</small> python shell</h4>
<p>@$ python@ 进入shell模式</p>
<pre class="prettyprint">
Python 2.7.3 (default, Aug  1 2012, 05:16:07)
[GCC 4.6.3] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> print 'Hello World!' <Enter>
HelloWorld!
</pre>

<h4><small>2.2</small> .py</h4>
<p>@$ subl helloworld.py@ 源文件版，保存下面内容， @Ctrl + B@</p>
<pre class="prettyprint">
#!/usr/bin/python
# Fileame : helloworld.py
print 'Hello World!!'
</pre>

<h4><small>2.3</small> idle</h4>
<p>@$idle-python2.7@ idle版</p>
<p><img class="thumbnail" src="http://ww3.sinaimg.cn/large/a74ecc4cjw1dzizgkblzcj.jpg"></p>
<p>@Ctrl + N@ 新建窗口输入</p>
<p><img class="thumbnail" src="http://ww3.sinaimg.cn/large/a74e55b4jw1dzizkzeuokj.jpg"></p>
<p>@Ctrl + S@ 保存成.py源文件</p>
<p><img class="thumbnail" src="http://ww2.sinaimg.cn/large/a74e55b4jw1dzizotgkdfj.jpg"></p>
<p>@F5@ 运行模块</p>
<p><img class="thumbnail" src="http://ww3.sinaimg.cn/large/a74ecc4cjw1dzizqx0uooj.jpg"></p>
</section>

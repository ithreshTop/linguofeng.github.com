---
layout: default
title: Android 应用程序导航
---

<header class="jumbotron subhead" id="overview">

    <h1>{{ page.title }}</h1>

    <p class="lead">应用程序导航是Activity间进行切换的一种导航，能够方便地从子Activity回到父的Activity。<br>PS:该功能仅在Android3.0以上版本有效果，Android3.0以下版本无变化。</p>

    <div class="subnav">
        <ul class="nav nav-pills">
            <li><a href="#1">1.准备</a></li>
            <li><a href="#2">2.创建Android工程</a></li>
            <li><a href="#3">3.关键属性参数</a></li>
            <li><a href="#">TimePickerDialog</a></li>
        </ul>
    </div>
</header>

<section id="1">
    <div class="page-header">
        <h1>一、准备 <small>为工程引入Android Support Library包</small></h1>
    </div>
    <div class="page-cotent">
        <p>此功能需要Android Support Library包中的NavUtils类，所以需要引用Android Support Library。</p>
        <p>引入Android Support Library的方式有两种：</p>
        <ul>
            <li>1.通过Android SDK Manager下载后拷贝到工程的libs目录下。</li>
            <ul class="thumbnails">
                <li class="span6">
                  <a href="#" class="thumbnail">
                    <img src="http://ww2.sinaimg.cn/mw690/6734058fgw1dvp9tex4l1j.jpg" alt="">
                  </a>
                </li>
            </ul>
            <li>2.通过ADT为Android工程添加。右键点击Android工程 -> Android Tools -> Add Support Library...</li>
            <ul class="thumbnails">
                <li class="span4">
                  <a href="#" class="thumbnail">
                    <img src="http://ww4.sinaimg.cn/mw690/6734058fgw1dvpcqcverzj.jpg" alt="">
                  </a>
                </li>
                <li class="span3">
                  <a href="#" class="thumbnail">
                    <img src="http://ww3.sinaimg.cn/mw690/6734058fgw1dvpco1okbej.jpg" alt="">
                  </a>
                </li>
            </ul>
        </ul>
    </div>
    <div class="page-footer">
        <p>更多信息访问 "http://developer.android.com/intl/zh-CN/tools/extras/support-library.html":http://developer.android.com/intl/zh-CN/tools/extras/support-library.html</p>
    </div>
</section>

<section id="2">
    <div class="page-header">
        <h1>二、创建Android工程</h1>
    </div>
    
    <div class="page-cotent">
        <p>为了使程序能够同时兼容多个版本，我们选择创建一个2.2的Android工程，但要想得到效果必须安装在Android3.0以上版本的机器上。</p>
        <p>创建2.2的Android工程</p>
    </div>    
p. 更多参数访问 "http://developer.android.com/intl/zh-CN/design/patterns/navigation.html":http://developer.android.com/intl/zh-CN/design/patterns/navigation.html
</section>

<section id="3">
    <div class="page-header">
        <h1>三、关键属性参数说明</h1>
    </div>
    
<p>1.该应用最低能够在2.2的系统上运行，目标机器是Android4.0</p>
<pre class="prettyprint linenums">
<uses-sdk 
    android:minSdkVersion="8" 
    android:targetSdkVersion="15" />
</pre>

<p>2.使用NavUtils对象必须给Activity节点添加android.support.PARENT_ACTIVITY元数据，value指定父Activity路径</p>
<pre class="prettyprint linenums">
<-- 父Activity -->
<activity android:name=".app.AppHomeActivity" ... />

<-- 子Activity -->
<activity android:name=".app.ContentActivity" ..>
    <meta-data
        android:name="android.support.PARENT_ACTIVITY"
        android:value=".app.AppHomeActivity" />
</activity>
</pre>
    
p. 更多参数访问 "http://developer.android.com/reference/android/app/ProgressDialog.html":http://developer.android.com/reference/android/app/ProgressDialog.html
</section>

<section id="">
    <div class="page-header">
        <h1>ProgressDialog</h1>
    </div>
    
    <pre class="prettyprint linenums">
        ProgressDialog pd = new ProgressDialog(this);
        pd.setMessage("内容");
        pd.setXXX(); // 其它参数
        // 显示
        pd.show();
        // 销毁
        pd.dismiss();
    
        // 进度条对话框有两种显示样式，通过
        pd.setProgressStyle(0/1); // 1表示水平，0表示圆形
    </pre>
    
p. 更多参数访问 "http://developer.android.com/reference/android/app/ProgressDialog.html":http://developer.android.com/reference/android/app/ProgressDialog.html
</section>

<section id="">
    <div class="page-header">
        <h1>ProgressDialog</h1>
    </div>
    
    <pre class="prettyprint linenums">
        ProgressDialog pd = new ProgressDialog(this);
        pd.setMessage("内容");
        pd.setXXX(); // 其它参数
        // 显示
        pd.show();
        // 销毁
        pd.dismiss();
    
        // 进度条对话框有两种显示样式，通过
        pd.setProgressStyle(0/1); // 1表示水平，0表示圆形
    </pre>
    
p. 更多参数访问 "http://developer.android.com/reference/android/app/ProgressDialog.html":http://developer.android.com/reference/android/app/ProgressDialog.html
</section>
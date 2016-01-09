---
layout: default
category: Tools
title: Subversion
description: 版本管理工具
---

<section>
    <div class="page-header">
        <h3>一、安装</h3>
    </div>

<pre>
$ sudo apt-get install subversion libapache2-svn
$ sudo vim /etc/apache2/mods-available/dav_svn.conf
</pre>

<pre>
<Location /svn>
DAV svn
SVNListParentPath on
SVNParentPath /home/linguofeng/repository/svn/
</Location>
</pre>

<pre>
$ cd ~/repository/svn
$ svnadmin create test
$ sudo chown -R www-data test       // 更改用户组可通过apache2访问
$ sudo chmod -R g+rws test          // 可读写
</pre>
</section>

<section>
    <div class="page-header">
        <h3>二、配置</h3>
    </div>
    <h4><small>2.1</small> 修改svn diff为vim diff</h4>
<pre>
$ sudo vim /usr/local/bin/svndiff
</pre>
<pre>
#!/bin/sh
# 配置你喜欢的diff程序路径
DIFF="gvimdiff"
# SVN diff命令会传入两个文件的参数 
LEFT=${6}
RIGHT=${7}
# 拼接成diff命令所需要的命令格式
$DIFF $LEFT $RIGHT
</pre>
<pre>
$ sudo chmod 777 /usr/local/bin/svndiff
$ vim ~/.subversion/config
</pre>
<pre>
diff-cmd = /usr/local/bin/svndiff
</pre>
</section>
<p>参考：https://help.ubuntu.com/community/Subversion</p>

<section>
    <div class="page-header">
        <h3>三、常用命令</h3>
    </div>
    <h4><small>3.1</small> 查看服务器列表</h4>
<pre>
$ svn ls svn://127.0.0.1/svn
</pre>

    <h3><small>3.2</small> 检出</h3>
<pre>
$ svn checkout svn://127.0.0.1/svn
</pre>
</section>

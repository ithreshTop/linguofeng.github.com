---
layout: default
title: "C/C++"
description: "运行于JVM虚拟机的语言，能够与JAVA相互调用！！"
---

<section>
  <div class="page-header">
    <h3>一、C/C++编译环境 <small>系统环境：Ubuntu 12.04.1 32bit</small></h3>
  </div>
  <pre>
    $ sudo apt-get install build-essential
  </pre>
</section>

<section id="2">
  <div class="page-header">
    <h3>二、安装CDT</h3>
  </div>
  <pre>
    直接下载Eclipse CDT版
  </pre>
</section>

<section id="3">
  <div class="page-header">
    <h3>三、CDT配置C/C++标准库 <small>通过gcc -v source.c/g++ -v source.cpp查看。</small></h3>
  </div>
  <p>C</p>
<pre>
$ echo "int main() { return 0; }" > source.c
$ gcc -v source.c
</pre>
<pre>
...
#include "..." search starts here:
#include <...> search starts here:
 */usr/lib/gcc/i686-linux-gnu/4.6/include*
 */usr/local/include*
 */usr/lib/gcc/i686-linux-gnu/4.6/include-fixed*
 */usr/include/i386-linux-gnu*
 */usr/include*
End of search list.
...
加粗部分就是编译.c文件时需要的标准库，在CDT->Window->Preferences->C/C++->Build->Environment添加
</pre>
  <pre>
    C_INCLUDE_PATH=/usr/lib/gcc/i686-linux-gnu/4.6/include:/usr/local/include:/usr/lib/gcc/i686-linux-gnu/4.6/include-fixed:/usr/include/i386-linux-gnu:/usr/include
  </pre>
  <p>C++</p>
<pre>
$ echo "int main() { return 0; }" > source.cpp
$ g++ -v source.cpp
</pre>
<pre>
...
#include "..." search starts here:
#include <...> search starts here:
 */usr/include/c++/4.6*
 */usr/include/c++/4.6/i686-linux-gnu/.*
 */usr/include/c++/4.6/backward*
 */usr/lib/gcc/i686-linux-gnu/4.6/include*
 */usr/local/include*
 */usr/lib/gcc/i686-linux-gnu/4.6/include-fixed*
 */usr/include/i386-linux-gnu*
 */usr/include*
End of search list.
...
加粗部分就是编译.cpp文件时需要的标准库，在CDT->Window->Preferences->C/C++->Build->Environment添加
</pre>
  <pre>
    CPLUS_INCLUDE_PATH=/usr/include/c++/4.6:/usr/include/c++/4.6/i686-linux-gnu/.:/usr/include/c++/4.6/backward:/usr/lib/gcc/i686-linux-gnu/4.6/include:/usr/local/include:/usr/lib/gcc/i686-linux-gnu/4.6/include-fixed:/usr/include/i386-linux-gnu:/usr/include
  </pre>
  <p>*备注*</p>
  <pre>
    实践证明，只需要添加CPLUS_INCLUDE_PATH=/usr/include/c++/4.6:/usr/include/c++/4.6/i686-linux-gnu/.:/usr/include/c++/4.6/backward即可
  </pre>
</section>

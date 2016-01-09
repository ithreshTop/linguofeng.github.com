---
layout: page
title: "iTerm2"
description: "OS X下最好用的终端"
navigation: [1.安装, 2.配置]
update: 2013-01-19
---

<section>
    <div class="page-header">
        <h3>一、安装</h3>
    </div>
    <h4><small>1.1</small> 下载</h4>
<pre>
https://code.google.com/p/iterm2/downloads/list
</pre>

    <h4><small>1.2</small> 解压移动到 @/Applications@ 目录</h4>
<pre>
$ tar -xvf iTerm2-1_0_0_*.zip
$ mv -r iTerm.app /Applications/
</pre>

    <h4><small>1.3</small> -配置tmux- <small>完全使用原生版的tmux，这种扩展方式的用起来不太顺，参考: "tmux":tmux.html </small></h4>
<pre>
$ brew install libevent automake    // dependent
$ tar -xvf tmux-for-iTerm2-*.tar.gz
$ cd tmux
$ sh autogen.sh
$ ./configure
$ make clean
$ make
$ sudo make install
$ tmux -C
</pre>
</section>

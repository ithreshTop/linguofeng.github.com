---
layout: page
title: Vim
description: 很强大的文本编辑器
update: 2013-03-25
---

<section>
    <div class="page-header">
        <h3>安装</h3>
    </div>
<pre>
$ sudo apt-get install vim vim-gtk cscope
</pre>
    <p>%(label label-info).vimrc%</p>
<pre>
set tabstop=4               " 设置tab键的宽度
set shiftwidth=4            " 换行时行间交错使用4个空格
set autoindent              " 自动对齐
set backspace=2             " 设置退格键可用
set cindent shiftwidth=4    " 自动缩进4空格
set smartindent             " 智能自动缩进
set ai!                     " 设置自动缩进
set nu!                     " 显示行号
set showmatch               " 显示括号配对情况
set hlsearch                " 开启高亮显示结果
set incsearch               " 开启实时搜索功能
set nowrapscan              " 搜索到文件两端时不重新搜索
"set cursorline             " 突出显示当前行
"set hidden                 " 允许在有未保存的修改时切换缓冲区
"set list                   " 显示Tab符，使用一高亮竖线代替
syntax enable               " 打开语法高亮
syntax on                   " 开启文件类型侦测
filetype on                 " 
filetype indent on          " 针对不同的文件类型采用不同的缩进格式
filetype plugin on          " 针对不同的文件类型加载对应的插件
set nobackup                " 设置无备份文件
set nocompatible            " 不使用vi兼容的模式
</pre>
</section>

<section>
    <div class="page-header">
        <h3>插件</h3>
    </div>
    <p>%(label label-info)Taglist% 标签查看插件</p>
<pre>
先安装ctags：sudo apt-get install exuberant-ctags
下载：http://www.vim.org/scripts/script.php?script_id=273
安装：解压到 ~/.vim/
生成帮助标签：helptags ~/.vim/doc（在Vim命令中执行）
启动：TlistToggle（在Vim命令中执行）
</pre>
    <p>%(label label-info)Eclim% 把Eclipse的功能集成到Vim中的插件</p>
<pre>
参考：http://eclim.org/install.html
</pre>

    <p>%(label label-info)CommandT% 快速打开文件的插件</p>
<pre>
下载：http://www.vim.org/scripts/download_script.php?src_id=18167
$ rvm install 1.8.7 // 必须使用1.8.7
$ rvm use 1.8.7
$ vim command-t-1.4.vba // :so %
$ cd ~/.vim/ruby/command-t
$ ruby extconf.rb
$ make
</pre>

    <p>%(label label-info)Pathogen% 自动加载插件</p>
    <p>@安装@</p>
<pre>
$ mkdir -p ~/.vim/autoload ~/.vim/bundle
$ curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
</pre>
    <p>@$ vim .bashrc@</p>
<pre>
call pathogen#infect()
</pre>
    <p>@生成bundle目录下插件的帮助文档@</p>
<pre>
:Helptags
</pre>

    <p>%(label label-info)NERDTree% 文件浏览插件</p>
<pre>
$ cd ~/.vim/bundle
$ git clone https://github.com/scrooloose/nerdtree.git
</pre>
<p>@:Helptags@ 生成帮助文档</p>
<p>@:help NERD_tree.txt@ 查看帮助文档</p>

    <p>插件安装</p>
<pre>
$ mkdir ~/.vim && cd ~/.vim
$ git init
$ git add .
$ git commit -m 'init'
$ git remote add origin git@github.com:linguofeng/vim.git
$ git push origin master
$ mkdir ~/.vim/bundle
$ git submodule add git://github.com/tpope/vim-pathogen.git bundle/vim-pathogen
$ vim ~/.vimrc
</pre>
<pre>
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
</pre>

    <p>@bufexplorer@</p>
<pre>
$ git submodule add https://github.com/vim-scripts/bufexplorer.zip.git bundle/bufexplorer
$ git add .
$ git commit -m 'install bufexporer plugin'
</pre>

    <p>@生成插件文档@</p>
<pre>
$ vim >> :Helptags  # 启动vim后执行Helptags命令
$ vim ~/.vim/.gitmodules
>>  [submodule "bundle/vim-pathogen"]
>>      path = bundle/vim-pathogen
>>      url = git://github.com/tpope/vim-pathogen.github
>>      ignore = untracked      // 添加此项不提交生成的帮助文件
</pre>

    <p>@升级插件@</p>
<pre>
$ cd ~/.vim/bundle/xxx && git pull origin master                # 更新某个插件
$ cd ~/.vim/ && git submodule foreach git pull origin master    # 更新所有插件
</pre>

    <p>@删除插件@</p>
<pre>
$ cd ~/.vim && git rm bundle/xxx
</pre>

    <p>@同步到github@</p>
<pre>
$ git add .
$ git commit -m '添加插件'
$ git push origin master
</pre>

    <p>@同步到另一台电脑@</p>
<pre>
$ git clone git@github.com:linguofeng/vim.git ~/.vim
$ ln -s ~/.vim/vimrc ~/.vimrc
$ cd ~/.vim
$ git submodule init
$ git submodule update
</pre>

    <h4>安装cscope与vim插件</h4>
<pre>
$ sudo apt-get install cscope
$ curl -so ~/.vim/bundle/cscope/plugin/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim
$ cscope -Rbkq ~/test/vimtest/zombie_game # 此时在zombie_game文件夹中生成cscope.out文件
$ gvim                      # 启动gvim(下面都是vim命令)
    :pwd                    # 查看当前vim的工作目录
    :cd ~/workspace         # 改变当前vim的工作目录为workspace
    :cs add ~/test/vimtest/zombie_game/cscope.out ~/test/vimtest/zombie_game    # 添加cscope.out到cscope数据库中，对应路径，否则会出现找不到文件的错误。
    :cs show                # 查看已经连接的数据库
    :cs kill cscope.out     # 断开已经连接的数据库
    :cs f g symbol          # 对应快捷键 Ctrl+]
</pre>
 <p>@Ctrl+]@ :进入这个函数</p>
 <p>@Ctrl+T@ :返回搜索前的位置</p>

    <h4>生成工程的cscope.files并生成cscope.out</h4>
<pre class="prettyprint">
# 切换当前vim工作目录为工程目录
$ cd /path/to/project

# 搜索当前目录下所有.h、.c、.cpp文件并生成cscope.files文件列表
$ find . -name '*.h' -o -name '*.c' -o -name '*.cpp' > cscope.files

$ cscope -b
# 根据cscope.files生成cscope.out数据库文件

$ vim # 在当前工程里启动vim，然后执行下面的命令连接cscope.out数据库，在前面加上的路径是(.)
    :cs add cscope.out .
</pre>
</section>

<section>
    <div class="page-header">
        <h3>三、技巧</h3>
    </div>
    <h4><small>3.1</small> 替换(substitute)</h4>
<div class="lgf-command">:[range]s/source/destination/[option]</div>
<pre class="lgf-command-description">
range: 范围
    1,20    从第1行到20行
    %       整个文件
    .,$     从当前行到末尾
    1,$     从第1行到末尾

s: 替换操作

source: 原内容

destination: 目标内容

option: 参数，省略时显替换第一个匹配的词
    g:      全局替换
    c:      需要确认替换
    p:      逐行替换
    i:      不区分大小写
    e:      不显示error
</pre>
    
    <h4><small>3.2</small> 去掉^M字符</h4>
<div class="lgf-command">:%s/^M//g</div>
<pre class="lgf-command-description">
^M是由 Ctrl-V + Ctrl-M 生成的。
</pre>

    <h4><small>3.3</small> tab替换成空格 <small>http://vim.wikia.com/wiki/Converting_tabs_to_spaces</small></h4>
<div class="lgf-command">
:set tabstop=4          ==
:set shiftwidth=4       ||=> 添加到.vimrc配置文件中，则可直接执行retab
:set expandtab          ==
:retab
</div>
<pre class="lgf-command-description">
tabstop     tab键的宽度
shiftwidth  换行时使用4个空格
expandtab   使用空格替换tab
retab       把所有tab替换成tabstop宽度的空格
</pre>

    <h4><small>3.4</small> 文件格式</h4>
<div class="lgf-command">
:set fileformat=unix
:set fileformat=dos
:set fileformat=mac
</div>
<div class="lgf-command-description">
unix        表示是unix下的文件格式
dos         windows下的文件格式
mac         苹果下的文件格式
</div>

    <h4><small>3.5</small> 窗口管理快捷键</h4>
<pre>
ctrl + w, h     -->     选择左边窗口，存在的话
ctrl + w, j     -->     选择下边窗口
ctrl + w, k     -->     选择上边窗口
ctrl + w, l     -->     选择右边窗口
ctrl + w, w     -->     逆时针选择窗口
ctrl + w, s     -->     水平拆分窗口
ctrl + w, v     -->     垂直拆分窗口
ctrl + w, n     -->     新建一个窗口
ctrl + w, q     -->     关闭窗口
</pre>
</section>

<section>
    <ul class="history">更新历史
        <li>2013-03-25: 更新cscope插件部分</li>
        <li>2012-12-06: ...</li>
    </ul>
</section>

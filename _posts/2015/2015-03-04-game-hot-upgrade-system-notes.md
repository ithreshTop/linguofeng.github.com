---
layout: post
title: 游戏热更新系统设计记录
categories: [archive]
tags: [cocos2d-x]
---

### 问题

如何得到自上一个版本更新增加删除的文件

```bash
$ git diff \
    --name-only \
    --diff-filter=AM \
    SHA1 \
    SHA2 \
    sources
```

替换删除路径

```bash
$ git diff xxx | xargs -o -IREPLACE echo REPLACE | sed “s/sources\///“
```

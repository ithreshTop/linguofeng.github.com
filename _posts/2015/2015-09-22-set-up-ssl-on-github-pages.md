---
layout: post
title: 配置Github Pages的https
description: Set Up SSL on Github Pages With Custom Domains for Free
categories: [archive]
tags: [ssl, https, github]
---

首先申请 [https://www.cloudflare.com](https://www.cloudflare.com)，把dns服务换成cloudflare的，我原来是使用dnspod的，为了使用https我就直接换了。

它会把之前的dns记录复制过来，直接替换就可以了。设置成功后，等待几分钟，使用 [https://linguofeng.com](https://linguofeng.com) 就可以访问我的网站了。

* 一定要把dnspod里的解析停掉，要不么会有问题。

然后是修改`_config.yml`

```yaml
url: https://blog.linguofeng.com
enforce_ssl: blog.linguofeng.com
```

修改`index.html`

```html
<link rel="canonical" href="{{ site.url }}{{ page.url }}" />
<script type="text/javascript">
    var host = "blog.linguofeng.com";
    if ((host == window.location.host) && (window.location.protocol != "https:"))
        window.location.protocol = "https";
</script>
```

提交，然后刷新。

完成

参考: [https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/](https://sheharyar.me/blog/free-ssl-for-github-pages-with-custom-domains/)

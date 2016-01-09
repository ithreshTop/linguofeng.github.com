---
layout: page
title: Cocos2d-x
description: 开发过程中所遇到的异常信息
update: 2013-03-06
---

<section id="1">
  <div class="page-header">
    <blockquote><h3>java.lang.IllegalArgumentException: No config chosen</h3> <small>2013/03/06</small></blockquote>
  </div>

<p>@$ vim $COCOS2DX_ROOT/cocos2dx/platform/android/java/src/org/cocos2dx/lib/Cocos2dxGLSurfaceView.java@</p>
<pre class="prettyprint linenums">
public Cocos2dxGLSurfaceView(final Context context) {
    super(context);

+   this.setEGLConfigChooser(8, 8, 8, 8, 16, 0);
    this.setEGLContextClientVersion(2);

    this.initView();
}

public Cocos2dxGLSurfaceView(final Context context, final AttributeSet attrs) {
    super(context, attrs);

+   this.setEGLConfigChooser(8, 8, 8, 8, 16, 0);
    this.setEGLContextClientVersion(2);

    this.initView();
}
</pre>
</section>

<section id="2">
  <div class="page-header">
    <blockquote><h3>GLES/glplatform.h: No such file or directory</h3> <small>2013/03/27</small></blockquote>
  </div>

<p>@$ vim jni/Application.mk@</p>
<pre class="prettyprint linenums">
APP_ABI := armeabi armeabi-v7a
APP_PLATFORM := android-8
</pre>
</section>
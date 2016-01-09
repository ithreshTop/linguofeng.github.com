---
layout: default
title: "ViewFlipper"
description: "视图切换控件"
---

<section>
    <div class="page-header">
        <h3>一、XML布局</h3>
    </div>
<pre class="prettyprint linenums">
<!-- 方式一：通过代码动态给ViewFlipper添加视图 -->
<ViewFlipper
    android:id="@+id/viewFlipper"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent" />
    
<!-- 方式二：通过布局文件给ViewFlipper添加视图 -->
<ViewFlipper
    android:id="@+id/viewFlipper"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent">
    
    <TextView
        android:id="@+id/textView1"
        ... />
    <TextView
        android:id="@+id/textView2"
        .../>
    <TextView
        android:id="@+id/textView3"
        .../>
</ViewFlipper>
</pre>
</section>

<section>
    <div class="page-header">
        <h3>二、Activity</h3>
    </div>
<pre class="prettyprint linenums">
public class ViewFlipperDemo extends Activity {
    ViewFlipper mViewFlipper;
    
    public void onCreate(Bundle savedInstanceState){
        setContentView(R.layout.main);

        mViewFlipper = (ViewFlipper)findViewById(R.id.viewFlipper);

        // 方式一：通过代码动态给ViewFlipper添加视图
        mViewFlipper.addView(new TextView(this).setText("代码添加视图1"));
        mViewFlipper.addView(new TextView(this).setText("代码添加视图2"));
        mViewFlipper.addView(new TextView(this).setText("代码添加视图3"));
        
        // 显示上一个视图
        mViewFlipper.showPrevious();
        
        // 显示下一个视图
        mViewFlipper.showNext();
    }
}
</pre>
</section>

<section>
    <div class="page-header">
        <h3>三、手势左右识别切换视图</h3>
    </div>
<pre class="prettyprint linenums">
public class ViewFlipperDemo extends Activity {
    ViewFlipper mViewFlipper;
    // 手势识别器
    GestureDetector mGestureDetector;
    
    public void onCreate(..){
        mViewFlipper = (ViewFlipper)findViewById(R.id.viewFlipper);
        mGestureDetector = new GestureDetector(mSimpleOnGestureListener);
        
        // 方式一：通过代码动态给ViewFlipper添加视图
        mViewFlipper.addView(new TextView(this).setText("代码添加视图1"));
        mViewFlipper.addView(new TextView(this).setText("代码添加视图2"));
        mViewFlipper.addView(new TextView(this).setText("代码添加视图3"));
        
    }
    
    // 手势监听
    SimpleOnGestureListener mSimpleOnGestureListener = new SimpleOnGestureListener() {
        // e1 第一次触摸屏幕时的事件
        // e2 手指离开时的事件
        // velocityX x方向的速度
        // velocityY y方向的速度
        public boolean onFling(MotionEvent e1, MotionEvent e2, float velocityX, float velocityY) {
            // 如果垂直方向移动距离大于100时，手势识别为无效
            if(Math.abs(e1.getY() - e2.getY()) > 100) {
                return false;
            }
            
            // 向右滑动的事件（并且速度要达到要求时）
            if(e2.getX() - e1.getX() > 100 && Math.abs(velocityX) > 100) {
                // 动画效果
                // 下一个视图进来的效果
                mViewFlipper.setInAnimation(new AlphaAnimation(0.0f, 1.0f).setDuration(500));
                // 当前视图出去的效果
                mViewFlipper.setOutAnimation(new AlphaAnimation(1.0f, 0.0f).setDuration(500));
                
                // 显示下一个视图
                mViewFlipper.showNext();
            }

            // 向左滑动的事件（并且速度要达到要求时）
            if(e1.getX() - e2.getX() > 100 && Math.abs(velocityX) > 100) {
                // 显示上一个视图
                mViewFlipper.showPrevious();
            }
            
            return super.onFling(e1, e2, velocityX, velocityY);
        }
    };
    
    // 响应触摸事件
    public boolean onTouchEvent(MotionEvent event) {
        // 给手势识别添加触摸动作
        mGestureDetector.onTouchEvent(event);
        return true;
    }
    
    // 让触摸事件更好的分发
    public boolean dispatchTouchEvent(MotionEvent ev) {
        // 如果mSimpleOnGestureListener响应到事件返回false
        boolean flag = mGestureDetector.onTouchEvent(event);
        if(!flag) {
            flag = super.dispatchTouchEvent(ev);
        }
        return flag;
    }
}
</pre>
</section>
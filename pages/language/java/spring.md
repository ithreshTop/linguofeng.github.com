---
layout: default
title: "Spring"
description: "业务层框架"
date: 2012-11-29
---

<section>
    <div class="page-header">
        <h3>一、HelloWorld</h3>
    </div>

    <h4>创建业务类</h4>
<pre class="prettyprint">
/**
 * GreetingService
 */
public class GreetingService {
    private String greeting ;
    public String getGreeting() {
        return greeting;
    }
    public void setGreeting(String greeting) {
        this.greeting = greeting;
    }
    public void sayGreeting(){
        System.out.println(greeting);
    }
}
</pre>

    <h4>创建配置文件 <small>applicationContext.xml</small></h4>
<pre class="prettyprint">
<?xml version="1.0" encodeing="utf-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
           http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">
    <!-- 配置spring的bean -->
    <bean id="greetingService" class="com.linguofeng.spring.service.GreetingService">
        <!-- 给属性set值 -->
        <property name="greeting">
            <value>hello world</value>
        </property>
    </bean>
</beans>
</pre>

    <h4>运行</h4>
<pre class="prettyprint">
public static void main(String[] args) {
    //应用上下文
    ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
    GreetingService gs = (GreetingService) ac.getBean("greetingService");
    gs.sayGreeting();
}
</pre>
</section>

<section>
    <div class="page-header">
        <h3>二、IOC控制反转 <small>inverse of control 获得依赖对象的方式被反转了</small></h3>
    </div>

    <h4>1.对象的实例化由spring完成</h4>
    <h4>2.组装对象时候的出发点是反的，传统方式是自上而下，按部就班的。set属性</h4>
<pre class="prettyprint">
A a = new A();
B b = new B();
// 依赖A
b.setA(a);
C c = new C();
// 依赖B
c.setB(b);
D d = new D();
// 依赖C
d.setC(c);
</pre>
    <h4>3.spring是自下而上的，从最想要的bean出发，顺藤摸瓜的。ref属性</h4>
<pre class="prettyprint">
<bean id="a" class="A" />
<bean id="b" class="B">
    <property name="a">
        <ref bean="a" />
    </property>
</bean>
<bean id="c" class="C">
    <property name="b">
        <ref bean="b" />
    </property>
</bean>
<bean id="d" class="D">
    <property name="c">
        <ref bean="c" />
    </property>
</bean>
</pre>
    <h4>4.DI dependencey injection 依赖注入。</h4>
</session>

<section>
    <div class="page-header">
        <h3>三、BeanFactory <small>功能简单，只有DI的功能</small></h3>
    </div>
    <h4><small>3.1</small> Bean加载方式：</h4>
<pre>
延迟加载，延迟加载所有的Bean，直到getBean()才实例化。
</pre>
</section>

<section>
    <div class="page-header">
        <h3>四、ApplicationContext <small>应用上下文，建立在BeanFactory之上，除了DI外还有系统架构的服务。</small></h3>
    </div>
</section>

    <h4><small>4.1</small> Bean加载方式：</h4>
<pre>
只加载scope="singleton"属性的bead，getBean的时候不需要等待加载时间，不加载scope="prototype"属性的bean。
</pre>
    <h4><small>4.2</small> 单例Bean：</h4>
<pre class="prettyprint">
<!-- 默认是singleton -->
<bean .. scope="singleton" />
<!--
scope范围:
    singleton：   单例，通过map的方式实现，key-value。
    prototype：   原型，每次getBean，返回的是新的对象。
    request：
    session：
    global-session：
-->  
</pre>

    <h4><small>4.3</small> 加载配置文件的方式：</h4>
<pre>
ClassPathXmlApplicationContext：  com/linguofeng/applicationContext.xml 包路径
FileSystemXmlApplicationContext： c:\\applicationContext.xml 绝对路径
XmlWebApplicationContext：        从web路径中加载，三大框架整合是用到
</pre>
</section>

<section>
    <div class="page-header">
        <h3>五、Bean的生命周期</h3>
    </div>

    <h4><small>5.1</small> Bean的实例过程</h4>
<pre>
第1步：Constructor 实例
第2步：DI 依赖注入，调用setXxx()方法，方法调用顺序与applicationContext.xml中配置顺序一致。
第3步：BeanNameAware Bean名关注
          实现BeanNameAware接口并实现setBeanName(String beanName){}方法
第4步：BeanFactoryAware Bean工厂关注
          实现BeanFactoryAware接口并实现setBeanFactory(){}方法
第4步`：ApplicationContextAware 此接口是ApplicationContext与BeanFactory的区别
第5步：BeanPostProcessor postProcessorBeforeInitiliaztion 初始化之前后处理器
          实现BeanPostProcessor接口并实现postProcessorBeforeInitiliaztion方法
第6步：init-method Bean实例化
          <bean ... init-method="指定初始化方法" />
第7步：BeanPostProcessor postProcessorAfterInitiliaztion 初始化之后后处理器
          实现BeanPostProcessor接口并实现postProcessorAfterInitiliaztion方法
</pre>

<pre>
Bean的初始化：
    // xml
    <bean ... init-method="" />
    // 注解
    @PostConstruct
        // 注解需要CommonAnnotationBeanProcessor类
        <bean class="com.springframwork.context.annotation.CommonAnnotationBeanProcessor" />
    // 执行
    ClassPathXmlApplicationContext.destroy();
</pre>

<pre>
Bean的销毁：
    // xml
    <bean ... destroy-method="" />
    // 注解
    @PreDestroy
        // 注解需要CommonAnnotationBeanProcessor类
        <bean class="com.springframwork.context.annotation.CommonAnnotationBeanProcessor" />
    // 执行
    ClassPathXmlApplicationContext.destroy();
</pre>

    <h4><small>5.2</small> Bean的装配</h4>
<pre>
    1.<bean id="" class="" />
    2.简单值：<property name="" vaule="" />
    3.引用bean：<property name="" ref="" />
    4.内部bean：类似于内部类，不需要ID
        <property name="student">
            <bean class="com.linguofeng.bean.Student" />
        </property>
</pre>
     
    <h4><small>5.3</small> 集合装配</h4>
<pre class="prettyprint">
<!-- List：ArrayList -->
<property name="nums">
    <list>
        <value>1</value>
        <value>2</value>
        <ref bean="" />
        <bean class="" />
    </list>
</property>

<!-- 需要引入：spring-util-2.5.xsd -->
<util:list id="myList">
    <value>1</value>
    <value>2</value>
    <ref bean="" />
    <bean class="" />
</util:list>

<property name="list" ref="myList" />
</pre>

<pre class="prettyprint">
<!-- Set：LinkedHashSet -->
<property name="set">
    <set>
        <value>1</value>
        <value>2</value>
        <ref bean="" />
        <bean class="" />
    </set>
</property>

<util:set id="mySet">
    <value>1</value>
        <value>2</value>
        <ref bean="" />
        <bean class="" />
</util:set>

<property name="set" ref="mySet" />
</pre>

<pre class="prettyprint">    
<!-- Map：LinkedHashMap -->
<property name="map">
    <map>
        <entry key="" value="" />
        <entry key-ref="" value-ref />
        <entry key="">
            <bean class="" />
        </entry>
    </map>
</property>

<util:map id="myMap">
    <entry key="" value="" />
    <entry key-ref="" value-ref />
    <entry key="">
        <bean class="" />
    </entry>
</util:map>

<property name="map" ref="myMap" />
</pre>

<pre class="prettyprint">
<!-- Properties -->
<property name="prop">
    <props>
        <prop key="key1">value1</prop>
        <prop key="key2">value2</prop>
        <prop key="key3">value3</prop>
    </props>
</property>
</pre>

    <h4><small>5.4</small> 使用构造函数装配</h4>
<pre>
<property>：        通过set方法来注入，不保证一定注入上。
<constructor-arg>： 通过构造函数参数注入，在property节点之上。
缺点：               解决构造函数参数不确定性
    解决：
        type：   java.lang.String 指定参数类型，基本类型就直接写int\long\double
        index：  指定参数的位置
</pre>

    <h4><small>5.5</small> 自动装配</h4>
<pre class="prettyprint">
<!--
使用XML配置自动装配
default：        默认。
byName：         根据Bean的ID名称自动装配。
byType：         寻找和属性的类型相同的bean装配上，找到多个时抛异常，byName和byType都是通过set方法来装配的，要求类必须有空的构造函数。
constructor：    通过构造函数参数的类型自动装配，找不到或者找到多个bean都抛异常。
autodetect:      自动检测，在byType和constructor中选一个。标准看构造函数是否带参，带用constructor。
no：             不使用自动装配。
混合使用：        手动覆盖自动。
-->
<bean id="" class="" autowrie="default" />
</pre>

<pre class="prettyprint">
// 使用注解自动装配
// 使用注解前需要配置自动装配bean后处理器：<bean class="AutowiredAnnotationBeanPostProcessor" />
@Autowired // 构造函数装配
public String auto;

@Autowired // set方法注入装配
public void setAuto(String auto) {
    this.auto = auto;
}
// 简化后处理器的使用
// 引入spring-context-2.5.xsd
// 激活@PostConstruct @PreDestory @Autowired 还可以选择单独激活相应的后处理器
// <context:annotaton-config />

</pre>

    <h4><small>5.6</small> 创建Bean的方式之工厂方式</h4>
<pre class="prettyprint">
<!-- 方式一、通过工厂的静态方法创建Bean -->
<bean id="bean" class="BeanFactory" factory-method="getBean" />

<!-- 方式二、通过工厂的实例方法创建Bean -->
<bean id="factory" class="BeanFactory" />
<bean id="bean" factory-bean="factory" factory-method="getBean" />
</pre>

    <h4><small>5.7</small> 创建Bean的方式之Spring内置工厂接口方式</h4>
<pre class="prettyprint">
// 实现FactoryBean接口
public MyFactoryBean implements FactoryBean {
    // 获取对象
    public Object getObject(){
        return new Student;
    }
    
    // 对象的类型
    public Class getObjectType(){
        return Student.class;
    }
    
    // 是否是单例
    public boolean isSingleton(){
        return true;
    }
}

<bean id="student" class="MyFactoryBean" />
</pre>

    <h4><small>5.8</small> Bean的继承关系</h4>
<pre class="prettyprint">
<!-- 不指定class必须是抽象的 -->
<bean id="abc" abstract="true">
    <property name="" value="" />
</bean>

<bean id="parent" class="Parent">
    <property name="id" value="1" />
    <property name="name" value="haha" />
</bean>

<!-- parent="parent"：继承id=parent为bean -->
<bean id="child" parent="parent" class="Child">
    <!-- 覆盖父的id值 -->
    <property name="id" value="2" />
</bean>

<!-- Bean继承的是配置内容，与类的继承没有关系。 -->
</pre>
</section>

<section>
    <div class="page-header">
        <h3>六、分散配置</h3>
    </div>

    <h4><small>6.1</small> 外部配置</h4>
<pre class="prettyprint">
<!-- 属性占位符 -->
<bean class="PropertyPlaceholderConfigurer">
    <property name="location" value="classpath:com/linguofeng/jdbc.porperties" />
</bean>

${key}

<!-- 简化的方法，需要引用spring-context-2.5.xsd -->
<context:property-placeholder location="classpath:com/linguofeng/jdbc.porperties" />
</pre>

    <h4><small>6.2</small> 属性编辑器</h4>
<pre class="prettyprint">
// 能够以<value>方式装配bean类型的属性
// 自定义编辑器
class Edit extends PropertyEditorSupport {
    public void setAsText(String text){
        // 把修改后的对象返回
        this.setValue(new Bean);
    }
}

// 注册编辑器
<bean class="CustomEditorConfigurer">
    <property name="customEditors">
        <map>
            <entry key="com.linguofeng.xxx.Aaa">
                <bean class="AaaEdit" />
            </entry>
        </map>
    </property>
</bean>
</pre>
</section>

h3(#7). AOP 面向切面编程 %(title)AOP%
<hr />

*(7#701) *名词介绍* %(title)名词介绍%
<hr />

<pre>
核心就是代理，本质是不改变源代码，为类增加新的功能。
是对oop的增强
切面：要实现的交叉功能
通知：切面的实际实现，是切面的细化，更加具体。
引入：给类增加新的属性和方法，不改变源码。

连接点：程序在运行期间，可以应用切面的地点:方法的调用、字段的修改、抛出异常时。
切入点：真正的将通知应用到目标程序中的地点，切入点一定是连接点，是连接点的子集。

目标对象：被通知的对象。
代理对象：把通知应用到目标对象后创建的新的对象，且全权代理目标对象。
 
 织入：是一个过程，将切面应用到目标对象从而创建一个新代理对象的过程，多个时间点可以织入
       编译期织入：   在java源代码编译成class文件时，将通知织入，改变的是字节码，需要特殊的类编译器。
       类装载期织入： 把java类装载到VM虚拟机的时候，将通知织入，不改变源代码与字节码，需要特殊的类装载器。
       运行期织入：   在运行期间，动态将通知织入。（Spring）    
</pre>

*(7#702) *Spring创建代理的两种方式* Spring是运行时通知对象 %(title)Spring创建代理%
<hr />

<pre>
一、接口代理使用：java.lang.reflect.Proxy，优于对类代理，松耦合。
二、类代理使用：使用CGLIB库，final方法不能被代理。
</pre>

*(7#703) *Spring创建前置通知（类）* %(title)前置通知%
<hr />

<pre>
// 1.创建接口

// 2.创建接口实现类

// 3.前置通知 MethodBeforeAdvice：方法前通知
public class MyMethodBeforeAdvice impliments MethodBeforeAdvice {
    public void before(){
        
    }
}

// 4.前置通知配置文件
<!-- 前置通知 -->
<bean id="myMethodBeforeAdvice" class="MyMethodBeforeAdvice" />
<!-- 目标对象：自动代理时被getBean("xxx")使用 -->
<bean id="xxx" class="实现类" />
<!-- 代理对象：在调用时就是调用该代理对象 -->
<bean id="aaa" clss="ProxyFactoryBean">
    <!--
        ProxyFactoryBean的属性：
        target：             目标对象
        proxyInterfaces：    接口集
        interceptorNames：   拦截器集
        singleton：          单例
        aopProxyFactory：    
        exposeProxy：        
        frozen：             true不能修改ProxyFactoryBean
        optimize：           优化CGLIB
        ProxyTargetClass：   CGLIB才使用
    -->
    <!-- 代理接口集：作用让代理对象动态实现与实现类相同的接口 -->
    <property name="proxyInterfaces">
        <list>
            <value>实现类实现的接口的完整类名</value>
        </list>
    </property>
    <!-- 拦截器名集 -->
    <property name="interceptorNames">
        <list>
            <value>myMethodBeforeAdvice</value>
        </list>
    </property>
    <!-- 指定代理的目标对象 -->
    <property name="target" ref="xxx" />
    
    <!-- 对类进行代理：使用CGLIB库，getBean时可以转换为实现类 -->
    <!-- <property name="proxyTargetClass" value="true" />-->
</bean>
</pre>

*(7#704) *Spring创建后置通知（类）* %(title)后置通知%
<hr />

<pre>
// 1.创建接口

// 2.创建接口实现类

// 3.后置通知 MethodAfterReturningAdvice：方法返回后通知
public class MyMethodAfterReturningAdvice impliments MethodAfterReturningAdvice {
    public void afterReturning(){
        // TODO
    }
}

// 4.后置通知配置文件（与前置通知类似）
<!-- 后置通知 -->
<bean id="myMethodAfterReturningAdvice" class="MyMethodAfterReturningAdvice" />
<!-- 目标对象 -->
<bean id="xxx" class="实现类" />
<!-- 代理对象：在调用时就是调用该代理对象 -->
<bean id="aaa" clss="ProxyFactoryBean">
    <!-- 代理接口集：作用让代理对象动态实现与实现类相同的接口 -->
    <property name="proxyInterfaces">
        <list>
            <value>实现类实现的接口的完整类名</value>
        </list>
    </property>
    <!-- 拦截器名集 -->
    <property name="interceptorNames">
        <list>
            <value>myMethodAfterReturningAdvice</value>
        </list>
    </property>
    <!-- 指定代理的目标对象 -->
    <property name="target" ref="xxx" />
    
    <!-- 对类进行代理：使用CGLIB库，getBean时可以转换为实现类 -->
    <!-- <property name="proxyTargetClass" value="true" /> -->
</bean>
</pre>

*(7#705) *Spring创建环绕通知（类）* %(title)环绕通知%
<hr />

<pre>
// 环绕通知（方法拦截器）
public class MyMethodInterceptor implements MethodInterceptor{
    public Object invoke() {
        // 调用目标对象方法
        return arg0.proceed();
    }
}

// 配置
<bean id="myMethodInterceptor" class="MyMethodInterceptor" />
<!-- 目标对象 -->
<bean id="xxx" class="实现类" />
<!-- 代理对象：在调用时就是调用该代理对象 -->
<bean id="aaa" clss="ProxyFactoryBean">
    <!-- 代理接口集：作用让代理对象动态实现与实现类相同的接口 -->
    <property name="proxyInterfaces">
        <list>
            <value>实现类实现的接口的完整类名</value>
        </list>
    </property>
    <!-- 拦截器名集 -->
    <property name="interceptorNames">
        <list>
            <value>myMethodInterceptor</value>
        </list>
    </property>
    <!-- 指定代理的目标对象 -->
    <property name="target" ref="xxx" />
    
    <!-- 对类进行代理：使用CGLIB库，getBean时可以转换为实现类 -->
    <!-- <property name="proxyTargetClass" value="true" /> -->
</bean>
</pre>

*(7#706) *Spring创建异常通知（类）* %(title)异常通知%
<hr />

<pre>
// 异常通知
public class MyThrowsAdvice implements ThrowsAdvice {
    public void afterThrowing(Method method, Object[] objects, Object target, Throwable throwable) {
        // TODO 异常时执行
    }
}

// 配置
<bean id="myThrowsAdvice" class="MyThrowsAdvice" />
<!-- 目标对象 -->
<bean id="xxx" class="实现类" />
<!-- 代理对象：在调用时就是调用该代理对象 -->
<bean id="aaa" clss="ProxyFactoryBean">
    <!-- 代理接口集：作用让代理对象动态实现与实现类相同的接口 -->
    <property name="proxyInterfaces">
        <list>
            <value>实现类实现的接口的完整类名</value>
        </list>
    </property>
    <!-- 拦截器名集 -->
    <property name="interceptorNames">
        <list>
            <value>myThrowsAdvice</value>
        </list>
    </property>
    <!-- 指定代理的目标对象 -->
    <property name="target" ref="xxx" />
    
    <!-- 对类进行代理：使用CGLIB库，getBean时可以转换为实现类 -->
    <!-- <property name="proxyTargetClass" value="true" /> -->
</bean>
</pre>

*(7#707) *Spring创建引入通知（类）* %(title)引入通知%
<hr />

<pre>
切入点知识：是一些规则，某个类的某个方法是否符合规则，符合就加入通知。
// 切入点接口
public interface Pointcut {
    // 类过滤器
    getClassFilter();
    // 方法匹配器
    getMethodMatcher();
}
// 类过滤器
public interface ClassFilter {
    matches(Class clazz);
}
// 方法匹配器
public interface MethodMatcher {
    matches(Method method, Class targetClass);
    isRuntime();// false 总是执行上面matches，否需要判断
    matches(Method method, Class targetClass, Object[] args);
}

// 理解Advisor（集成了通知与切入点，即：切入点通知）

// 创建Spring静态切入点：名称匹配方法切入点通知，对通知进行包装，增加定义切入点的功能
<bean id="beforeAdivsor" class="...NameMatchMethodPointcutAdvisor">
    <!-- 对前置通知进行包装 -->
    <property name="advice" ref="myMethodBeforeAdvice" />
    <property name="mappedNames">
        <list>
            <!-- 允许哪些方法添加切入通知，支持正则 -->
            <value>方法名*</value>
        </list>
    </property>
</bean>

    <!-- 拦截器名集 -->
    <property name="interceptorNames">
        <list>
            <value>beforeAdivsor</value>
        </list>
    </property>
</pre>

<pre>
// 创建引入通知：添加新的属性或方法
// 代理引入拦截器（引入通知）
public class MyDII extends DelegatingIntroductionInterceptor implements 自定义接口 {
    
}

// 引入通知配置
<bean id="myDII" class="MyDII" />
// 默认引入切入点通知，对引入通知进行包装，类似于名称匹配方法切入点通知
<bean id="myDIIAdvisor" class="DefaultIntroductionAdvisor">
    <!-- 构造函数初始化 -->
    <constructor-arg ref="myDII" />
<bean>

    <!-- 代理接口集：作用让代理对象动态实现与实现类相同的接口 -->
    <property name="proxyInterfaces">
        <list>
            <value>MyDII实现的接口的完整类名</value>
        </list>
    </property>
    
    <!-- 拦截器名集 -->
    <property name="interceptorNames">
        <list>
            <value>myDIIAdvisor</value>
        </list>
    </property>
</pre>

*(7#708) *Spring自动代理（类）* %(title)自动代理%
<hr />

<pre>
<!-- BeanNameAutoProxyCreator Bean名自动代理创建器 -->
<bean class="...BeanNameAutoProxyCreator">
    <!-- 拦截器名集 -->
    <property name="interceptorNames">
        <list>
            <value>myDIIAdvisor</value>
        </list>
    </property>
    <!-- 根据Bean名自动创建代理，支持通配符* -->
    <property name="beanNames">
        <list>
            <value>*Target</value>
        </list>
    </property>
</bean>

<!-- DefalutAdvisorAutoProxyCreator 默认切入点通知自动代理创建器 -->
<bean class"...DefalutAdvisorAutoProxyCreator">
</bean>
</pre>

h3(#8). *Aspectj进行AOP开发* 需要引入Aspectj依赖 %(title)Aspectj的AOP%
<hr />

* 创建类 引入spring-aop-2.5.xsd 
<hr />

<pre>
/** 通知 */
@Aspect
public class Audience {
    // 单独定义切入点供重用
    @Pointcut("execution(* Performet.*(..))")
    public void performet(){}

    @Before("execution(* Performet.*(..))") // 执行任意返回值 Performet这个接口下的任意带参数不带参数的方法
    public void takeSeat(JonPoint jp){
        // 方法签名
        jp.getSignature().getName();
        // 参数值列表
        jp.getArgs();
        // 目标对象
        jp.getTarget();
        // 代理对象
        jp.getThis();
        sysout("takeSeat");
    }
    @Before("performet()")
    public void trunOffCellphone(){
        sysout("trunOffCellphone");
    }
    // pointcut指定切入点的表达式
    @AfterReturning(pointcut = "performet()", returning="ret") // 不抛异常才执行
    public void applaud(Object ret){// ret为接收返回值
        sysout("applaud");
    }
    @AfterThrowing(pointcut = "performet()", throwing = 'e") // 出现异常
    public void paymentRefund(Exception e){ // e接收异常信息
        sysout("paymentRefund");
    }
    @After("performet()")
    public void goHome(){
        sysout("goHome");
    }
}

/** 接口类 */
public interface Performet {
    void show();
}

/** 实现类 */
public class Singer implements Performet {
    public void show(){
        sysout("我是一个歌手");
    }
}

// applicationContext.xml配置
<!-- 观众通知 -->
<bean id="audience" class="..Audience" />
<!-- 歌手 -->
<bean id="singer" class="..Singer" />
<!-- Aspectj自动代理 -->
<aop:aspectj-autoproxy />

// 引入通知
@DeclareParents(value="表示给哪些类加上属性或接口",
defaultImpl=XxImpl.class)
public Xx xx;
</pre>

* pojo+xml 引入spring-aop-2.5.xsd 
<hr />

<pre>
<!-- 观众通知 -->
<bean id="audience" class="..Audience" />
<aop:config>
    <aop:aspect ref="audience">
        <!-- 定义切入点 -->
        <aop:pointcut id="pointcut" expression="execution(* *.Performet.*(..))" />
        
        <!-- 定义前置通知 -->
        <aop:before mothod="takeSeat" pointcut-ref="pointcut" />
        
        <aop:after-returning method="" pointcut-ref="" returning="" />
        <aop:after-throwing method="" pointcut-ref="" throwing="" />
        
        <!-- 引入通知 -->
        <aop:declare-parents types-matching="com...Singer" implement-interface="实现的接口" defalut-impl="默认接口实现类" />
        
        <!-- 环绕通知 -->
        ...
    <aop:aspect>
</aop:config>
</pre>

h3(#9). *Spring操纵数据库* Spring操纵数据库 %(title)Spring操纵数据库%
<hr />

*(9#901) Spring数据库操作之JDBC数据库源配置 %(title)Spring之Jdbc配置%

<pre class="brush: xml">
<context:property-placeholder location="classpath:jdbc.properties"/>
<!-- C3P0连接池 -->
<bean id="dataSource" class="com.mchange.v2.c3p0.ComboPooledDataSource" destroy-method="close">
    <property name="driverClass" value="${jdbc.driverClassName}"/>
    <property name="jdbcUrl" value="${jdbc.url}"/>
    <property name="user" value="${jdbc.username}"/>
    <property name="password" value="${jdbc.password}"/>
</bean>

<bean id="jdbcTemplate" class="...JdbcTemplate">
    <property name="dataSource" ref="dataSource" />
</bean>
<bean id="xxx" class="...xxxImpl">
    <property name="jdbc" ref="jdbcTemplate" />
</bean>
</pre>

*(9#902) Spring数据库操作之JDBC DAO %(title)JdbcTemplate%
<hr />

<pre class="brush: java">
private JdbcTemplate jdbc;
// 要配置文件中让Spring注入JdbcTemplate
public void setJdbc(JdbcTemplate jdbc){
    this.jdbc = jdbc;
}
public void insert(){
    String sql = "";
    jdbc.update(sql,new Object[]{});
}

//JdbcDaoSupport 代替 private JdbcTemplate jdbc;
public class Abc extends JdbcDaoSupport {
    public void insert(){
        String sql = "";
        getJdbcTemplate.update(sql,new Object[]{});
    }
}

//SimpleJdbcDaoSupport 代替 private JdbcTemplate jdbc;
public class Abc extends SimpleJdbcDaoSupport {
    public void insert(){
        String sql = "";
        getJdbcTemplate.update(sql, 可变参数需要JDK1.5+支持);
    }
}
</pre>

*(9#903) Spring数据库操作之Hibernate DAO %(title)HibernateTemplate%
<hr />

<pre class="brush: java">
private HibernateTemplate hibernate;
// 要配置文件中让Spring注入JdbcTemplate
public void setHibernate(HibernateTemplate hibernate){
    this.hibernate = hibernate;
}
public void insert(ccc){
    hibernate.save(ccc);
}

//HibernateDaoSupport 代替 private HibernateTemplate hibernate;
public class Abc extends HibernateDaoSupport {
    public void insert(ccc){
        getJHibernateTemplate.save(ccc);
    }
}
</pre>

h3(#10). *Spring事务管理* %(title)Spring事务管理%
<hr />

*(10#1001) HibernateCallback实现Dao层事务管理 %(title)HibernateCallback%
<hr />

<pre class="brush: java">
HibernateTemplate.execute(new HibernateCallback(){
    public Object doInHibernate(Session session) {
        Transaction tx = session.beginTransaction();
        try {
            session.save(s)
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
        }
        return null;
    }
});
</pre>

*(10#1002) Service层事务管理 %(title)Service层事务管理%
<hr />

<pre>
平台事务管理器：PlatformTransactionManager
                --DataSoruceTransactionManager
                --HibernateTransactionManager
                --...

事务模板：      TransactionTemplate
事务回调：      TransactionCallback
事务状态：      TransactionStatus

<!-- Hibernate的事务管理器 -->
<bean id="hibernateTransactionManager" class="...HibernateTransactionManager">
    <property name="sessionFactory" ref="sessionFactory" />
</bean>

<!-- 事务模板，依赖事务管理器 -->
<bean id="tt" class="...TransactionTemplate">
    <property name="transactionManager" ref="hibernateTransactionManager" />
</bean>

<!-- 服务层注入事务模板 -->
<bean id="service" class="...Service">
    <property name="tt" ref="tt" />
</bean>

// 在Service层注入事务模板
private TransactionTemplate tt;

// 在Spring配置文件中把tt注进来
public void setTt(TransactionTemplate tt) {
    this.tt = tt;
}

public void xxx {
    tt.execute(new TransactionCallback() {
        public Object doInTransaction(TransactionStatus status) {
            try{
                // TODO 进行事务的增删改操作
            }catch(){
                // 回滚
                status.setRollbackOnly();
            }
        }
    }
}
</pre>

*(10#1003) AOP实现事务管理 %(title)AOP实现事务管理%
<hr />

<pre class="brush: xml">
<!-- Hibernate的事务管理器 -->
<bean id="hibernateTransactionManager" class="...HibernateTransactionManager">
    <property name="sessionFactory" ref="sessionFactory" />
</bean>

<bean id="studentDaoImplTarget" class="com.linguofeng.spring.tx.dao.StudentDaoImpl">
    <property name="studentDao" ref="studentDao" />
</bean>

<!-- TransactionProxyFactoryBean依赖事务管理器 -->
<bean id="studentDaoImpl" class="...TransactionProxyFactoryBean">
    <!-- 事务管理器 -->
    <property name="transactionManager" ref="hibernateTransactionManager" />
    
    <!-- 代理接口集 -->
    <property name="proxyInterface">
        <list>
            <value>com.linguofeng.spring.tx.dao.StudentDao</value>
        </list>
    </property>
    
    <!-- 目标对象 -->
    <property name="traget" ref="studentDaoImplTarget" />
    
    <!-- 事务属性集 -->
    <property name="transactionAttributes">
        <props>
            <!-- 环绕通知拦截的是方法名,所以所有以insert开头的方法都会被事务管理 -->
            <prop key="insert*">PROPAGATION_REQUIRED,ISOLATION_DEFAULT</prop>
        </props>
    </property>
</bean>

-----------------------------------------------------------------------------------------

<!-- 抽象公共的代理对象 -->
<bean id="abstractTx" abstract="true" class="...TransactionProxyFactoryBean">
    <!-- 事务管理器 -->
    <property name="transactionManager" ref="hibernateTransactionManager" />
    
    <!-- 事务属性集 -->
    <property name="transactionAttributes">
        <props>
            <!-- 环绕通知拦截的是方法名,所以所有以insert开头的方法都会被事务管理 -->
            <prop key="insert*">PROPAGATION_REQUIRED,ISOLATION_DEFAULT</prop>
            <prop key="delete*">PROPAGATION_REQUIRED,ISOLATION_DEFAULT</prop>
            <prop key="update*">PROPAGATION_REQUIRED,ISOLATION_DEFAULT</prop>
            <prop key="find*">PROPAGATION_REQUIRED,ISOLATION_DEFAULT,readOnly</prop>
        </props>
    </property>
</bean>

<bean id="studentDaoImp" ref="abstractTx">
    <!-- 代理接口集 -->
    <property name="proxyInterface">
        <list>
            <value>com.linguofeng.spring.tx.dao.StudentDao</value>
        </list>
    </property>
    
    <!-- 目标对象 -->
    <property name="traget" ref="studentDaoImplTarget" />
    <!-- 暴露代理,将代理对象绑定到当前线程 -->
    <property name="exposeProxy" value="true" />
    <!--
        当前线程中的代理对象：AopContext.currentProxy();
    -->
</bean>

-----------------------------------------------------------------------------------------

// tx:advice标签，需要引用spring-tx-2.5.xsd

<!-- Hibernate的事务管理器 -->
<bean id="hibernateTransactionManager" class="...HibernateTransactionManager">
    <property name="sessionFactory" ref="sessionFactory" />
</bean>

<!-- Dao接口 -->
<bean id="studentDao" class="com.linguofeng.spring.tx.dao.StudentDaoImpl">
    <property name="sessionFactory" ref="sessionFactory" />
</bean>

<!-- 注解时使用，扫描指定包下的带@Service、@Repository、@Controller、@Component、@Resource -->
<context:compoent-scan base-package="com.linguofeng" />

<!--
加入注解去年<bean..配置
@Service()--Service层
@Repository("studentDao")--Dao层
@Controller()--Action层
@Component()--都可以
public class StudentDaoImpl implements StudentDao {
    SessionFactory sessionFactory;
    @Resource // 从上下文中找到sessionFactory注入会话工厂
    void setSessionFactory(SessionFactory sessionFactory){
        this.sessionFactory = sessionFactory;
    }
}
-->

<!-- 事务通知 -->
<tx:advice id="txAdvice" transaction-manager="hibernateTransactionManager">
    <tx:attributes>
        <tx:method name="insert*" propagation="REQUIRED" isolation="DEFALUT" />
        <tx:method name="update*" propagation="REQUIRED" isolation="DEFALUT" />
        <tx:method name="delete*" propagation="REQUIRED" isolation="DEFALUT" />
        <tx:method name="find*" propagation="REQUIRED" isolation="DEFALUT" read-only="true" />
    </tx:attributes>
</tx:advice>

<aop:config>
    <!-- 指定拦截哪些返回值哪些包哪些类的哪些方法带有哪些参数 -->
    <aop:advisor advice-ref="txAdvice" pointcut="execution(* *..*Impl.*(..))"
</aop:config>

-----------------------------------------------------------------------------------------
<!-- Hibernate的事务管理器 -->
<bean id="hibernateTransactionManager" class="...HibernateTransactionManager">
    <property name="sessionFactory" ref="sessionFactory" />
</bean>

<!-- 全注解事务管理配置 -->
@Transactional(paropagation=REQUIRED, isolation=DEFALUT)
public class StudentDaoImpl imple...{
    // 重载类的事务
    @Transactional(read-only=true)
    public void findxxx(){}
}

<!-- 注解驱动 -->
<tx:annotation-driven taransaction-manager="hibernateTransactionManager" />
-----------------------------------------------------------------------------------------

// 使用环绕通知实现事务管理

管理事务的两种方式:
    声明式事务管理方式：AOP
    编程式事务管理方式：硬编码方式，可以精确定义事务边界。上面实现的就是这样方式。

事务属性：
    传播行为：
        PROPAGATION_MANDATORY       必须运行在事务中，否则抛异常
        PROPAGATION_NETED           嵌套事务
        PROPAGATION_NEVER           永远也不运行在事务中，否则抛异常
        PROPAGATION_NOT_SUPPORTED   不支持事务，如果有事务就挂起不运行
        PROPAGATION_REQUIRED        必须运行在事务，没事务就开，有就直接用
        PROPAGATION_REQUIRES_NEW    必须运行在自己创建的新事务中，如果有事务原事务将挂起
        PROPAGATION_SUPPORTS        不需要事务环境，如果有事务将运行在该事务中
    隔离级别：避免出现并发现象
        脏读：读未提交的数据
        不可重复读：返回数据不一致，连续查询期间别人是更改操作
        纪读：读多了，连续查询期间别人是插入操作
        1：读未提交
        2：读已提交，避免脏读
        4：可以重复读
        8：串行化，加锁
        ISOLATION_DEFAULT             后端数据库默认隔离级别
        ISOLATION_READ_UNCOMMITED     读未提交
        ISOLATION_READ_COMMITTED      读已提交
        ISOLATION_REPEATABLE_READ     
        ISOLATION_SERIALABLE
    只读：readOnly 优化，设置Hibernate的缓存提交为FLUSH_NEVER，把缓存延迟提交
    事务超时：释放数据库资源
    回滚规则：保存出异常有的数据与不保存两种
</pre>

h3(#11). Spring调度 %(title)Spring调度%
<hr />

*(11#1101) 多线程 - 定时器任务 %(title)定时器任务%
<hr />

<pre class="brush: java">
//定时器任务
public class MyTimerTask extends TimerTask {
    public void run() {
        // TODO
    }
}
</pre>

<pre class="brush: xml">
<!-- 1.定时器任务 -->
<bean id="myTimerTask" class="...MyTimerTask" />

<!-- 2.调度定时器任务 -->
<bean id="scheduledTimerTask" class="...ScheduledTimerTask">
    <property name="timerTask" ref="myTimerTask" />
    <!-- 单位周期，单位毫秒 -->
    <property name="period" value="1000" />
    <!-- 首次启动延迟时间，单位毫秒 -->
    <property name="delay" value="1000" />
</bean>

<!-- 3.启动定时器任务 -->
<bean class="...TimerFactoryBean">
    <property name="scheduledTimerTasks">
        <list>
            <!-- 要启动的调度定时任务 -->
            <ref bean="scheduledTimerTask" />
        </list>
    </property>
</bean>
</pre>

*(11#1102) 多线程 - 石英任务（任意时刻调度，定长周期调度） %(title)石英任务%
<hr />

<pre class="brush: java">
// 石英任务Bean 需要quartz.jar
public MyQuartzJobBean extends QuartzJobBean {
    void executeInternal(...) {
        // TODO
    }
} 
</pre>

<pre class="brush: xml">
<!-- 使用任务明细bean对石英任务bean进行包装 -->
<bean id="jobDetailBean" class="...JobDetailBean">
    <property name="jobClass" class="...MyQuartzJobBean" />
</bean>

<!-- 简单触发器Bean，设置调度的策略 -->
<bean id="simpleTringgerBean" class="SimpleTringgerBean">
    <property name="jobDetail" ref="jobDetailBean" />
    <!-- 开始延迟时间，毫秒 -->
    <property name="startDelay" value="1000" />
    <!-- 重复间隔时间，毫秒 -->
    <property name="repeatInterval" value="1000" />
</bean>

<!-- cron触发器Bean，按照任意时刻调度石英任务调度策略 -->
<bean id="cronTriggerBean" class="...CronTriggerBean">
    <property name="jobDetail" ref="jobDetailBean" />
    <!-- -->
    <property name="cronExpression">
        <!-- 秒：在0秒至10秒间和19秒至29秒间都运行 -->
        <!-- 分：在0分的时候 -->
        <value>0-10,19-29秒 0分 14时 9日 2月 ? 2012年</value>
    </property>
</bean>

<!-- 调度器工厂Bean -->
<bean class="...SchedulerFactoryBean">
    <property name="triggers">
        <list>
            <!-- 定时任务 -->
            <ref bean="simpleTringgerBean" />
            <!-- 石英任务 -->
            <ref bean="cronTriggerBean" />
        </list>
    </property>
</bean>
</pre>

h3(#12). Spring与Struts2整合 %(title)Struts2整合%
<hr />

*(12#1201) web.xml  %(title)web.xml%
<hr />

<pre class="brush: xml">
<!-- Struts2过滤器 -->
<filter>
    <filter-name>struts2</filter-name>
    <filter-class>org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>struts2</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>

<!-- 通过上下文的参数指定Spring配置文件的路径 -->
<context-param>
    <param-name>contextConfigLocation</param-name>
    <param-value>classpath:beans.xml<!-- ,classpath:多个Spring配置文件.xml --></param-value>
</context-param>

<!-- Spring监听器，完成Spring容器的初始化（XmlWebApplicationContext） -->
<listener>
    <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
</listener>
</pre>

*(12#1202) beans.xml  %(title)beans.xml%
<hr />

<pre class="brush: xml">
<beans>
    <!--import resource="多个Spring配置文件的引入" /-->
    <!-- Struts2的Action是原型的Bean scope="prototype" -->
    <bean id="helloWorldAction" class="HelloWorldAction" scope="prototype" />
</beans>
</pre>

*(12#1203) struts.xml  %(title)struts.xml%
<hr />

<pre class="brush: xml">
<struts>
    <!--
        声明action交予spring托管
        在使用struts2-spring-plugin-2.3.1.1.jar插件時该值默认是spring 
        <constant name="struts.objectFactory" value="spring" />
    -->
    
    <package name="struts2" namespace="/" ex>
        <action name="HelloWorldAction_*" class="helloWorldAction" method="{1}">
            <result name="success">/index.jsp</result>
        </action>
    </package>
</struts>
</pre>

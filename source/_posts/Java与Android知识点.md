---
layout:  post
title:   Java与Android知识点
date: 2017-02-28 09:13:42
author:     "Bruce Yang"
catalog:    true
header-img: "vallehermoso_spain_from_google_earth.jpg"
tags: [Java, Android]
categories: 知识点
---
<center><font color=SkyBlue size="6px">**持续更行中**</font></center>

## 1. 解释内存中的栈（stack）、堆(heap)和静态存储区的用法。
答：通常我们定义一个基本数据类型的变量，一个对象的引用，还有就是函数调用的现场保存都使用内存中的栈空间；而通过new关键字和构造器创建的对象放在堆空间；程序中的字面量（literal）如直接书写的100、“hello”和常量都是放在静态存储区中。栈空间操作最快但是也很小，通常大量的对象都是放在堆空间，整个内存包括硬盘上的虚拟内存都可以被当成堆空间来使用。
`String str = new String(“hello”);`
上面的语句中 str 放在栈上，用 new 创建出来的字符串对象放在堆上，而“hello”这个字面量放在静态存储区。

## 2. 重写equals方法时,为什么也需要重写hashCode方法。
<!-- more -->
- 1、重写equals方法时需要重写hashCode方法，主要是针对Map、Set等集合类型的使用；

    - a: Map、Set等集合类型存放的对象必须是唯一的；

    - b: 集合类判断两个对象是否相等，是先判断equals是否相等，如果equals返回TRUE，还要再判断HashCode返回值是否ture,只有两者都返回ture,才认为该两个对象是相等的。

- 2、由于Object的hashCode返回的是对象的hash值，所以即使equals返回TRUE，集合也可能判定两个对象不等，所以必须重写hashCode方法，以保证当equals返回TRUE时，hashCode也返回Ture，这样才能使得集合中存放的对象唯一。

## 3. [Android 中的Dalvik和ART是什么，有啥区别？](http://www.jianshu.com/p/58f817d176b7)
答: 在Dalvik下，应用每次运行的时候，字节码都需要通过即时编译器（just in time ，JIT）转换为机器码，这会拖慢应用的运行效率。在ART 环境中，应用在第一次安装的时候，字节码就会预先编译成机器码，使其成为真正的本地应用。这个过程叫做预编译（AOT,Ahead-Of-Time）。这样的话，应用的启动(首次)和执行都会变得更加快速。

## 4. Glide, Picasso原理?

## 5. 事件传递机制?(参考[郭霖事件分发博客](http://blog.csdn.net/guolin_blog/article/details/9097463/))

## 6. [Okhttp原理解析,优点](https://blog.piasy.com/2016/07/11/Understand-OkHttp/)
答: 总结: `OkHttpClient` 实现 `Call.Factory`，负责为 `Request` 创建 `Call`；
`RealCall` 为具体的 `Call` 实现，其 `enqueue()` 异步接口通过 `Dispatcher` 利用 `ExecutorService` 实现，而最终进行网络请求时和同步 `execute()` 接口一致，都是通过 `getResponseWithInterceptorChain()` 函数实现；
`getResponseWithInterceptorChain()` 中利用 `Interceptor` 链条，分层实现缓存、透明压缩、网络 IO 等功能；

## 7. [内存泄漏全解析](http://mp.weixin.qq.com/s?__biz=MzA5MzI3NjE2MA==&mid=2650238704&idx=1&sn=ad334840afdc2d9bdb8215e9f942e54e&scene=0#wechat_redirect)

## 8. [热修复有所了解?](http://mp.weixin.qq.com/s/GuzbU1M1LY1VKmN7PyVbHQ)

## 9. 路由了解吗?[routerSDK](https://github.com/Jomes/routerSDK)

## 10. [foreach原理](http://blog.csdn.net/cq1982/article/details/49121879)
答: foreach语法最终被编译器转为了对Iterator.next()的调用。而作为使用者的我们，jdk并没用向我们暴露这些细节，我们甚至不需要知道Iterator的存在，认识到jdk的强大之处了吧。

## 11. [EventBus 源码解析](http://a.codekk.com/detail/Android/Trinea/EventBus%20%E6%BA%90%E7%A0%81%E8%A7%A3%E6%9E%90)
答: [总结:](http://www.jianshu.com/p/e41e580eff10) 底层也是回掉实现。优点：EventBus是很好地替代了回调的功能，松耦合，使用简单。缺点：只要用得一多，那消息类的数量必然是会爆炸性增长，调试的时候除非熟悉整块逻辑，不然不跑起来你是没办法了解Subscribe的方法的数据来源。

## 12. [Android进程保活的套路](http://www.jianshu.com/p/1da4541b70ad) - [文中源码](https://github.com/herojing/KeepProcessLive)
答: 1,开启一个像素的Activity(手Q) 2,前台服务 3,相互唤醒 4,JobSheduler 5,粘性服务&与系统服务捆绑
[常被问的问题- Android 进程不死从3个层面入手](http://www.jianshu.com/p/89f19d67b348), [腾讯Bugly保活文章](http://mp.weixin.qq.com/s?__biz=MzA3NTYzODYzMg==&mid=2653577617&idx=1&sn=623256a2ff94641036a6c9eea17baab8&scene=0#wechat_redirect)

## 13. [ButterKnife工作流程](http://bxbxbai.github.io/2016/03/12/how-butterknife-works/?utm_source=tuicool&utm_medium=referral)
答:当你编译你的Android工程时，ButterKnife工程中 ButterKnifeProcessor 类的 process() 方法会执行以下操作：
- 开始它会扫描Java代码中所有的ButterKnife注解 @Bind 、 @OnClick 、 @OnItemClicked 等
- 当它发现一个类中含有任何一个注解时， ButterKnifeProcessor 会帮你生成一个Java类，名字类似 <className>$$ViewBinder ，这个新生成的类实现了 ViewBinder<T> 接口
- 这个 ViewBinder 类中包含了所有对应的代码，比如 @Bind 注解对应 findViewById() , @OnClick 对应了 view.setOnClickListener() 等等
- 最后当Activity启动 ButterKnife.bind(this) 执行时，ButterKnife会去加载对应的 ViewBinder 类调用它们的 bind() 方法

## 14. [RxJava & Retrofit结合的最佳实践- 封装的思想值得学习!!!](http://gank.io/post/56e80c2c677659311bed9841), [Retrofit](http://bxbxbai.github.io/2015/12/13/retrofit2/)
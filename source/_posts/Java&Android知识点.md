---
layout:  post
title:   Java&Android知识点
date: 2017-02-28 09:13:42
author:     "Bruce Yang"
catalog:    true
header-img: "vallehermoso_spain_from_google_earth.jpg"
tags: [Java, Android]
---
<center><font color=SkyBlue size="6px">**持续更行中**</font></center>

## 1. 解释内存中的栈（stack）、堆(heap)和静态存储区的用法。
答：通常我们定义一个基本数据类型的变量，一个对象的引用，还有就是函数调用的现场保存都使用内存中的栈空间；而通过new关键字和构造器创建的对象放在堆空间；程序中的字面量（literal）如直接书写的100、“hello”和常量都是放在静态存储区中。栈空间操作最快但是也很小，通常大量的对象都是放在堆空间，整个内存包括硬盘上的虚拟内存都可以被当成堆空间来使用。
`String str = new String(“hello”);`
上面的语句中 str 放在栈上，用 new 创建出来的字符串对象放在堆上，而“hello”这个字面量放在静态存储区。

## 2. [Android 中的Dalvik和ART是什么，有啥区别？](http://www.jianshu.com/p/58f817d176b7)
答: 在Dalvik下，应用每次运行的时候，字节码都需要通过即时编译器（just in time ，JIT）转换为机器码，这会拖慢应用的运行效率。在ART 环境中，应用在第一次安装的时候，字节码就会预先编译成机器码，使其成为真正的本地应用。这个过程叫做预编译（AOT,Ahead-Of-Time）。这样的话，应用的启动(首次)和执行都会变得更加快速。

## 3. Glide, Picasso原理?

## 4. 事件传递机制?(参考[郭霖事件分发博客](http://blog.csdn.net/guolin_blog/article/details/9097463/))

## 5. Okhttp原理,优点 

## 6. [内存泄漏全解析](http://mp.weixin.qq.com/s?__biz=MzA5MzI3NjE2MA==&mid=2650238704&idx=1&sn=ad334840afdc2d9bdb8215e9f942e54e&scene=0#wechat_redirect)

## 7. [热修复有所了解?](http://mp.weixin.qq.com/s/GuzbU1M1LY1VKmN7PyVbHQ)

## 8. 路由了解吗?[routerSDK](https://github.com/Jomes/routerSDK)
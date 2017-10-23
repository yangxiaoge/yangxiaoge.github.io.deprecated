---
title: 我眼中的 Android Framework
date: 2017-09-05 14:16:37
tags: [Android,Framework]
thumbnail: "https://dn-mhke0kuv.qbox.me/b06cc296588f99c3852e.jpg?imageView2/1/w/1200/h/700/q/85/interlace/1"
---

在开发中我们会遇到各种各样的非常奇怪的问题，有些问题是百思不得骑姐。其实这些问题大都是因为我们不了解安卓内部运行原理，知其所以然才是我们的目的。— `前言`
<!--more-->
> 本文转自 [墨镜猫](https://juejin.im/post/586da43b1b69e60062cb8a4f)，通俗有趣的文笔

<div align=center><img src="https://dn-mhke0kuv.qbox.me/b06cc296588f99c3852e.jpg?imageView2/1/w/1200/h/700/q/85/interlace/1"/></div>

任何控制类程序都有一个入口，安卓应用程序肯定也是有滴。
Android framework 包含三个小伙伴：服务端、客户端、linux 驱动。

### 服务端
服务端主要包含两个狠重要的类：WindowManagerService（WMS）和 ActivityManagerService（AMS）

### 客户端
客户端包含以下类：
- ActivityThread：是安卓应用程序的主线程类，这个小伙伴所在的线程就是 UI 线程或者称为主线程。
- Activity：ActivityThread 会根据用户的操作选择让哪个 Activity 对象上它的船。
- PhoneWindow：富二代，继承于牛气的 Window 类，自己屋里住着一个 DecorView 对象，像它老爸喜欢制定规则提供了一些通用窗口操作 API。
- Window：富一代，长得比较抽象，喜欢制定规则提供了一些通用的窗口操作 API。它不喜欢被人管所以呢，注意：WindowManagerService 管理的窗口不是 Window 类，其实是 View 和 ViewGroup。
- DecorView：很能干的家伙，家产来自 FrameLayout，比较注重外在喜欢打扮，DecorView 是对 FrameLayout 进行了一些修饰，从名字就可以看出来。
- ViewRoot：小管家继承于 Handler，主要作用是把 WMS 的 IPC 调用转换为本地的一个异步调用。
- W 类：ViewRoot 小助手，继承于 binder，是 ViewRoot 内部类。主要帮助 ViewRoot 实现把 WMS 的 IPC 调用转换为本地的一个异步调用。
- WindowManager：客户端如果想创建一个窗口得先告诉 WindowManager 一声，然后它再和 WindowManagerService 交流一下看看能不能创建，客户端不能直接和 WMS 交互。
 
### Linux 驱动
Linux 驱动和 Framework 相关的主要是两个部分：画家 SurfaceFlingger 和快递员 Binder。

每一个窗口都对应一个画 Surface，SF 主要是把各个 Surface 显示到同一屏幕上。Binder 是提供跨进程的消息传递。

### 从 apk 程序的运行过程去看看上面各个组件在啥时候干啥活的
ActivityThread 从 main() 函数中就开始动起来，然后调用 prepareMainLooper() 为 UI 线程创建一个消息快递通道即 MessageQueue。

接着创建 ActivityThread 对象，创建过程会创建一个消息装卸工 Handler 对象和一个快递员 Binder 对象，其中 Binder 负责接收远程 Ams 的 IPC 调用，接收到调用后让 Handler 把消息装到消息快递队列，UI 线程很忙的都是异步的从消息快递队列中取出消息并执行相应操作，比如 start、stop、pause。

然后 UI 线程让队列调用 Looper.loop() 方法进入消息循环体，进入后就会不断地从消息队列中读取并处理消息。

当 ActivityThread 接收到 Ams 发送 start 某个 Activity 的快递后就会创建指定的 Activity 对象。Activity 会先按窗户再去按玻璃和贴窗花，所以先创建 PhoneWindow->DecorView-> 创建相应的 View 或 ViewGroup。创建完成后就可以让大家欣赏了，调用 WindowManager 把界面显示到屏幕上，然后创建 ViewRoot，然后调用 Wms 提供的远程接口添加一个窗口并显示到屏幕上。

接下来就是用户的操作，事件线程不断的把消息快递发到事件队列中去，然后事件分发线程秘书逐个取出消息，然后调用 Wms 中的相应函数处理该消息。

***很多线程是不是很晕？***
1. 安卓程序中都有哪些线程？

客户端小伙伴至少包含三个线程小弟，Activity 启动后会创建一个 ViewRoot.W 对象，同时 ActivityThread 会创建一个 ApplicationThread 对象，这两个对象继承消息总管 Binder，每个 Binder 对应一个线程，负责接收 Linux Binder 驱动发送的 IPC 调用。还有一个是 UI 线程呗。

2. UI 线程是什么？

一直在倾听用户的心声，所有的处理用户消息，以及绘制页面的工作都在该线程中完成。

3. 自定义的线程和 UI 线程有什么区别？

UI 线程是从 ActivityThread 运行的，在该类的 main() 方法中已经使用了 Looper.prepareMainLooper() 为该线程添加了 Looper 对象，已经为该线程创建了消息队列，是自带秘书光环的。因此，我们才可以在 Activity 中去定义 Handler 对象，因为创建 Handler 对象时其线程必须已经创建了消息队列，装卸工得配运输带要不然没法干活。而普通的 Thread 则没有默认创建消息队列，所以不能直接在 Thread 中直接定义 Handler，这个就是我们不懂程序运行原理导致的困惑。
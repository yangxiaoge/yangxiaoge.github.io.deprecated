---
title: 《Android开发艺术探索》读书笔记 (1)
date: 2017-03-03 13:14:14
tags: [Android开发艺术探索,Android]
categories: Android开发艺术探索
thumbnail: https://yangxiaoge.coding.me/img/fir.im_1.png
catalog:    true #显示目录
---
<center><font color=SkyBlue size="6px">**重拾课本, 温故Android开发艺术探索!**</font></center>

本文是Android开发艺术读书笔记系列第一篇。内容结合书本/网络，自己概括而来。

##  第1章 Activity的生命周期和启动模式

### 1.1 Activity生命周期全面分析
#### 1.1.1 典型情况下生命周期分析
- 通常, `Activity`从`invisible`(即onStop)到`visible`(即onStart)时, `onRestart`方法就会被调用。
- 点击home键或者打开新`Activity`时, `onPause -> onStop`, 如果按Home键回来回掉是: `onRestart ->  onStart　->　onResume` ; 如果新`Activity`主题是透明的时, 只有`onPause`, 所以当用户返回`原来的Activity`时, 回掉过程是: `onRestart -> onStart -> onResume` (看[Activity生命周期图](/img/Activity金字塔型的生命周期图.png)就知道了)。
<!-- more -->
- 分析生命周期图, 可知`onStart`和`onStop`对应(可见到不可见性), `onPause`和`onResume`对应(是否位于前台)。

#### 1.1.2 异常生命周期分析
- 如果应用长时间处于`stopped`状态并且此时系统`内存极为紧张`的时候，系统就会回收Activity，此时系统在`回收之前`会回调`onSaveInstanceState`方法来保存应用的数据Bundle。当该Activity重新创建的时候，保存的Bundle数据就会传递到`onRestoreSaveInstanceState`方法和`onCreate`方法中，这就是onCreate方法中Bundle savedInstanceState参数的来源（onRestoreInstanceState的bundle参数也会传递到onCreate方法中，你也可以选择在onCreate方法中做数据还原）。详情可以参考[Android群英传_第八章 Activity和Activity调用栈分析](https://hujiaweibujidao.github.io/blog/2015/11/28/android-heroes-reading-notes-4/)
- 配置android:configChanges="xxx"属性, 防止`Activity`随着`orientation`,`local`,`keyboardHidden`发生变化时重新创建。

### 1.2 Activity的启动模式
应用内的Activity是被任务栈Task来管理的，一个Task中的Activity可以来自不同的应用，同一个应用的Activity也可能不在同一个Task中。默认情况下，任务栈依据栈的后进先出原则管理Activity，但是Activity可以设置一些“特权”打破默认的规则，主要是通过在AndroidManifest文件中的属性`android:launchMode`或者通过`Intent的flag`来设置。

`standard`：默认的启动模式，该模式下会生成一个新的Activity，同时将该Activity实例压入到栈中（不管该Activity是否已经存在在Task栈中，都是采用new操作）。例如： 栈中顺序是A B C D ，此时D通过Intent跳转到A，那么栈中结构就变成 A B C D A，点击返回按钮的 显示顺序是 D C B A，依次摧毁。

`singleTop`：在singleTop模式下，如果当前Activity D位于栈顶，此时通过Intent跳转到它本身的Activity（即D），那么不会重新创建一个新的D实例（走onNewIntent()），所以栈中的结构依旧为A B C D，如果跳转到B，那么由于B不处于栈顶，所以会新建一个B实例并压入到栈中，结构就变成了A B C D B。应用实例：三条推送，点进去都是一个activity。

`singleTask`：在singleTask模式下，Task栈中只能有一个对应Activity的实例。例如：现在栈的结构为A B C D，此时D通过Intent跳转到B（走onNewIntent()），则栈的结构变成了：A B。其中的C和D被栈弹出销毁了，也就是说位于B之上的实例都被销毁了。如果系统已经存在一个实例，系统就会将请求发送到这个实例上，但这个时候，系统就不会再调用通常情况下我们处理请求数据的onCreate方法，而是调用onNewIntent方法。通常应用于首页，首页肯定得在栈底部，也只能在栈底部。

`singleInstance`：singleInstance模式下会将打开的Activity压入一个新建的任务栈中。例如：Task栈1中结构为：A B C，C通过Intent跳转到了D（D的启动模式为singleInstance），那么则会新建一个Task 栈2，栈1中结构依旧为A B C，栈2中结构为D，此时屏幕中显示D，之后D通过Intent跳转到D，栈2中不会压入新的D，所以2个栈中的情况没发生改变。如果D跳转到了C，那么就会根据C对应的启动模式在栈1中进行对应的操作，C如果为standard，那么D跳转到C，栈1的结构为A B C C，此时点击返回按钮，还是在C，栈1的结构变为A B C，而不会回到D。

### 1.3 Intent Flag启动模式
- `Intent.FLAG_ACTIVITY_NEW_TASK`：使用一个新的task来启动Activity，一般用在service中启动Activity的场景，因为service中并不存在Activity栈。 
- `Intent.FLAG_ACTIVITY_SINGLE_TOP`：类似`andoid:launchMode="singleTop"` 
- `Intent.FLAG_ACTIVITY_CLEAR_TOP`：类似`andoid:launchMode="singleTask"`
- `Intent.FLAG_ACTIVITY_NO_HISTORY`：使用这种模式启动Activity，当该Activity启动其他Activity后，该Activity就消失了，不会保留在task栈中。例如A B，在B中以这种模式启动C，C再启动D，则当前的task栈变成A B D。
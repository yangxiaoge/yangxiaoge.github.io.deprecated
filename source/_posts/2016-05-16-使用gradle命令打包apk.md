---
title: 使用gradle命令打包apk
date: 2016-05-16 19:04:04
tags: [Gradle,Android,Android Studio]
categories: Android
catalog:    true #显示目录
---

# 前言

**系统环境：Windows7**

**Android Studio版本：2.1.1**

**Gradle版本：2.8**

**整个过程默认`翻墙`！**

本文参考了<!-- more -->[`Android Studio系列教程五–Gradle命令详解与导入第三方包`](http://stormzhang.com/devtools/2015/01/05/android-studio-tutorial5/)，[`gradle项目构建`](http://www.cnblogs.com/smyhvae/p/4456420.html)这两篇博客以及[`Gradle官网`](https://guides.codepath.com/android/Getting-Started-with-Gradle)上关于Gradle使用说明。

随着学习的深入，对Gradle的了解也多了些，今天我们就来聊聊如何用Gradle打测试包和正式包（debug与release）。Gradle官网上对Windows平台的Gradle也有描述。感觉学东西还是得多去官网上看看，毕竟上面都讲的非常详细。

# `下载Gradle与生成APK`

在Android Studio中的`Terminal`窗口下输入：`gradlew -v` 。来查看下项目所用的`Gradle版本`。
如果你是第一次执行会去下载Gradle 
![](http://i.imgur.com/0MMYnHj.png)
下载成功后会出现如下信息：
![](http://i.imgur.com/3yrVM2F.png)

接着输入：`gradlew clean`。 执行这个命令会去下载Gradle的一些依赖
![](http://i.imgur.com/Nb4nDvL.png)

最后执行：`gradlew build`。 这个命令会直接`编译`并`生成`相应的`apk文件`，如果看到如下字样就代表build成功了
![](http://i.imgur.com/wt3gYQC.png)

# APK签名

关于签名，有两种方法，`第一种`是在Android Studio`菜单栏`里中`build目录`下的`Generate signed APK`这种图形界面实现。`第二种`是直接在`gradle.build`里面通过代码实现;不过两种方法都差不多。在这里我只介绍一下第一种方法。

1. `先执行`：`gradlew clean` 命令，将APK文件`清除`。
2. `然后执行`：`radlew build` 命令，这个时候注意看Project目录下将出现如下图所示的测试版和未签名的正式版
![](http://i.imgur.com/3yzNOQF.png)


# 生成Keystore文件

点击Android Studio菜单栏上的build——>`Generate signed APK` 将出现下图所示的对话框。由于第一次使用还没有创建Keystore文件，所以需要创建一个。

![](http://i.imgur.com/bpYYeMz.png)

接下来出现如下的对话框，按要求填好信息后，点击OK（注意：`请牢记自己设置的密码，等会要用到`）
![](http://i.imgur.com/NhoVIBv.png)


接下来将`设置Keystore`的存放路径及命名文件名称，该文件后缀默认为jks。点击OK。
![](http://i.imgur.com/JPXx54o.png)


# 生成带签名的正式版APK

填写`之前`设置的`密码`，点击Next

![](http://i.imgur.com/7CURn7K.png)

选择`build Type`为`release`，点击finish

![](http://i.imgur.com/KQyRn0l.png)

接下来你将看到`Project目录`下多了一个带签名的正式版

![](http://i.imgur.com/BLiEWiN.png)

点击`Android Studio`中`右上角`的这个路径提示

![](http://i.imgur.com/LsjDyua.png)

*`大功告成！！`* `带签名的正式版以及测试版`都在这个文件夹里了。

# Gradle常用命令

更详细的请[Google](https://www.google.com/)下

`gradlew`代表 `gradle wrapper`，意思是`gradle的一层包装`，大家可以理解为在这个项目本地就封装了gradle，即gradle wrapper。下面列举了几个常见的命令：

`gradlew -v`：版本号

`gradlew clean`：把之前打包所产生的所有文件全部清除(注意：和第一次下载Gradle时候的命令相同，但作用不同)

`gradlew build`：检查依赖并编译打包(注意：和第一次下载Gradle时候的命令相同，但作用不同)

> 这里注意的是 `gradlew build`
> 命令把`debug`、`release`环境的包都打出来，如果正式发布`只需要`打Release的包，可以使用下面的这两个命令：

1. gradlew assembleDebug 编译并打`Debug包`
2. gradlew assembleRelease 编译并打`Release的包`
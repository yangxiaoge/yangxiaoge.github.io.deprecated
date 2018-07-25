---
title: 如何接入 VirtualAPK 插件框架
date: 2017-07-25 17:05:06
tags: [Android,插件化]
categories: Android
thumbnail: https://github.com/didi/VirtualAPK/raw/master/imgs/va.png
catalog:    true #显示目录
---

话不多说，先上我的 Demo 地址：https://github.com/yangxiaoge/VirtualAPKDemo

本文转载：原文链接https://blog.csdn.net/lovelixue/article/details/81141213

最近都在搞插件框架，为项目搭建用，之前集成了下阿里的 atlas，现在送上一篇滴滴的 virtualapk，就个人而言，滴滴的集成过程比阿里简单些，有兴趣的可以看看我 atlas 的：https://blog.csdn.net/lovelixue/article/details/81141213

*废话不多说，上过程*

### 1. 环境配置，很重要，官方有规定 gradle 使用哪个之类的，我用的不同，我就基于我的来写

1.1 新建一个工程，根目录的 build.gradle 里面

classpath 'com.android.tools.build:gradle:3.0.0'

classpath 'com.didi.virtualapk:gradle:0.9.8.4'



根目录 就配置这两个

1.2 在 app（宿主）目录下的 build.gradle 文件下添加

apply plugin: 'com.didi.virtualapk.host'
在 dependencies 里面添加

implementation 'com.didi.virtualapk:core:0.9.6'
1.3 重点来了，通过 file，new module 的形式新建一个 module，然后我命名为 plugindemo，然后在 nodule.gradle 里面添加

implementation 'com.didi.virtualapk:core:0.9.6'
接着在末端添加

apply plugin: 'com.didi.virtualapk.plugin'
virtualApk {
    // 插件资源表中的packageId，需要确保不同插件有不同的packageId.
    packageId = 0x6f             // The package id of Resources.
    // 宿主工程application模块的路径，插件的构建需要依赖这个路径
    targetHost='../app' // The path of application module in host project.
    //默认为true，如果插件有引用宿主的类，那么这个选项可以使得插件和宿主保持混淆一致
    applyHostMapping = true      // [Optional] Default value is true.
}
截图
![](https://img-blog.csdn.net/20180725103642552?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xvdmVsaXh1ZQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

基本 环境就到此为止了，接下来代码部分

### 2. 代码添加并验证

在 app 的 mainactivity 里面添加两个按钮，一个是跳转到 module 去的，一个是加载插件的

public void loadPlugin() {
    PluginManager pluginManager = PluginManager.getInstance(this);
    //此处是当查看插件apk是否存在,如果存在就去加载(比如修改线上的bug,把插件apk下载到sdcard的根目录下取名为plugin-release.apk)
    File apk = new File(Environment.getExternalStorageDirectory(), "plugin-release.apk");
    if (apk.exists()) {
        try {
            pluginManager.loadPlugin(apk);
            Toast.makeText(this, "插件加载成功", Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this, "插件加载异常！", Toast.LENGTH_SHORT).show();
        }
    }
}
截图
![](https://img-blog.csdn.net/20180725104101299?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xvdmVsaXh1ZQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)


这个时候跳转是不行的，接下来就需要加载插件了 ，首先需要生成插件 apk

官方文档是通过命令

gradle clean assemblePlugin来构建插件

如果不想这样，也可以通过直接 gradle 的来，具体如下
![](https://img-blog.csdn.net/20180725104350857?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xvdmVsaXh1ZQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)


这样 就生成插件 apk 了，同时官方文档介绍了下这个，就是只能生成 release 版本的，插件包位于 build 目录下
![](https://img-blog.csdn.net/20180725104530319?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2xvdmVsaXh1ZQ==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)


到这里 就可以结束验证了，点击加载插件，然后再点击跳转，你会发现可以跳转了，如果如果有帮助可以帮我点个赞或者 githup 上面 star 一下，谢谢，如果有问题，可以下面评论回复，一起学习探讨。下面贴上注意点

1. 集成环境一定要配置好

2. 生成的插件包和加载的时候名字一定要一样

3. 注意 SD 卡的权限

贴上相关参考文档和我的 githup 代码

https://github.com/didi/VirtualAPK

https://github.com/didi/VirtualAPK/wiki/VirtualAPK-%E6%9E%84%E5%BB%BA%E5%99%A8-API-%E6%A6%82%E8%A7%88

githup：https://github.com/sdgSnow/VirtualAPK

希望对大家有帮助。
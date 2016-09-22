---
title: bughd让bug无处遁形
date: 2016-08-17 09:21:05
tags: Android
categories: BugHD
---

[BugHD](http://bughd.com/product/android) 帮助 `Android开发`, 崩溃分析 & 检测更新& 开放 API。

*如何在app中配置？* [*详见官方文档*](http://bughd.com/doc/android)
>[MumuXi](https://github.com/yangxiaoge/MumuXi)app中已经配置好了,可以供参考

集成到app中分为如下几步:

## General Key
    General Key 用来唯一标识您的应用，为防止别人滥用，请勿泄露，建立每个项目时将自动生成项目对应的 General Key，可在项目列表页查看每个项目对应的 General Key值
<!-- more -->   
## 导入SDK -->其一方法: 通过 `Gradle` 自动构建
    

    在项目的 build.gradle（Top-level build file，项目最外层的 build.gradle 文件）中添加这个 maven repositories，例如：
 
```
buildscript {

  repositories {
    jcenter()
  }

  dependencies {
    classpath 'com.android.tools.build:gradle:1.0.0'
  }
}

allprojects {
  repositories {
    jcenter()

    maven {
      url "http://maven.bughd.com/public"
    }
  }
}
```

    在要集成的项目中的 build.gradle 中添加依赖，如下：

    
```
dependencies {
  compile 'im.fir:fir-sdk:latest.integration@aar'
}
```

## 配置

```
<manifest……>
  <!-- 必选 -->
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"></uses-permission>
  <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"></uses-permission>
  <uses-permission android:name="android.permission.INTERNET"></uses-permission>
  <uses-permission android:name="android.permission.READ_PHONE_STATE"></uses-permission>

  <!-- 可选 -->
  <uses-permission android:name="android.permission.GET_TASKS"></uses-permission>

  <application ……>
    <activity ……/>
    <meta-data android:value="你的GENERAL_KEY" android:name="BUG_HD_SDK_GENERAL_KEY" />
  </application>
</manifest>
```

## 调用SDK
    
    继承 Application，并在 onCreate() 方法中的第一行加入 FIR.init(this) 
```
public class MyApplication extends Application {

    @Override
    public void onCreate() {

        super.onCreate();
        FIR.init(this);
    }
}
```
    修改 AndroidManifest.xml，在其中加入 android:name="xxxx"，使用继承过的的 application 类,例如
```
<application
    android:name=".MyApplication"
    android:allowBackup="true"
    android:icon="@drawable/ic_launcher"
    android:label="@string/app_name"
    android:theme="@style/AppTheme" >
    ....
</application>
```

**如上配置归纳,就是3步**
![如上配置归纳,就是3步](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1f6whn2lru1j20sy0blabf.jpg)
**最后看下分析界面**
![bughd应用崩溃分析界面](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1f6wgxou5muj211n0ktwie.jpg)

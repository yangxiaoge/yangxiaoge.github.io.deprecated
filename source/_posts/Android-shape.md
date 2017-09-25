---
title: Android shape
date: 2016-06-20 11:25:51
tags: Android
categories: Android
---

使用`shape`可以`自定义形状`，可以定义下面`四种类型`的形状，通过`android:shape` `属性`指定：
1. `rectangle`: `矩形`，`默认的形状`，可以画出直角矩形、圆角矩形、弧形等
2. `oval`: `椭圆形`，用得比较多的是画正圆
3. `line`: `线形`，可以画实线和虚线
4. `ring`: `环形`，可以画环形进度条
<!-- more -->
`gradient`代表渐变，可以按照如下的使用：

```
<gradient
       android:angle="0"
       android:centerColor="#ff0f00"
       android:endColor="#ff00ff"
       android:startColor="#00ff00" />

```

`solid`代表实心，可以按照如下的使用：
```
<solid android:color="#F0FFFF" />
```
`solid`代表描边，可以按照如下的使用：
```
<stroke
       android:width="10dp"
       android:color="#00FFFF"
       android:dashGap="5dp"
       android:dashWidth="5dp" />
```

`corners`代表圆角，可以按照如下的使用：
```
<corners android:radius="5dp" />
```

看下完整的shape(drawable/...xml)文件:
```
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle"  四种类型 >
    
    <!-- 渐变 -->
    <gradient
        android:angle="0"
        android:centerColor="#ff0f00"
        android:endColor="#ff00ff"
        android:startColor="#00ff00" />

    <!-- 实心 -->
    <solid android:color="#F0FFFF" />

    <!-- 描边 -->
    <stroke
        android:width="10dp"
        android:color="#00FFFF"
        android:dashGap="5dp"
        android:dashWidth="5dp" />

    <!-- 圆角 -->
    <corners android:radius="100dp" />
</shape>
```
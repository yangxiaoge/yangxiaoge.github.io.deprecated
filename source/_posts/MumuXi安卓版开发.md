---
title: MumuXi安卓版开发
date: 2015-05-23 11:37:37
tags: [Android,Gank]
categories: APP开发记
---

`这也是自己第一个算是正式的练手App项目`

`目的:` 督促自己不断积累知识经验。
下面进入正文

# 准备工作
* Android Studio
* [Gank Api](http://gank.io/) ([gank.io/api](http://gank.io/api) 由 [代码家](https://github.com/daimajia)维护的开源Api)
* N多依赖jar包
* 学习[CaMnter/EasyGank](https://github.com/CaMnter/EasyGank)完成的项目

# 开发准备
* 框架搭建
* 界面原型设计
* 主要功能
<!-- more -->
# 完成功能:
- 知乎专栏-作者文章-文章detail
- 妹子福利
- about_me-换头像
- about_app-app开发目的,以及使用的框架
- for_what-是目标功能(有的还没实现)
- 所有的[loading动画](https://github.com/zzz40500/android-shapeLoadingView)用的是开源框架- 布局放在了EasyRecyclerView的 [layout_empty](https://github.com/yangxiaoge/MumuXi/blob/master/app/src/main/res/layout/fragment_zhuanlan_layout.xml) ,layout_progress,error中,具体根据实际来放
- 上拉,下拉刷新用的开源框架[EasyRecyclerView](https://github.com/Jude95/EasyRecyclerView)
-侧滑Drawer功能还没加,后面考虑加些其他功能~~~

>项目详细 注解 以及功能在[github](https://github.com/yangxiaoge/MumuXi)提交的[message](https://github.com/yangxiaoge/MumuXi)和代码注解中

>经过一个星期的折腾,终于完成了第一个版本,并且试着上架了应用商城! O(∩_∩)O~~

## 下载
<a href="http://fir.im/sq2t" target="_blank" alt="Fir"><img src="http://ww4.sinaimg.cn/mw1024/c05ae6b6gw1f802wvh1s2j203301cq2q.jpg"/></a>

<a href="http://android.myapp.com/myapp/detail.htm?apkName=com.yang.bruce.mumuxi" target="_blank" alt="应用宝"><img src="http://ww4.sinaimg.cn/mw1024/c05ae6b6gw1f5pv5t3kwwj203w01jglf.jpg"/></a>

<a href="http://www.wandoujia.com/apps/com.yang.bruce.mumuxi" target="_blank" alt="豌豆荚"><img src="http://ww1.sinaimg.cn/mw690/c05ae6b6gw1f5iyz0qbdgj204k01mglg.jpg"/></a>


**add google analytics谷歌分析** ( 2016-9-5 11:58:26 )

1. `google-services.json`[文件下载](https://developers.google.com/mobile/add?platform=android&cntapi=analytics&cnturl=https:%2F%2Fdevelopers.google.com%2Fanalytics%2Fdevguides%2Fcollection%2Fandroid%2Fv4%2Fapp%3Fconfigured%3Dtrue&cntlbl=Continue%20Adding%20Analytics)
2. 官方集成文档: https://developers.google.com/analytics/devguides/collection/android/v4/app?configured=true
3. 分析用户使用情况的平台: https://analytics.google.com/analytics/web/#realtime/rt-app-overview/a83624565w124744507p129062318/
4. ![google 分析](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1f7iknnth8nj217y0lx43d.jpg)

说明下: 2016-9-28 14:08:13

>http://dev.xiaomi.com/doc/p=62/index.html

Google为APK定义了两个属性：`VersionCode`和`VersionName`，他们有不同的用途。
VersionCode：对消费者不可见，仅用于应用市场、程序内部识别版本，判断新旧等用途。
VersionName：展示给消费者，消费者会通过它认知自己安装的版本，下文提到的版本号都是说VersionName。
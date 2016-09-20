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

>项目详细 注解 以及功能在[github](https://github.com/yangxiaoge)提交的[message](https://github.com/yangxiaoge/MumuXi)和代码注解中

>经过一个星期的折腾,终于完成了第一个版本,并且试着上架了应用商城! O(∩_∩)O~~

## 下载
[Fir](http://fir.im/sq2t)

<a href="http://android.myapp.com/myapp/detail.htm?apkName=com.yang.bruce.mumuxi" target="_blank" alt="应用宝"><img src="http://ww4.sinaimg.cn/mw1024/c05ae6b6gw1f5pv5t3kwwj203w01jglf.jpg"/></a>

<a href="http://www.wandoujia.com/apps/com.yang.bruce.mumuxi" target="_blank" alt="豌豆荚"><img src="http://ww1.sinaimg.cn/mw690/c05ae6b6gw1f5iyz0qbdgj204k01mglg.jpg"/></a>


`add google analytics` 2016-9-5 11:58:26
![google 分析](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1f7iknnth8nj217y0lx43d.jpg)
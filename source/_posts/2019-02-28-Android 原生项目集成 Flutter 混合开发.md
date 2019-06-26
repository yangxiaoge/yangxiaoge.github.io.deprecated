---
title: Android 原生项目集成 Flutter 混合开发
date: 2019-2-28 09:09:06
tags: Flutter
categories: Flutter
thumbnail: https://user-gold-cdn.xitu.io/2018/7/6/1646e3e56cca9663?imageView2/1/w/1304/h/734/q/85/format/webp/interlace/1
---

## 背景
本来最近对 Flutter 的热衷程度日益增长，也使用 Flutter 开发了应用 [MuMuxi-Flutter](https://github.com/yangxiaoge/wanandroid_flutter) 版本，
但是现在想要把 Flutter 使用在现有的项目中，改如何操作呢？哈哈，Google 官方已经考虑到了这个问题，并且给出了集成方案 [Add-Flutter-to-existing-apps](https://github.com/flutter/flutter/wiki/Add-Flutter-to-existing-apps)。

## 步骤
1. 新建一个 `Flutter module`，使用命令：`flutter create -t module {moduleName}`，其中 `moduleName` 我这里取名 `xinhua_media_flutter_module`
2. 随后将 `Flutter module` 推送至`git` 仓库，git 推送我就不累赘了，拿到仓库地址 https://gitee.com/xxx/xinhua_media_flutter_module.git
3. 在`原生` Android 项目更目录添加 `git submodule`
```
git submodule add {Flutter module 仓库地址}, 即上面拿到的仓库地址 https://gitee.com/xxx/xinhua_media_flutter_module.git
git submodule update
```
此时项目结构如下图：
![原生集成flutter工程目录结构.png](https://github.com/yangxiaoge/PersonResources/blob/master/flutter/%E5%8E%9F%E7%94%9F%E9%9B%86%E6%88%90flutter%E5%B7%A5%E7%A8%8B%E7%9B%AE%E5%BD%95%E7%BB%93%E6%9E%84.png?raw=true)
4. 在原生项目`根目录` `settings.gradle` 中 `include ':app'` 下面添加如下配置
```
setBinding(new Binding([gradle: this]))
evaluate(new File(
        'xinhua_media_flutter_module/.android/include_flutter.groovy'
))
```
5. 原生项目 `app` 目录下的 `build.gradle` 文件中添加 `xinhua_media_flutter_module` 库的依赖
```
// MyApp/app/build.gradle
implementation project(':flutter')
```
6. 在原生项目中新建一个 `FlutterActivity` 用来加载 Flutter mudule 页面入口
```
@Override
protected void onCreate(@Nullable Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	// "flutter_page" 是路由名称，在 Flutter `main.dart` 页面中需要用到
	FlutterView seuicSettingPage = Flutter.createView(this, getLifecycle(), "flutter_page");
	FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT);
	// 加 flutterview 添加到布局中
	addContentView(seuicSettingPage, layoutParams);
}
```
7. 在 `xinhua_media_flutter_module` lib 下的 `main.dart` 文件中添加逻辑
```
> xinhua_media_flutter_module/lib/main.dart
以下 "flutter_page" 判断路由名称，MyApp 是自定义的组件，接下来就可以开发自己的功能逻辑。
如果发现 AS 不识别 Dart 语言，设置中勾选 `Enable Dart support`
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'flutter_page':
      return MyApp();
    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}
```
8. 然后`运行` Android 原生项目，

如果混合项目想要使用 flutter `hot start/reload`，需要 cd 进入 `xinhua_media_flutter_module` 目录，然后执行 `flutter attach`，
然后打开 flutter 的页面就能正常使用 Hot restart/reload 啦，好了 Android 集成 flutter 到此结束，iOS 集成可以看 Google 官方教程。
9. emmmmm，Flutter 真香😀😆😉😎😘🤩 

## 结语
`Flutter` 作为 Google 的亲儿子，它还是「Google 下一代操作系统」`Fuchsia OS` 的内置 UI SDK ！2019 年将是 Flutter 的爆发期，[Github](https://github.com/search?q=flutter) 上已经有很多
国人开发的相关插件以及项目了，接下来我也会写一些跟自己 Flutter 项目相关的技术文章！加油！📚

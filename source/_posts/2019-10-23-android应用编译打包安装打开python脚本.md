---
title: Android应用编译打包安装打开python脚本
date: 2019-10-23 09:44:04
tags: Python
categories: Android
---

作为一位 `Android` 开发者，你是否还在为编译打包一系列流程而耗费心力呢，为了让解放双手减少手动操作的流程，我写了一个 `Python` 脚本（Python3+）。

> 脚本带啊如下：如有问题可与我联系。

```
#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os

# 需要python3.0以上版本

# （必填）项目根目录
file_dir = r'D:\workspace\Android\seuic\mdm'
# （必填）应用release apk路径
release_apk_path = r'D:\workspace\Android\seuic\mdm\app\build\outputs\apk\common\release\app-release.apk'
# 系统签名后的apk路径，同release_apk_path路径一致，改个名字。
signed_apk_path = release_apk_path.replace('app-release.apk','signed_release.apk')
#signed_apk_path = r'D:\workspace\Android\seuic\mdm\app\build\outputs\apk\common\release\signed_release.apk'


# 进入项目目录
os.chdir(file_dir)
# 打包
print('--------gradlew assembleRelease--------')
os.system('gradlew assembleRelease')

# 安装apk
print('--------install apk--------')
os.system('adb install -r '+ signed_apk_path)

# 启动应用
print('--------open app-----------')
# adb shell monkey -p com.seuic.mobiledevicemanager 1
os.system('adb shell am start -n com.seuic.mobiledevicemanager/com.seuic.mobiledevicemanager.main.activity.ActiveActivity')
```

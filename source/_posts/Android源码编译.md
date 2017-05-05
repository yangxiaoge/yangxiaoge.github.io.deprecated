---
title: Android源码编译
date: 2017-05-04 11:40:24
tags: 源码
categories: Android源码
---

进入项目根目录 （begoit@BegoitPC:~/begoit/AOSP-6.0.1_r17/out/target/product/bullhead$）
- `source build/envsetup.sh`
- `lunch` (我的项目中选了 79)
- `make -j8`（第一次编译耗时 2 小时，机器性能好的可以 j32 等等）
- 模块编译，节约时间(比方说我修改了 frameworks/base 下的某个文件直接编译这个模块就行)
  - `mmm frameworks/base`
  - `make snod` （这个不要忘！）

刷机
- [刷机工具下载](https://share.weiyun.com/aef417d93a44dce31802087732ac4d8b)
![4个刷机工具](/img/刷机工具.png)
- 安装工具
- 打开 SP_Flash_Tool_exe_Windows_v5.1644.00.000\flash_tool.exe
![flash_tool](/img/flash_tool.png)
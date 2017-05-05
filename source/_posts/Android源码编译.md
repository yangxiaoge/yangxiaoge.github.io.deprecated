---
title: Android源码编译
date: 2017-05-04 11:40:24
tags: 源码
categories: Android源码
thumbnail: /img/mountain-bg.jpg
---

进入项目根目录 （begoit@BegoitPC:~/begoit/AOSP-6.0.1_r17/）
- `source build/envsetup.sh`
- `lunch` (我的项目中选了 79)
- `make -j8`（第一次编译耗时 2 小时，机器性能好的可以 j32 等等）
- 模块编译，节约时间(比方说我修改了 frameworks/base 下的某个文件直接编译这个模块就行)
  - `mmm frameworks/base`
  - `make snod` （这个不要忘！）

刷机
- [刷机工具下载](https://share.weiyun.com/aef417d93a44dce31802087732ac4d8b)
![4个刷机工具](/img/刷机工具.png)
- 安装下载的工具
- 打开 SP_Flash_Tool_exe_Windows_v5.1644.00.000\flash_tool.exe
![flash_tool](/img/flash_tool.png)

刷机开始
-  `MTK 刷机`（KONKAS6 代码）使用 `Smart Phone Flash Tool` 工具： 注意KONKA手机关机即可，首先选中 `Scatter-loading File` 这行的 `choose` ，然后`右击计算机`选择`映射网络驱动器`输入 `\\192.168.20.220\share`（这个是 `ubuntu` 共享的文件夹），然后进入对于源码目录找到 `KONKAS6\alps\out\target\product\kon6753_66c_s6_m0\MT6753_Android_scatter.txt`
- `原生 AOSP` 用 Nexus 刷机（AOSP-6.0.1_r17 代码）：注意手机关机进入 `fastboot` 界面，进入编译生成的目录下 `begoit@BegoitPC:~/begoit/AOSP-6.0.1_r17/out/target/product/bullhead$`，然后依次刷入如下命令：
  - `sudo fastboot flash system system.img`
  - `sudo fastboot flash recovery recovery.img`
  - `sudo fastboot flash vendor vendor.img`
  - `sudo fastboot flash cache cache.img`
  - `sudo fastboot flash userdata userdata.img`
  - `sudo fastboot reboot` 最后一步，重启手机。
- 刷机录像：注意，gif最后点击 `download` 之后再用 usb 连接关机的 KONKA 手机
![MTK刷机录制](/img/MTK刷机录制.gif)

`Attention`： /home/begoit/temp/KONKAS6/alps/packages/apps/Provision/src/com/android/provision/DefaultActivity.java (注释onCreate中的部分代码，略去登录注册等功能)
**未完待续。。。**

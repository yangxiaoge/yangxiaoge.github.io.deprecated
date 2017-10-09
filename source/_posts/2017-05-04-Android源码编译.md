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
 > Android 编译命令 [make -j8 -k 2>&1 | tee build.log](http://www.cnblogs.com/ifzy/p/3854560.html) 解释: 其中 make 是编译命令，-j8 这里的 8 指的是线程数量，就是开启几个线程去编译这个工程，一般会是 CPU 核心数的 2 倍, 开多的话电脑会卡死。-k 2 是标准错误，&1 是标准输出，2>&1 意思就是将标准错误输出到标准输出中。如果没有 2>&1，只会有标准输出，没有错误；tee 的作用同时输出到控制台和文件，make > build.log  是将所有标准输出到这个文件中，并没有定义标准错误应该是定义到了标准输出，也就是说如果 make 执行出现错误，那么就不会写到 build.log 中，而是输出到屏幕上，2>&1 是错误和结果都重定向到 build.log 中！可以到根目录看到 build.log。
- 模块编译，节约时间(比方说我修改了 frameworks/base 下的某个文件直接编译这个模块就行)
  - `mmm frameworks/base` （单独编译某个模块）
  - `make snod` （重新打包 Android 系统镜像文件 system.img， 这个不要忘！）
> 编译源码等指令可以看老罗的 [Android 系统源代码情景分析教程](http://0xcc0xcd.com/p/books/978-7-121-18108-5/c161.php)

刷机
- [刷机工具下载](https://share.weiyun.com/aef417d93a44dce31802087732ac4d8b)
![4个刷机工具](/img/刷机工具.png)
- 安装下载的工具
- 打开 SP_Flash_Tool_exe_Windows_v5.1644.00.000\flash_tool.exe
![flash_tool](/img/flash_tool.png)

刷机开始
-  `MTK 刷机`（KONKAS6 代码）使用 `Smart Phone Flash Tool` 工具： 注意 KONKA 手机关机即可，首先选中 `Scatter-loading File` 这行的 `choose` ，然后`右击计算机`选择`映射网络驱动器`输入 `\\192.168.20.220\share`（这个是 `ubuntu` 共享的文件夹），然后进入对于源码目录找到 `KONKAS6\alps\out\target\product\kon6753_66c_s6_m0\MT6753_Android_scatter.txt`
- `原生 AOSP` 用 Nexus 刷机（AOSP-6.0.1_r17 代码）：注意手机关机进入 `fastboot` 界面，进入编译生成的目录下 `begoit@BegoitPC:~/begoit/AOSP-6.0.1_r17/out/target/product/bullhead$`，然后依次刷入如下命令：
  - sudo fastboot flash system system.img
  - sudo fastboot flash recovery recovery.img
  - sudo fastboot flash vendor vendor.img
  - sudo fastboot flash cache cache.img
  - sudo fastboot flash userdata userdata.img
  - sudo fastboot reboot 最后一步，重启手机。
- 刷机录像：注意，gif 最后点击 `download` 之后再用 usb 连接关机的 KONKA 手机
![MTK刷机录制](/img/MTK刷机录制.gif)

`Attention`： /home/begoit/temp/KONKAS6/alps/packages/apps/Provision/src/com/android/provision/DefaultActivity.java (注释 onCreate 中的部分代码，略去登录注册等功能)

**打 Patch 包**（将 A 项目的提交打 Patch 导入到 B 项目中） `2017-9-18 18:14:57` add
1. `git format-patch -1`（-1 指最近一次 Git 提交） - A 项目根目录，生成 Patch 包
2. 将生成的 `0001-.patch` 拷贝到 B 项目根目录下
3. `git am 0001-.patch` - B 项目根目录打入 Patch 包

**源码代码提示的命令** `2017-6-13 15:46:06` add
运行 `source build/envsetup.sh`
`mmm development/tools/idegen/`
`sh ./development/tools/idegen/idegen.sh` （三行全选运行），会在项目的更目录下会生成 `android.ipr`，用 `andorid studio` 打开这个文件，源码代码就有提示了!

**内置 apk** `2017-6-27 11:08:49` add
- KONKAS6/alps/device/konka/kon6753_66c_s6_m0/begoit 路径下将需要的 apk(TopActivity.apk) 安装包放进来
- 在上述路径下 Android.mk 文件中将 apk 信息加进来（这个模仿其他的内置apk）
- KONKAS6/alps/device/konka/kon6753_66c_s6_m0/full_kon6753_66c_s6_m0.mk 文件中增加 `TopActivity \`
- 如果 apk 中有 so 库那么需要加别的东西，目前没有用到，可自行 google
- 以上操作完成之后需要重新编译项目

**加快编译速度** `2017-6-30 17:46:53` add
`prebuilts/misc/linux-x86/ccache/ccache -M 50G` 设置 cache 缓存为 50 G

如下是编译的录屏, 临时弄个 `枪火` 先占坑，视频抽空录制（视频太大暂不录制）。
以下是哔哩哔哩的 html5 播放视频，参考文章：http://login926.github.io/2016/12/24/Bilibilihtml5Player/ 
<iframe src="https://www.bilibili.com/html/html5player.html?cid=5465980&aid=3444552" width="640" height="480" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>


<!--宽占满，高度自适应。 poster 预加载显示的图像-->
<!--<video width="100%" height="auto" id="video" controls="" preload="none" 
      poster="http://media.w3.org/2010/05/sintel/poster.png">
      <source id="mp4" src="http://cn-fjxm2-dx-v-03.acgvideo.com/vg1/f/84/5465980-1.mp4?expires=1494488400&platform=html5&ssig=sFyLhO5klFhNKadv0P9gtA&oi=1968780062&nfa=fkYkF/LEe5xFyJPq/bZ9eQ==&dynamic=1&hfa=2066162576" type="video/mp4">
      <source id="webm" src="http://media.w3.org/2010/05/sintel/trailer.webm" type="video/webm">
      <source id="ogv" src="http://media.w3.org/2010/05/sintel/trailer.ogv" type="video/ogg">
</video>-->

**未完待续。。。**

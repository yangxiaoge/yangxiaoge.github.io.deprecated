---
title: Birt多选参数设置
date: 2015-09-06 15:38:39
tags: Birt
categories: Birt
catalog:    true #显示目录
---

> 网上相关的资料少之又少,某度搜的博客更是不能信(互相抄)!
> 不扯了,直接看多选参数设置

`效果图: `
![设计器运行效果图](http://ww2.sinaimg.cn/mw690/c05ae6b6gw1f3lpm7o96nj20fh0cdq47.jpg)

`具体实现步骤`:

<!-- more -->

## 1. 勾选 `Allow Multiple Values` 并设置默认值 ![](http://ww3.sinaimg.cn/mw690/c05ae6b6gw1f3lpm89ag6j20qy0n7n5x.jpg)
## 2. 脚本中注意要判断取值( `toString()` 之后)![](http://ww4.sinaimg.cn/mw690/c05ae6b6gw1f3lpm98wkqj213p0j112h.jpg) 

更多Birt报表知识点详见个人笔记: `有道云笔记`
[Birt总结文档](http://t.cn/RqRpUtV11)
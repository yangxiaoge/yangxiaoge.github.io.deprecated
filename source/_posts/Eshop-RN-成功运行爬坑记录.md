---
title: Eshop-RN 成功运行爬坑记录
date: 2017-02-09 15:21:42
tags: [React Native]
catalog:   true #显示目录
---
## 先上图片
![终端及代码图](/img/Eshop成功运行.png)
![Nexus 5X真机图](/img/eshop-nexus5X截图.png)

## 问题总结(持续更新ing)

- `npm install` 要保证网络畅通
- [`node`](https://nodejs.org/en/)版本尽量用官方[推荐版本](https://nodejs.org/en/), 或者低版本(之前由于我用了v7.4.0版本,导致运行报错等各种奇葩问题。 降级到v6.9.5之后就解决了)
- Git拉去新工程之后最好先删除`node_modules`,再运行`npm install`
- more
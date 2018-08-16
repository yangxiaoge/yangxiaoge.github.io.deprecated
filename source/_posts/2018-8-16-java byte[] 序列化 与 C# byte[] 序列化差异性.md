---
title: java 字节数组 序列化 与 C# 字节数组 序列化差异性
date: 2018-08-16 19:40:05
tags: [byte，C#]
---

原文链接： https://blog.csdn.net/nn991926/article/details/81747136

最近项目遇到一个大坑（接口文档竟然说要传 byte[]，其实应该传 string，还好我要要了一个 C# 代码，差点被坑！！！），需要上传一个 byte[] 数组给后台。 java byte[] 序列化之后还是 byte[], 然而 C# 则变成了 Base64（NO_WRAP）字符串；



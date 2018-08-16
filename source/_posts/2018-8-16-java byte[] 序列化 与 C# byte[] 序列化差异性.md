---
title: java byte[] 序列化 与 C# byte[] 序列化差异性
date: 2018-08-16 19:40:05
tags: [byte，C#]
---

最近项目遇到一个大坑（接口文档竟然说要传 byte[]，其实应该传 string，还好我要要了一个 C# 代码，差点被坑！！！），需要上传一个 byte[] 数组给后台。 java byte[] 序列化之后还是 byte[], 然而 C# 则变成了 Base64（NO_WRAP）字符串；

因此： java 这边需要手动将 byte[] 转成 Base64 字符串: 
Base64.encodeToString(bytes, Base64.NO_WRAP); 

java 我用的是 Gson 序列化， 客户的 .NET 代码用的是 JsonConvert.SerializeObject(obj)。

这里写图片描述

这里写图片描述

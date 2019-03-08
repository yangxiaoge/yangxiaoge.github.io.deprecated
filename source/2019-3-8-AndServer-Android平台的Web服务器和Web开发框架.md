---
title: AndServer - Android平台的Web服务器和Web开发框架
date: 2019-3-8 12:25:15
tags: AndServer
categories: Android
---
# AndServer

Android平台的Web服务器和Web开发框架。[AndServer](https://github.com/yanzhenjie/AndServer)像SpringMVC一样提供了注解方式，不同的是[AndServer](https://github.com/yanzhenjie/AndServer)基于编译时注解，如果你使用过SpringMVC，那么你将很快的掌握它。

>本文转载：https://github.com/yanzhenjie/AndServer/blob/master/README-CN.md

* 静态网站部署
* 动态Http Api部署

```java
@RestController
@RequestMapping(path = "/user")
public class UserController {

    @PostMapping("/login")
    public String login(@RequestParam("account") String account, 
        @RequestParam("password") String password) {
        if (...) {
            return "Successful.";
        }
        return "Failed.";
    }

    @GetMapping(path = "/info/{userId}")
    public User detail(@PathVariable("userId") String userId) {
        User user = findUserById(userId);
        ...

        return user;
    }
}
```

上面的代码将会生成下面的两个Http Api：
```text
POST http://.../user/login
GET http://.../user/info/uid_001
```

文档和更多的附加信息请看[网站](https://www.yanzhenjie.com/AndServer)。

## 下载
```groovy
dependencies {
    implementation 'com.yanzhenjie.andserver:api:2.0.4'
    annotationProcessor 'com.yanzhenjie.andserver:processor:2.0.4'
}
```

如果你正在使用Kotlin，请使用`kapt`代替`annotationProcessor`。

[AndServer](https://github.com/yanzhenjie/AndServer)最低支持Android 2.3(Api level 9)。
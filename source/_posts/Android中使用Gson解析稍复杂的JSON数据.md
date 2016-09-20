---
title: Android中使用Gson解析稍复杂的JSON数据
date: 2016-05-05 19:23:35
tags: [Json,Android]
categories: Android
---
![](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1f3lr401paxj20sg0c677k.jpg)

> 摘抄自 http://www.jianshu.com/p/3b8ef7162e69

# 一、Json简介
JSON官网(中文版)：http://www.json.org/json-zh.html

**JSON(JavaScript Object Notation)**是一种轻量级(轻量级？简单、易操作、快捷)的数据交换格式。主要目的就是给出一套通用的数据格式，大家按照这种格式定义自己的数据，方便数据的交换。特点是(相对来说) **易于人阅读和编写，易于机器解析和生成** 。
<!-- more -->
**Rules**：
>* “名/值”对的集合（A collection of name/value pairs）。不同的语言中，它被理解为**对象（object）**，纪录（record），结构（struct），字典（dictionary），哈希表（hash table），有键列表（keyed list），或者关联数组 （associative array）。
* 值的有序列表（An ordered list of values）。在大部分语言中，它被理解为**数组（array）**。


**JSON可以有以下格式**：
>1.对象是一个无序的“ ‘名称/值’ 对”集合。一个对象以“{”（左括号）开始，“}”（右括号）结束。每个“名称”后跟一个“:”（冒号）；“‘名称/值’ 对”之间使用“,”（逗号）分隔。

![object的  名称 /值  结构](http://ww3.sinaimg.cn/mw690/c05ae6b6jw1f3lle35bv5g20gm035a9w.gif)
>2.数组是值（value）的有序集合。一个数组以“[”（左中括号）开始，“]”（右中括号）结束。值之间使用“,”（逗号）分隔。

 ![“值的类型”可以是哪些数据类型](http://ww4.sinaimg.cn/mw690/c05ae6b6jw1f3llhba2xug20gm07qgli.gif)
 
*以上是最基本的json知识，想深入了解的，请移步[官网](http://www.json.org/json-zh.html)。*

下面举个栗子给大家尝尝：
```
{
    "type": "forecast1d",
    "weatherinfo": [
        {
            "city": "北京",
            "cityid": "1",
            "temp1": "22℃",
            "temp2": "10℃",
            "weather": "晴",
            "ptime": "11:00"
        },
        {
            "city": "上海",
            "cityid": "2",
            "temp1": "24℃",
            "temp2": "12℃",
            "weather": "晴",
            "ptime": "11:00"
        }
    ]
}
```

**栗子好难看，上截图(截图太小看不清...戳这里[看大图](http://ww3.sinaimg.cn/mw1024/c05ae6b6jw1f3xesqananj20vp0em75s.jpg))：**

 ![一个简单的JSON串](http://ww3.sinaimg.cn/mw1024/c05ae6b6jw1f3xesqananj20vp0em75s.jpg)
 
**NOTE**：左侧为JSON字符串，右侧为解析结构，方便查看。
**福利**：截图是我在一个在线[JSON Editor](http://jsoneditoronline.org/index.html)上截的，体验一下-->JSON Editor，很好用推荐给大家。

# 二、使用Gson在Android中解析Json
认清了JSON，就要解析它。

**你可以使用的JSON库**：

>**JSONObject**(源自Android官方)、
**Gson**(源自Google)、
**Jackson**(第三方开源库)、
**FastJSON**(第三方开源库)、
等。。。

本篇文章使用Gson解析JSON，Gson地址：http://code.google.com/p/google-gson/

![google-gson ](http://ww4.sinaimg.cn/mw690/c05ae6b6jw1f3llhcc3saj20bw024glq.jpg)
无法下载？百度云分享一下[http://pan.baidu.com/s/1kTur5xd](http://pan.baidu.com/s/1kTur5xd),提取密码:5oae

根据JSON串的结构定义一个类(这里我们把这个类叫Result)，我们直接把得到的JSON串解析成这个类。class Result定义如下：
```
import java.util.List;

public class Result {

    public String type;

    public List<Info> weatherinfo;

    public static class Info {

        public String city;

        public String cityid;

        public String temp1;

        public String temp2;

        public String weather;

        public String ptime;

    }

}

```
![class Result](http://ww1.sinaimg.cn/mw690/c05ae6b6jw1f3llhdgw1cj208u0afmyd.jpg)

定义好了待解析成的class之后，接下来使用Gson解析JSON串就可以了：
>Gson gson = new Gson();
Result r = gson.fromJson(jsonData, Result.class);

# `So easy!`

## *难点*：
`如果是Android Studio开发的,用GsonFormat插件可以自动生成JavaBean`
1. 如何定义这个待解析成的类？其实很简单，看到JSON结构里面有{ }你就定义一个类，看到[ ]你就定义一个List即可，最后只剩下最简单的如String、int等基本类型直接定义就好。
2. 内部嵌套的类，请使用public static class className { }。
3. 类内部的属性名，必须与JSON串里面的Key名称保持一致。这三点请自行对照我们上面举的Result的栗子，都有对应。


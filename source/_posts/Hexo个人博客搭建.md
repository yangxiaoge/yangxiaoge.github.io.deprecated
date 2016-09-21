---
title: Hexo个人博客搭建
date: 2015-04-12 10:39:08
tags: [Hexo,个人博客]
categories: Hexo
---

**前言**
一直想要一个自己的独立博客，今天偶然发现[Hexo](https://hexo.io/)这个优秀的`静态博客框架`，于是乎，便开始着手搭建个人博客。当然要搭配现在流行的`gitHub`(国内的`coding`也是相当不错的)，简直是完美写博客的黄金搭档（免费+方便），毕竟咱就是体验下而已，并不需要去买域名(当然,`阿里云`有的域名很便宜,我买了个第一年4元的,续费就也就几十块,不需要就用`github`默认域名就OK)！搭建过程也是磕磕碰碰，主要参考如下！供需要的小伙伴借鉴！

> 主要参考如下两个博客:
>[嘟嘟独立博客](http://tengj.top/2016/02/22/hexo%E5%B9%B2%E8%B4%A7%E7%B3%BB%E5%88%97%EF%BC%9A%EF%BC%88%E4%B8%80%EF%BC%89hexo+gitHub%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E7%8B%AC%E7%AB%8B%E5%8D%9A%E5%AE%A2/)
>[CrazyMilk](http://crazymilk.github.io/2015/12/28/GitHub-Pages-Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2/)
<!-- more -->


[Next](https://github.com/iissnan/hexo-theme-next)主题相关配置: [详见官方文档](http://theme-next.iissnan.com/):http://theme-next.iissnan.com/

`主要的配置项`:

1. `打赏`
![打赏.png](http://7fv9bd.com1.z0.glb.clouddn.com/%E6%89%93%E8%B5%8F.png?attname=&e=1466582042&token=1JBeQi3vz7kUmQlsAf00FRntxudo01dbWsLMQT30:8jHYgu4CYgIJHukq6ZVNzCQsHP8)
2. `文章阅读数`
3. `代码高亮`↓↓↓
![code_highlight.png](http://ww3.sinaimg.cn/mw1024/c05ae6b6gw1f52wlho0c3j20lw03h0ts.jpg)
4. `添加多说评论`
5. `导航图标`↓↓↓
![Font Awesome.png](http://ww4.sinaimg.cn/mw1024/c05ae6b6gw1f52wlgzqvhj20fx01jq2w.jpg)
6. `评论头像旋转`-->[设置方法](http://prozhuchen.github.io/2015/10/01/Hexo%E5%8D%9A%E5%AE%A2%E7%AC%AC%E4%B8%89%E7%AB%99/)
7. 添加`Fork me on Github` ribbon[详见](http://www.cnblogs.com/zhcncn/p/4097881.html) ↓↓↓
![QQ截图20160621153752.png](http://naxiexiaojiyi1.qiniudn.com/QQ截图20160621153752.png?e=1466498312&token=1JBeQi3vz7kUmQlsAf00FRntxudo01dbWsLMQT30:gQUGqur7xBAj4Yq80nD3KjrKe98=)
8. `站点访问量`
[不蒜子](http://service.ibruce.info/) : 只需两行代码就可以完成
9. `置顶功能`,跟小伙伴[LittleFish](http://littlefisher.coding.me)学习的
请戳[👉](http://littlefisher.coding.me/2016/07/12/Hexo%E7%BD%AE%E9%A1%B6%E5%8A%9F%E8%83%BD%E5%AE%9E%E7%8E%B0/)
10. `文本、图片`居中
  <blockquote class="blockquote-center">参考: http://theme-next.iissnan.com/tag-plugins.html</blockquote>

![](http://theme-next.iissnan.com/uploads/tags/full-image.jpg)
11. 如何关闭新建页面的评论功能？
```
title: All tags
date: 2015-12-16 17:05:24
type: "tags"
comments: false
---
```
12. 添加背景以及点击爱心效果(2016-9-21 11:47:32)
http://michaelxiang.me/2015/11/30/hexo-next-optimize/
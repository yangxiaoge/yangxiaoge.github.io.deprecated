---
title: Hexo个人博客搭建
date: 2015-04-12 10:39:08
tags: [Hexo]
categories: Hexo
---
![](http://ww1.sinaimg.cn/mw1024/c05ae6b6gw1f813o9fsiuj20zk0fawgp.jpg)
**前言**
一直想要一个自己的独立博客，今天偶然发现[Hexo](https://hexo.io/)这个优秀的`静态博客框架`，于是乎，便开始着手搭建个人博客。当然要搭配现在流行的`gitHub`(国内的`coding`也是相当不错的)，简直是完美写博客的黄金搭档（免费+方便），毕竟咱就是体验下而已，并不需要去买域名(当然,`阿里云`有的域名很便宜,我买了个第一年4元的,续费就也就几十块,不需要就用`github`默认域名就OK)！搭建过程也是磕磕碰碰，主要参考如下！供需要的小伙伴借鉴！

> 主要参考如下两个博客:
>[嘟嘟独立博客](http://tengj.top/2016/02/22/hexo%E5%B9%B2%E8%B4%A7%E7%B3%BB%E5%88%97%EF%BC%9A%EF%BC%88%E4%B8%80%EF%BC%89hexo+gitHub%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E7%8B%AC%E7%AB%8B%E5%8D%9A%E5%AE%A2/)
>[CrazyMilk](http://crazymilk.github.io/2015/12/28/GitHub-Pages-Hexo%E6%90%AD%E5%BB%BA%E5%8D%9A%E5%AE%A2/)
<!-- more -->


[Next](https://github.com/iissnan/hexo-theme-next)主题相关配置: [详见官方文档](http://theme-next.iissnan.com/):http://theme-next.iissnan.com/

`主要的配置项`:
14. `hexo提交搜索引擎（百度+谷歌）`(百度,谷歌就能搜索到个人网站)
>参考: http://tengj.top/2016/03/14/hexo6seo/

http://yangxiaoge.coding.me/sitemap.xml
http://yangxiaoge.coding.me/baidusitemap.xml
13. `如何新增导航Menu?`

	- `hexo new page "link"`  (创建一个link目录,并且默认生成index.md)
	- 主题配置文件`_config.xml`中 `menu节点`下增加 `link: /link`,`menu_icons节点(FontAwesome头像)`增加 `link: chain`
	- `\themes\next\languages`目录下语言配置文件`zh-Hans.yml`中 `menu节点`增加 `link: 链接`

11. `如何关闭新建页面的评论功能？`
```
---
title: "About"
layout: "page"
comments: false
---
```
12. `添加背景以及点击爱心效果`(2016-9-21 11:47:32)
http://michaelxiang.me/2015/11/30/hexo-next-optimize/
*注意:* 目前只有将主题下`_config.xml`配置文件中的`Schemes`设置成`Pisces` (如果设置成Mist,那么手机端的背景动画会布满屏幕,实在太难看~~~)
1. `打赏`
2. `文章阅读数`
使用的是[leancloud](https://leancloud.cn/data.html?appid=vwQnaBdLYT7Is3AWzRoGBABe-gzGzoHsz#/Counter)(leancloud很强大,可以作为后端云供等app调用)
3. `代码高亮`↓↓↓
![code_highlight.png](http://ww3.sinaimg.cn/mw1024/c05ae6b6gw1f52wlho0c3j20lw03h0ts.jpg)
4. `添加多说评论`
5. `导航图标`↓↓↓
![Font Awesome.png](http://ww4.sinaimg.cn/mw1024/c05ae6b6gw1f52wlgzqvhj20fx01jq2w.jpg)
6. `评论头像旋转`-->[设置方法](http://prozhuchen.github.io/2015/10/01/Hexo%E5%8D%9A%E5%AE%A2%E7%AC%AC%E4%B8%89%E7%AB%99/)
7. 添加`Fork me on Github` ribbon[详见](http://www.cnblogs.com/zhcncn/p/4097881.html)
8. `站点访问量`
[不蒜子](http://service.ibruce.info/) : 只需两行代码就可以完成
9. `置顶功能`,跟小伙伴[LittleFish](http://littlefisher.coding.me)学习的
请戳[👉](http://littlefisher.coding.me/2016/07/12/Hexo%E7%BD%AE%E9%A1%B6%E5%8A%9F%E8%83%BD%E5%AE%9E%E7%8E%B0/)
10. `文本、图片`居中
  <blockquote class="blockquote-center">参考: http://theme-next.iissnan.com/tag-plugins.html</blockquote>

![](http://theme-next.iissnan.com/uploads/tags/full-image.jpg)

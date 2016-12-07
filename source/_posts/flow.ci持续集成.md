---
title: flow.ci持续集成
date: 2016-12-07 14:19:05
tags: [持续集成,Hexo]
---
好久没有写博客了o(╯□╰)o , 终于忙完Android项目了。接下来给你自己定个目标， 每个月至少写一篇博文，可以是感想闲聊篇也可是技术篇， 哈哈看心情啦。
# 言归正传
其实获得[FlowCi](http://dashboard.flow.ci/)测试资格已经好几个月了， 一直没有去使用它， [FlowCi](http://dashboard.flow.ci/)功能非常强大。 之前我用的是[daocloud](https://dashboard.daocloud.io/build-flows/c8e37fcc-8c38-4a7c-b0e8-c464f2ea3c92)持续集成博客, 不过今天发现持续集成失败了， 发现是[daocloud](https://dashboard.daocloud.io/build-flows/c8e37fcc-8c38-4a7c-b0e8-c464f2ea3c92)升级了， 集成的配置文件需要修改， 我就乘此机会转投[FlowCi](http://dashboard.flow.ci/)的怀抱中了 O(∩_∩)O哈哈~
那么 怎么使用 FlowCi 为 Hexo博客持续集成呢？
## 创建项目
![create project](http://ww3.sinaimg.cn/mw1024/c05ae6b6gw1fai7qzz2unj216v0edgmw.jpg)

## 选择代码仓库
 这里取决于hexo博客源文件存放在哪里了 github, coding等...
![select the code repository](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1fai7ue4f1vj217c0ei0tv.jpg)

## 创建新的工作流
 之前有简单的步骤就省略了...
 
 ![Workflow select](http://ww3.sinaimg.cn/mw1024/c05ae6b6gw1fai89o501cj216z0kj76h.jpg)
 
 工作流选择, `Nodejs`(Hexo编译所需环境)，版本选择了最新的`v6.6.0`, 当然还有其他的, `Python`, `Android`, `Php`等。
 后面我会尝试使用`Android持续集成`，也写相应文章。
 
## 触发器(什么时候自动集成)
 设置 触发器-push-正则匹配-master, 意思就是当 hexo博客git的master源文件改变时, 就会触发FlowCi的持续集成!
 
## 自定义脚本
```
# 安装Hexo命令行工具
flow_cmd "npm install hexo-cli -g" --echo

# 准备并安装私钥
flow_cmd "cp .daocloud/id_rsa ." --echo  
flow_cmd "chmod 600 ./id_rsa" --echo  
flow_cmd "eval $(ssh-agent)" --echo  
flow_cmd "ssh-add ./id_rsa" --echo

# 执行Hexo生成和发布

flow_cmd "hexo clean" --echo  
flow_cmd "hexo g" --echo  
flow_cmd "hexo d" --echo
```

![custom script](http://ww1.sinaimg.cn/mw1024/c05ae6b6gw1fai8ir2iphj217j0kv77e.jpg)
 
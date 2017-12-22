---
title: Nice git log
date: 2017-12-13 10:11:01
tags: Git
thumbnail: https://i.loli.net/2017/12/14/5a31e32602b21.png
---
Git 是一个强大的版本管理器，自从用上 git 后，腰不酸腿不疼了。

开发中查看提交记录是家常便饭了，`git log` 命令是查看全部提交日志，`git log -2`  查看最近 2 次的提交日志，`git log -p`  查看历史纪录以来哪几行被修改，`git log --stat --summary` 查看每个版本变动的档案和行数。

Git 默认的 git log 是这样子的，emmmmmm..... 丑
<div align=center><img src="https://i.loli.net/2017/12/14/5a31e2fcca990.png"/></div>


于是乎 Google 了一个 git 配置，打开终端，输入以下命令。
```
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"  
```
以后在终端输入 git lg，就能看到下面漂亮的 git log 了。
<div align=center><img src="https://i.loli.net/2017/12/14/5a31e32602b21.png"/></div>
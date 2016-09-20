---
title: Git使用
date: 2015-06-24 13:12:52
tags: Git
categories: Git
---
## git回滚到指定版本方法(2016-01-08 14:55:44)
```
 git reset --hard <commit ID号>
 例如: git reset --hard dc972ec
 
 版本号查看方法: 打开github项目，点击commits就能看到提交记录以及版本号
```
<!-- more -->

## 提交本地项目(未受控)到远程Git仓库
```
git init
git add .
git commit -m "first commit"
git remote add origin https://git.coding.net/yangxiaoge/Gank.git
git push -u origin master
```

`git add .`: add后面有空格




---
title: Git语法
date: 2016-08-03 16:13:45
tags: Git
categories: Git
---
>本文摘自我的小伙伴[KevinJin](http://littlefisher.coding.me/2016/06/08/git/)

开源中国的 [Pro Git（中文版）](http://git.oschina.net/progit/index.html)

#####    1、Git基础
######    1.1 分布式版本管理系统
__常用操作:__

* 克隆远程仓库  
`git clone </path/to/repository>`

* 查看工作区状态  
`git status`


<!-- more -->
* 添加更改到暂存区  
`git add <filename>`&nbsp;&nbsp;添加某个文件  
`git add .`&nbsp;&nbsp;添加当前目录及子目录所有文件  
`git add -A`    &nbsp;&nbsp;添加所有改动

* 使用如下命令以实际提交改动  
`git commit -m "代码提交信息"`

* 分支操作  
`git branch <branch name>`&nbsp;&nbsp;新建分支  
`git checkout <branch name>`&nbsp;&nbsp;切换到某个分支
`git branch -d <branch name>`&nbsp;&nbsp;删除分支

* 要合并其他分支（可以是任何远程分支或本地分支）到你的当前分支，执行：  
`git merge <branch>`&nbsp;&nbsp;//git merge dev  
`git merge origin/dev`

* 获取远程仓库改动  
`git fetch <remote>`&nbsp;&nbsp;//git fetch origin

* 获取远程仓库改动，同时合并（merge）到当前分支  
`git pull <remote> <branch>`&nbsp;&nbsp;//git pull origin dev&nbsp;&nbsp;获取远程仓库origin的dev分支，合并到当前分支

* 推送当前分支到远程仓库  
`git push <remote> <branch>`&nbsp;&nbsp;//git push origin dev&nbsp;&nbsp;推送当前分支到远程仓库origin的dev分支  
![GIT CHEAT SHEET](http://ww4.sinaimg.cn/mw690/7dde05d2gw1f4nwpid97qj20j80r6n75.jpg)

######    1.2 Git初始化，创建一个新的本地仓库
安装git后，配置自己的个人信息  
`git config --global user.name "KevinJin614"`
`git config --global user.email "***@qq.com"`  
创建新文件夹，打开，然后执行  
`git init git add`
`git commit`
以创建新的 git 仓库

######    1.3 Git暂存区
你的本地仓库由 git 维护的三棵“树”组成。第一个是你的__工作目录__，它持有实际文件；第二个是__暂存区（Index）__,它像个缓存区域，临时保存你的改动；最后是 __HEAD__，它指向你最后一次提交的结果。  
HEAD和分支都是引用。  
![Git暂存区](http://ww1.sinaimg.cn/mw690/7dde05d2gw1f4nwpjgxwqj20g607975m.jpg)  
使用`git status [-s]` 查看工作区状态，添加-s参数以精简模式显示

* 当执行git reset HEAD命令时，暂存区的目录树会被重写，被master分支指向的目录树所替换，但是工作区不受影响。

* 当执行`git rm --cached <file>`命令时，会直接从暂存区删除文件，工作区则不做出改变。 
* 当执行`git checkout `.或者`git checkout -- <file>`命令时，会用暂存区全部或指定的文件替换工作区的文件。这个操作很危险，会清除工作区中未添加到暂存区的改动。 
* 当执行`git checkout HEAD .`或者`git checkout HEAD <file>`命令时，会用HEAD指向的master分支中的全部或者部分文件替换暂存区和以及工作区中的文件。这个命令也是极具危险性的，因为不但会清除工作区中未提交的改动，也会清除暂存区中未提交的改动。  

######    1.4 git diff  
![Git Diff](http://ww3.sinaimg.cn/mw690/7dde05d2gw1f4nwpk1epjj20e50723zk.jpg)  

* 工作区和暂存区比较  
`git diff [--] [<path>…]`  
* 暂存区和某次提交（如HEAD）比较  
`git diff --cached [<commit>] [--] [<path>…]`
* 工作区和某次提交（如HEAD）比较  
`git diff [<commit>] [--] [<path>…]`
* 比较任意两次commit之间的改动  
`git diff <commit> <commit> [--] [<path>]`

__所有的diff都可以用difftool替代__

######    1.5 git reset重置暂存区
![Git Reset](http://ww4.sinaimg.cn/mw690/7dde05d2gw1f4nwple3j5j20gg079gmu.jpg)  
`git reset`  
`git reset --hard HEAD^`

重置命令（git reset）是Git最常用的命令之一，也是最危险，最容易误用的命令。来看看git reset命令的用法。  
用法一：`git reset [-q] [<commit>] [--] <paths>...`  
用法二：`git reset [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]`
 
上面列出了两个用法，其中 <commit> 都是可选项，可以使用引用或者提交ID，如果省略 <commit> 则相当于使用了HEAD的指向作为提交ID。  
上面列出的两种用法的区别在于，第一种用法在命令中包含路径<paths>。为了避免路径和引用（或者提交ID）同名而冲突，可以在<paths>前用两个连续的短线（减号）作为分隔。  
* 第一种用法（包含了路径<paths>的用法）不会重置引用，更不会改变工作区，而是用指定提交状态（<commit>）下的文件（<paths>）替换掉暂存区中的文件。例如命令git reset HEAD <paths>相当于取消之前执行的git add <paths>命令时改变的暂存区。  
* 第二种用法（不使用路径<paths>的用法）则会重置引用。根据不同的选项，可以对暂存区或者工作区进行重置。参照下面的版本库模型图，来看一看不同的参数对第二种重置语法的影响。  
* 
命令格式: `git reset [--soft | --mixed | --hard ] [<commit>]`  
* 使用参数--hard，如：`git reset --hard <commit>`  
会执行上图中的1、2、3全部的三个动作。即：  
1. 替换引用的指向。引用指向新的提交ID。  
2. 替换暂存区。替换后，暂存区的内容和引用指向的目录树一致。  
3. 替换工作区。替换后，工作区的内容变得和暂存区一致，也和HEAD所指向的目录树内容相同。  

* 使用参数--soft，如:`git reset --soft <commit>`  
会执行上图中的操作1。即只更改引用的指向，不改变暂存区和工作区。  
* 使用参数--mixed或者不使用参数（缺省即为--mixed），如:`git reset <commit>`  
会执行上图中的操作1和操作2。即更改引用的指向以及重置暂存区，但是不改变工作区。下面通过一些示例，看一下重置命令的不同用法。  
* 命令：`git reset`  
仅用HEAD指向的目录树重置暂存区，工作区不会受到影响，相当于将之前用git add命令更新到暂存区的内容撤出暂存区。引用也未改变，因为引用重置到HEAD相当于没有重置。
* 命令：`git reset HEAD`  
同上。  
* 命令：`git reset -- filename`  
仅将文件filename撤出暂存区，暂存区中其他文件不改变。相当于对命令git add filename的反向操作。 
* 命令：`git reset HEAD filename`  
同上。  
* 命令：`git reset --soft HEAD^`  
工作区和暂存区不改变，但是引用向前回退一次。当对最新提交的提交说明或者提交的更改不满意时，撤销最新的提交以便重新提交。 
在之前曾经介绍过一个修补提交命令`git commit --amend`，用于对最新的提交进行重新提交以修补错误的提交说明或者错误的提交文件。修补提交命令实际上相当于执行了下面两条命令。（注：文件.git/COMMIT_EDITMSG保存了上次的提交日志）  
`$ git reset --soft HEAD^`  
`$ git commit -e -F .git/COMMIT_EDITMSG`  

* 命令：`git reset HEAD^`  
工作区不改变，但是暂存区会回退到上一次提交之前，引用也会回退一次。  
* 命令：`git reset --mixed HEAD^`  
同上。  
* 命令：`git reset --hard HEAD^`  
彻底撤销最近的提交。引用回退到前一次，而且工作区和暂存区都会回退到上一次提交的状态。自上一次以来的提交全部丢失。  

######    1.6 git checkout检出到工作区
![git checkout](http://ww2.sinaimg.cn/mw690/7dde05d2gw1f4nwpmikdzj20e5080dgv.jpg)

检出命令（git checkout）是Git最常用的命令之一，同样也很危险，因为这条命令会重写工作区。  
用法一： `git checkout [-q] [<commit>] [--] <paths>...`  
用法二： `git checkout [<branch>]`  
用法三： `git checkout [-m] [[-b|--orphan] <new_branch>] [<start_point>]`  

上面列出的第一种用法和第二种用法的区别在于，第一种用法在命令中包含路径`<paths>`。为了避免路径和引用（或者提交ID）同名而冲突，可以在`<paths>`前用两个连续的短线（减号）作为分隔。  
>
* 第一种用法的`<commit>`是可选项，如果省略则相当于从暂存区（index）进行检出。这和上一章的重置命令大不相同：重置的默认值是HEAD，而检出的默认值是暂存区。因此__重置一般用于重置暂存区__（除非使用--hard参数，否则不重置工作区），而__检出命令主要是覆盖工作区__（如果`<commit>`不省略，也会替换暂存区中相应的文件）。  
* 第一种用法（包含了路径`<paths>`的用法）不会改变HEAD头指针，主要是用于指定版本的文件覆盖工作区中对应的文件。如果省略`<commit>`，会拿暂存区的文件覆盖工作区的文件，否则用指定提交中的文件覆盖暂存区和工作区中对应的文件。  
* 第二种用法（不使用路径`<paths>`的用法）则会改变HEAD头指针。之所以后面的参数写作`<branch>`，是因为只有HEAD切换到一个分支才可以对提交进行跟踪，否则仍然会进入“分离头指针”的状态。在“分离头指针”状态下的提交不能被引用关联到而可能会丢失。所以用法二最主要的作用就是切换到分支。如果省略`<branch>`则相当于对工作区进行状态检查。 
* 第三种用法主要是创建和切换到新的分支（`<new_branch>`），新的分支从`<start_point>`指定的提交开始创建。新分支和我们熟悉的master分支没有什么实质的不同，都是在refs/heads命名空间下的引用。关于分支和`git checkout`命令的这个用法会在后面的章节做具体的介绍。 

######    1.7 文件忽略
`.gitignore ` 

文件`.gitignore`的作用范围是其所处的目录及其子目录  
忽略只对未跟踪文件有效，对于已加入版本库的文件无效  

Git的忽略文件的语法规则：   

* 忽略文件中的空行或者以井号（#）开始的行被忽略。  
* 可以使用通配符，参见Linux手册：glob(7)。例如：星号（*）代表任意多字符，问号（?）代表一个字符，方括号（[abc]）代表可选字符范围等。  
* 如果名称的最前面是一个路径分隔符（/），表明要忽略的文件在此目录下，而非子目录的文件。  
* 如果名称的最后面是一个路径分隔符（/），表明要忽略的是整个目录，同名文件不忽略，否则同名的文件和目录都忽略。  
* 通过在名称的最前面添加一个感叹号（!），代表不忽略。

下面的文件忽略示例，包含了上述要点：  
\# 这是注释行 —— 被忽略  
\*.a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# 忽略所有以.a 为扩展名的文件。  
\!lib.a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# 但是 lib.a 文件或者目录不要忽略，即使前面设置了对 *.a 的忽略。  
/TODO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# 只忽略根目录下的 TODO 文件，子目录的 TODO 文件不忽略。  
build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# 忽略所有 build/ 目录下的文件。 
doc/*.txt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# 忽略文件如 doc/notes.txt，但是文件如 doc/server/arch.txt 不被忽略。  

######    1.8 分支管理
`git branch` 查看分支  
`git branch -r` 查看远程分支  
`git branch <branch name>`创建分支  

创建一个叫做“feature_x”的分支，并切换过去：   
`git checkout -b feature_x`  
切换回主分支：  
`git checkout master`  
再把新建的分支删掉：  
`git branch -d feature_x`


#####    2、远程版本库
 * 克隆远程仓库  
 `git clone <url>`  
* 添加远程仓库  
`git remote add <name> <url>`   
* 删除远程仓库  
`git remote remove <name>`  
`git fetch [remote]`  
`git pull [remote [refspec]]`= `git fetch` +  `git merge`   
`git push [remote] [branch]`   
* 快进式推送 `git push`
* 强制非快进式推送 `git push -f`


__Tracking__  

* 从远程分支创建新分支，会直接添加对应的tracking  
`git checkout -b test origin/master`  
* 手动为分支添加tracking  
`git branch --set-upstream master origin/next`  

__git merge__   

`git merge <branch>[--no-ff ]`  

* Fast forward &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;git允许执行快进式合并，添加--no-ff参数强制不使用快


#####    3、最佳实践
* 保持Working directory clean  
* 长期分支  
由于 Git 使用简单的三方合并，所以就算在较长一段时间内，反复多次把某个分支合并到另一分支，也不是什么难事。也就是说，你可以同时拥有多个开放的分 支，每个分支用于完成特定的任务，随着开发的推进，你可以随时把某个特性分支的成果并到其他分支中。  
许多使用 Git 的开发者都喜欢用这种方式来开展工作，比如仅在 master 分支中保留完全稳定的代码，即已经发布或即将发布的代码。与此同时，他们还有一个名 为 develop 或 next 的平行分支，专门用于后续的开发，或仅用于稳定性测试 — 当然并不是说一定要绝对稳定，不过一旦进入某种稳定状态，便可以把它合并到 master 里。这样，在确保这些已完成的特性分支（短期分支）能够通过所有测试，并且不会引入更多错误之后，就可以并到主干分支中，等待下一次的发布。  
本质上我们刚才谈论的，是随着提交对象不断右移的指针。稳定分支的指针总是在提交历史中落后一大截，而前沿分支总是比较靠前。
![](http://ww2.sinaimg.cn/mw690/7dde05d2gw1f4o337i90bj20d402j3yf.jpg)
* 特性分支  
特性分支从develop分支分出，最终必须合并回develop。  
特性分支（也叫主题分支）用于开发新特性。每个新特性开一个新分支，最终会合并回develop（当特性开发完毕的时候），或者放弃（如果最终决定不开发这 个特性）。  
特性分支只存在于开发者的仓库中。   
在任何规模的项目中都可以使用特性（Topic）分支。一个特性分支是指一个短期的，用来实现单一特性或与其相关工作的分支。可能你在以前的版本控制系统 里从未做过类似这样的事情，因为通常创建与合并分支消耗太大。然而在 Git 中，一天之内建立、使用、合并再删除多个分支是常见的事。  
我们可以创建特性分支，在提交了若干更新后，把它们合并到主干分支，然后删除。该技术允许你迅速且完全的进行语境切换 — 因为你的工作分散在不同的分 支里，每个分支里的改变都和它的目标特性相关，浏览代码之类的事情因而变得更简单了。你可以把作出的改变保持在特性分支中几分钟，几天甚至几个月，等 它们成熟以后再合并，而不用在乎它们建立的顺序或者进度。  
现在我们来看一个实际的例子。请看图，由下往上，起先我们在 master 工作到 C1，然后开始一个新分支 iss91 尝试修复 91 号缺陷，提交到 C6 的时候，又冒 出一个解决该问题的新办法，于是从之前 C4 的地方又分出一个分支 iss91v2，干到 C8 的时候，又回到主干 master 中提交了 C9 和 C10，再回到 iss91v2 继续 工作，提交 C11，接着，又冒出个不太确定的想法，从 master 的最新提交 C10 处开了个新的分支 dumbidea 做些试验。    
![](http://ww4.sinaimg.cn/mw690/7dde05d2gw1f4o335f4fcj20bp0c8wen.jpg)  
现在，假定两件事情：我们最终决定使用第二个解决方案，即 iss91v2 中的办法；另外，我们把 dumbidea 分支拿给同事们看了以后，发现它竟然是个天才之 作。所以接下来，我们准备抛弃原来的 iss91 分支（实际上会丢弃 C5 和 C6），直接在主干中并入另外两个分支。最终的提交历史将变成这样：  
![](http://ww1.sinaimg.cn/mw690/7dde05d2gw1f4o3360pojj209f0dzglq.jpg)  
请务必牢记这些分支全部都是本地分支，这一点很重要。当你在使用分支及合并的时候，一切都是在你自己的Git仓库中进行的—完全不涉及与服务器的交互。

* 提交做小  
* git保存用户名、密码   
1.在Windows中添加一个HOME环境变量，值为%USERPROFILE%，如下图：
![](http://ww4.sinaimg.cn/mw690/7dde05d2gw1f4o336oe3gj20as0603yn.jpg)  
2.在“开始>运行”中打开%Home%，新建一个名为“_netrc”的文件。  
3.用记事本打开\_netrc文件，输入Git服务器名、用户名、密码，并保存。示例如下  
`machine github.com`  
`login 用户名`  
`password 密码`
* 配置git mergetool和git difftool  
__通过git config命令__  
配置difftool:   
`git config --global diff.tool bc`  
`git config --global difftool.bc.cmd "\"c:/program files/beyond compare 3/bcomp.exe\" \"\$LOCAL\" \"\$REMOTE\""`  
`git config --global difftool.prompt false`  
配置mergetool:  
`git config --global merge.tool bc`  
`git config --global mergetool.bc.cmd "\"c:/program files/beyond compare 3/bcomp.exe\" \"\$LOCAL\" \"\$REMOTE\" \"\$BASE\" \"\$MERGED\""`  
`git config --global mergetool.bc.trustExitCode true`  
不生成备份文件  
`git config --global mergetool.keepBackup false`  
__直接修改%USERPROFILE%\.gitconfig文件，完整文件如下：__  
`[user]`  
&nbsp;&nbsp;&nbsp;&nbsp;`name = 用户名`   
&nbsp;&nbsp;&nbsp;&nbsp;`email = 邮箱`  
`[diff]`  
&nbsp;&nbsp;&nbsp;&nbsp;`tool = bc`  
`[difftool "bc"]`  
&nbsp;&nbsp;&nbsp;&nbsp;`cmd = \"C:/bc4/BCompare.exe\" \"$LOCAL\" \"$REMOTE\" `  
`[difftool]`  
&nbsp;&nbsp;&nbsp;&nbsp;`prompt = false `  
`[merge]`  
&nbsp;&nbsp;&nbsp;&nbsp;`tool = bc `  
`[mergetool "bc"]`  
&nbsp;&nbsp;&nbsp;&nbsp;`cmd = \"C:/bc4/BCompare.exe\" \"$LOCAL\" \"$REMOTE\" \"$BASE\" \"$MERGED\" `  
&nbsp;&nbsp;&nbsp;&nbsp;`trustExitCode = true`  
`[mergetool]`  
&nbsp;&nbsp;&nbsp;&nbsp;`keepBackup = false`  

#####    4、其他特性
* git rebase  
* git stash  
* detached head 分离的头指针  
* git reflog  
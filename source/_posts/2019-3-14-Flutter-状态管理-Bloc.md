---
title: Flutter 状态管理 - BLoC
date: 2019-3-14 09:20:49
tags: Flutter
categories: Flutter
---

`BLoC` 是 Google 提出的一种全新的`状态管理`方案。[Scoped Model](https://juejin.im/post/5b97fa0d5188255c5546dcf8)，[Provide](https://juejin.im/post/5c6d4b52f265da2dc675b407)等也是目前比较流行的状态管理方案。

## 为什么需要状态管理
Flutter 自身已经为我们提供了状态管理 `Stateful widget`，在 stateful widget 中，我们 widget 的描述信息被放进了 State，
而 stateful widget 只是持有一些 immutable 的数据以及创建它的状态而已。它的所有成员变量都应该是 final 的，当状态发生变化的时候，
我们需要通知视图重新绘制，这个过程就是 setState。这看上去很不错，我们改变状态的时候 `setState` 一下就可以了。 
在我们一开始构建应用的时候，也许很简单，我们这时候可能并不需要状态管理。
![](https://raw.githubusercontent.com/yangxiaoge/PersonResources/master/flutter/setState%E7%AE%80%E5%8D%95%E5%9E%8B.png)
但是随着功能的增加，你的应用程序将会有几十个甚至上百个状态。这个时候你的应用应该会是这样！
![](https://raw.githubusercontent.com/yangxiaoge/PersonResources/master/flutter/setState%E5%A4%8D%E6%9D%82%E5%9E%8B.png)
一旦当 app 的交互变得复杂，setState 出现的次数便会显著增加，每次 setState 都会重新调用 build 方法，这势必对于性能以及代码的可阅读性带来一定的影响。
能不能不使用 setState 就能刷新页面呢？如何在多个页面中共享状态？我们希望有一种更加强大的方式，来管理我们的状态。

## BLoC 是什么
`BLoC` 是一种利用 `Reactive Programming（响应式编程）` 方式构建应用的方法，这是一个由流构成的完全异步的世界。
![](https://raw.githubusercontent.com/yangxiaoge/PersonResources/master/flutter/bloc.png)

1. 用 StreamBuilder 包裹有状态的部件，streambuilder 将会监听一个流
2. 这个流来自于 BLoC
3. 有状态小部件中的数据来自于监听的流。
4. 用户交互手势被检测到，产生了事件。例如按了一下按钮。
5. 调用 bloc 的功能来处理这个事件
6. 在 bloc 中处理完毕后将会吧最新的数据 add 进流的 sink 中
7. StreamBuilder 监听到新的数据，产生一个新的 snapshot，并重新调用 build 方法
8. Widget 被重新构建

BLoC 能够允许我们完美的分离业务逻辑！再也不用考虑什么时候需要刷新屏幕了，一切交给 StreamBuilder 和 BLoC! 和 StatefulWidget 说拜拜！！

BLoC 代表业务逻辑组件（`Business Logic Component`），由来自 Google 的两位工程师 Paolo Soares 和 Cong Hui 设计，并在 2018 年 DartConf 期间（2018 年 1 月 23 日至 24 日）首次展示。[点击观看 Youtube 视频。](https://link.juejin.im/?target=https%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DPLHln7wHgPE)


>作者：Vadaski
链接：https://juejin.im/post/5bb6f344f265da0aa664d68a
来源：掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
---
title: Flutter 状态管理 - Provide（Google 亲儿子）
date: 2019-3-18 10:05:00
tags: Flutter
categories: Flutter
---

`flutter-provide` 是 Google 的亲儿子，[flutter-provide](https://github.com/google/flutter-provide)允许我们更加灵活地处理数据类型和数据。允许在小部件树中传递数据的类。它被设计为替代品 [Scoped_model](https://github.com/brianegan/scoped_model)，允许更灵活地处理数据类型和数据。

## 什么是 Provide
和 Scoped_model 一样，Provide 也是借助了 `InheritWidget`，将共享状态放到顶层 MaterialApp 之上。底层部件通过 Provide 获取该状态，并通过混合 `ChangeNotifier` 通知依赖于该状态的组件刷新。

## 第一步：添加依赖
在 `pubspec.yaml` 中添加 `provide: ^1.0.2`

## 第二步：创建 Model
```
///Counter
class Counter extends ChangeNotifier {
  int value = 0;
  String hahh = '';

  void increment() {
    value += 1;
    hahh = 'haha $value';
    notifyListeners();
  }
}

///Switcher
class Switcher extends ChangeNotifier {
  bool checked = false;
  void check() {
    checked = !checked;
    notifyListeners();
  }
}
```

### 第三步：将状态放入顶层
```
void main() {
  // Initialize the model. Can be done outside a widget, like here.
  var counter = Counter();
  var switcher = Switcher();

  // Set up a Providers instance.
  var providers = Providers();
  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<Switcher>.value(switcher));

  // Now we're ready to run the app...
  runApp(
    // ... and provide the model to all widgets within.
    ProviderNode(
      providers: providers,
      child: MyApp(),
    ),
  );
}
```

### 第四步：获取状态
```
Provide<Counter>(
    builder: (context, child, counter) => Text(
        '${counter.value}',
        style: Theme.of(context).textTheme.display1,
        ),
),
Provide<Counter>(
    builder: (context, child, counter) {
    print('改变啦，哈哈哈 ${counter.hahh}');
    return Text('${counter.hahh}');
    },
),
```

### 第五步：更新状态
```
///可以点击按钮手动触发状态更新，或者后台数据返回后触发更新等
Provide.value<Counter>(context).increment()

Provide.value<Switcher>(context).check()
```
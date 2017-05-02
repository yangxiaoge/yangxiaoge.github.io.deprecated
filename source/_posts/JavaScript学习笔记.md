---
layout:  post
title:   JavaScript学习笔记
date:    2016-12-29 09:34:01
author:     "Bruce Yang"
catalog:    true
header-img: "vallehermoso_spain_from_google_earth.jpg"
tags:
    - 前端开发
    - JavaScript
categories: JavaScript
---

# 廖雪峰 js教程
> [JavaScript教程](http://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000/00143449921138898cdeb7fc2214dc08c6c67827758cd2f000)

我的练习基本是按着教程敲了一遍.  用的Chrome调试窗口,很方便!

**以下是笔记**
## javascript的五种基本数据类型
基本数据类型: Undefined，Null，Boolean，Number和String; 此外还含有一种复杂数据类型—Object
<!-- more -->

## if判断,传参传的非boolean类型
```
var s = '123';
if (s.length) { // 条件计算结果为3
    console.log("你好啊"); //打印结果为你好啊
}
原因: JavaScript把null、undefined、0、NaN和空字符串''视为false，其他值一概视为true，因此上述代码条件判断的结果是true。
```

## Map和Set是ES6标准新增的数据类型，请根据浏览器的支持情况决定是否要使用。
```
var m = new Map([['Michael', 95], ['Bob', 75], ['Adam', 85]]);
m.get('Michael'); // 95
m.delete('Adam'); // 删除key 'Adam'

var s = new Set();
s.add(1); // Set {1}
s.add(2); // Set {1, 2}
s.add(3); // Set {1, 2,3}
s.delete(3); // Set {1, 2}
```

## ES6标准引入了新的iterable类型，Array、Map和Set都属于iterable类型。
```
// 更好的方式是直接使用`iterable`内置的`forEach`方法，它接收一个函数，每次迭代就自动回调该函数。以Array为例：
//forEach()方法是ES5.1标准引入的
var a = ['A', 'B', 'C'];
a.forEach(function (element, index, array) {
    // element: 指向当前元素的值
    // index: 指向当前索引
    // array: 指向Array对象本身
    alert(element);
});

或者:
//由于JavaScript的函数调用不要求参数必须一致，因此可以忽略它们。例如，只需要获得Array的element：
var a = ['A', 'B', 'C'];
a.forEach(function (element) {
    alert(element);
});
```

## JavaScript还有一个免费赠送的关键字arguments，它只在函数内部起作用，并且永远指向当前函数的调用者传入的所有参数。arguments类似Array但它不是一个Array：
```
arguments，你可以获得调用者传入的所有参数
实际上arguments最常用于判断传入参数的个数。你可能会看到这样的写法：
// foo(a[, b], c)
// 接收2~3个参数，b是可选参数，如果只传2个参数，b默认为null：
function foo(a, b, c) {
    if (arguments.length === 2) {
        // 实际拿到的参数是a和b，c为undefined
        c = b; // 把b赋给c
        b = null; // b变为默认值
    }
    // ...
}
要把中间的参数b变为“可选”参数，就只能通过arguments判断，然后重新调整参数并赋值。
```
## 高阶函数, 高阶函数英文叫Higher-order function
```   //练习：不要使用JavaScript内置的parseInt()函数，利用map和reduce操作实现一个string2int()函数：
        function string2int(s) {
            return s.split('').map(strNum => strNum * 1).reduce((x, y) => x * 10 + y)
        }
        string2int('12345')
```

## 细细理解 map(), reduce(), filter()的区别

## sort
```
如果不知道sort()方法的默认排序规则，直接对数字排序，绝对栽进坑里！
幸运的是，sort()方法也是一个高阶函数，它还可以接收一个比较函数来实现自定义的排序。
var arr = [10, 20, 1, 2];
arr.sort(function (x, y) {
    if (x < y) {
        return -1;
    }
    if (x > y) {
        return 1;
    }
    return 0;
}); // [1, 2, 10, 20]

var arr = ['Google', 'apple', 'Microsoft'];
arr.sort(function (s1, s2) {
    x1 = s1.toUpperCase();
    x2 = s2.toUpperCase();
    if (x1 < x2) {
        return -1;
    }
    if (x1 > x2) {
        return 1;
    }
    return 0;
}); // ['apple', 'Google', 'Microsoft']

最后友情提示，sort()方法会直接对Array进行修改，它返回的结果仍是当前Array：
```

## 闭包（Closure）
```
我们来实现一个对Array的求和。通常情况下，求和的函数是这样定义的：
function sum(arr) {
    return arr.reduce(function (x, y) {
        return x + y;
    });
}
sum([1, 2, 3, 4, 5]); // 15

如果不需要立刻求和，而是在后面的代码中，根据需要再计算怎么办？可以不返回求和的结果，而是返回求和的函数！
function lazy_sum(arr) {
    var sum = function () {
        return arr.reduce(function (x, y) {
            return x + y;
        });
    }
    return sum;
}

当我们调用lazy_sum()时，返回的并不是求和结果，而是求和函数：
var f = lazy_sum([1, 2, 3, 4, 5]); // function sum()
调用函数f时，才真正计算求和的结果：
f(); // 15

在这个例子中，我们在函数lazy_sum中又定义了函数sum，并且，内部函数sum可以引用外部函数lazy_sum的参数和局部变量，
当lazy_sum返回函数sum时，相关参数和变量都保存在返回的函数中，这种称为“闭包（Closure）”的程序结构拥有极大的威力。
```
## 箭头函数
ES6标准新增了一种新的函数：Arrow Function（箭头函数）。
```
x => x * x

上面的箭头函数相当于：

function (x) {
    return x * x;
}

箭头函数有两种格式，一种像上面的，只包含一个表达式，连{ ... }和return都省略掉了。还有一种可以包含多条语句，这时候就不能省略{ ... }和return：
x => {
    if (x > 0) {
        return x * x;
    }
    else {
        return - x * x;
    }
}
```

## generator
```
用generator改写如下：

function* fib(max) {
    var
        t,
        a = 0,
        b = 1,
        n = 1;
    while (n < max) {
        yield a;
        t = a + b;
        a = b;
        b = t;
        n ++;
    }
    return a;
}
直接调用试试：

fib(5); // fib {[[GeneratorStatus]]: "suspended", [[GeneratorReceiver]]: Window}
直接调用一个generator和调用函数不一样，fib(5)仅仅是创建了一个generator对象，还没有去执行它。

调用generator对象有两个方法，一是不断地调用generator对象的next()方法：

var f = fib(5);
f.next(); // {value: 0, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 1, done: false}
f.next(); // {value: 2, done: false}
f.next(); // {value: 3, done: true}
next()方法会执行generator的代码，然后，每次遇到yield x;就返回一个对象{value: x, done: true/false}，然后“暂停”。返回的value就是yield的返回值，done表示这个generator是否已经执行结束了。如果done为true，则value就是return的返回值。

当执行到done为true时，这个generator对象就已经全部执行完毕，不要再继续调用next()了。
```

## 标准对象
```
总结一下，有这么几条规则需要遵守：

不要使用new Number()、new Boolean()、new String()创建包装对象；

用parseInt()或parseFloat()来转换任意类型到number；

用String()来转换任意类型到string，或者直接调用某个对象的toString()方法；

通常不必把任意类型转换为boolean再判断，因为可以直接写if (myVar) {...}；

typeof操作符可以判断出number、boolean、string、function和undefined；

判断Array要使用Array.isArray(arr)；

判断null请使用myVar === null；

判断某个全局变量是否存在用typeof window.myVar === 'undefined'；

函数内部判断某个变量是否存在用typeof myVar === 'undefined'。
```

## RegExp (正则表达式)
```
在正则表达式中，如果直接给出字符，就是精确匹配。用\d可以匹配一个数字，\w可以匹配一个字母或数字，所以：

'00\d'可以匹配'007'，但无法匹配'00A'；

'\d\d\d'可以匹配'010'；

'\w\w'可以匹配'js'；

.可以匹配任意字符，所以：

'js.'可以匹配'jsp'、'jss'、'js!'等等。

JavaScript的正则表达式还有几个特殊的标志，最常用的是g，表示全局匹配：
var s='zhuzhuyang, xiaoyang, feiyang';
var reg = /[a-zA-Z]+yang/g;

reg.exec(s); //['zhuzhuyang']
reg.lastIndex; //10

reg.exec(s); //['xiaoyang']
reg.lastIndex; //20

reg.exec(s); //['feiyang']
reg.lastIndex; //29

reg.exec(s); // null，直到结束仍没有匹配到
```

## JSON
```
在2002年的一天，道格拉斯·克罗克福特（Douglas Crockford）同学为了拯救深陷水深火热同时又被某几个巨型软件企业长期愚弄的软件工程师，发明了JSON这种超轻量级的数据交换格式。

道格拉斯同学长期担任雅虎的高级架构师，自然钟情于JavaScript。他设计的JSON实际上是JavaScript的一个子集。在JSON中，一共就这么几种数据类型：

number：和JavaScript的number完全一致；
boolean：就是JavaScript的true或false；
string：就是JavaScript的string；
null：就是JavaScript的null；
array：就是JavaScript的Array表示方式——[]；
object：就是JavaScript的{ ... }表示方式。
```
## 序列化
```
var xiaoming = {
    name: '小明',
    age: 14,
    gender: true,
    height: 1.65,
    grade: null,
    'middle-school': '\"W3C\" Middle School',
    skills: ['JavaScript', 'Java', 'Python', 'Lisp']
};
JSON.stringify(xiaoming); // '{"name":"小明","age":14,"gender":true,"height":1.65,"grade":null,"middle-school":"\"W3C\" Middle School","skills":["JavaScript","Java","Python","Lisp"]}'

要输出得好看一些，可以加上参数，按缩进输出：

JSON.stringify(xiaoming, null, '  ');

{
  "name": "小明",
  "age": 14,
  "gender": true,
  "height": 1.65,
  "grade": null,
  "middle-school": "\"W3C\" Middle School",
  "skills": [
    "JavaScript",
    "Java",
    "Python",
    "Lisp"
  ]
}

更多JSON用法可以看廖雪峰教程
```

## 面向对象编程
JavaScript的原型链和Java的Class区别就在，它没有“Class”的概念，所有对象都是实例，所谓继承关系不过是把一个对象的原型指向另一个对象而已。
```
var Student = {
    name: 'Robot',
    height: 1.2,
    run: function () {
        console.log(this.name + ' is running...');
    }
};

var xiaoming = {
    name: '小明'
};

xiaoming.__proto__ = Student;

注意最后一行代码把xiaoming的原型指向了对象Student，看上去xiaoming仿佛是从Student继承下来的：

xiaoming.name; // '小明'
xiaoming.run(); // 小明 is running...
xiaoming有自己的name属性，但并没有定义run()方法。不过，由于小明是从Student继承而来，只要Student有run()方法，xiaoming也可以调用：
```
![](http://www.liaoxuefeng.com/files/attachments/001435287613668a73ab76ccc85411282c1b1370be41636000/l)
`请注意`，上述代码仅用于演示目的。在编写JavaScript代码时，不要直接用obj.__proto__去改变一个对象的原型，并且，低版本的IE也无法使用__proto__。Object.create()方法可以传入一个原型对象，并创建一个基于该原型的新对象，但是新对象什么属性都没有，因此，我们可以编写一个函数来创建xiaoming：
```
// 原型对象:
var Student = {
    name: 'Robot',
    height: 1.2,
    run: function () {
        console.log(this.name + ' is running...');
    }
};

function createStudent(name) {
    // 基于Student原型创建一个新对象:
    var s = Object.create(Student);
    // 初始化新对象:
    s.name = name;
    return s;
}

var xiaoming = createStudent('小明');
xiaoming.run(); // 小明 is running...
xiaoming.__proto__ === Student; // true
```
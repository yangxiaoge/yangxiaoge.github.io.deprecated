---
title: ' Android 踩过的坑'
date: 2016-06-23 11:02:22
tags: Android
categories: Android
top: 99
---
## AlertDialog弹出框 按钮在高版本中看不见(其实是颜色为白色) (2016-8-16 18:24:05)
在android 6.0中变成了下面这种
![白底按钮,看不见.6.0测试机不在,手动把按钮涂鸦了~~](http://ww2.sinaimg.cn/mw690/c05ae6b6gw1f6vrosgtzuj209n03n3yf.jpg)
实际的效果应该是如下的
![正常的Dialog](http://ww4.sinaimg.cn/mw690/c05ae6b6gw1f6vrhubh9bj20aa03wmx2.jpg)
`解决方法:` 引用v7包下的AlertDialog (android.support.v7.app.AlertDialog)
<!-- more -->
## 最近被异步请求坑了好几次了！(2016-7-28 14:21:18)
`注意:`网络请求是异步的,因此在 response 获取到数据时直接为组件,或者其他用处,直接调用,否则可能由于网络访问速度较慢,导致空指针!
因此:在接口成功response之后执行最安全!

## RadioButton多行队列显示！！！(2016-8-2 18:06:47)
>由于原生的RadioGroup只支持横向纵向排列RadioButton,所以只能自己造轮子!
详情:见另一篇文章 --> [实现多行多列的RadioButton](/2016/08/02/实现多行多列的RadioButton/)



## 当前页面有多个EditText软键盘回车样式一直是Next,导致无法关闭软键盘!(2016-7-27 13:10:39)
>可以修改EditText的回车样式，即是把EditText的`ImeOptions`属性设置成不同的值，Enter键上就会显示不同的文字或图案

```
actionNone : 回车键，按下后光标到下一行
actionGo ： Go，
actionSearch ： 一个放大镜
actionSend ： Send
actionNext ： Next
actionDone ： Done，隐藏软键盘，即使不是最后一个文本输入框

例如:
<EditText
            android:id="@+id/transfer_other_edit"
            android:layout_width="162dp"
            android:layout_height="@dimen/height_33"
            android:layout_marginLeft="22dp"
            android:background="@drawable/card_edittxt_bg"
            android:inputType="number"
            android:paddingLeft="@dimen/padding_13"
            android:singleLine="true"
----------->android:imeOptions="actionDone"
            android:textColor="#3f3f3f"
            android:textSize="13sp"/>
```


## 多次点击查询(迅速点击)，listView数据重复（2016-7-25 15:33:44）
> 单身狗的手速亲测!(；′⌒`)

`例如:`
```
RequestApi.qryReachargeHistory(Constants.PREFIX + msisdn, params, new StringCallback() {

			// ① 只要查询方法执行,那么这里立刻执行。所以如果手速快，就算clear也没用!
			//rechargeList.clear(); 这里是没用的
            @Override
            public void onResponse(String response) {
                rechargeList.clear(); // ① 必须此处clear, rechargeList异步执行之前,同一个方法中clear才有效!
                Logger.json(response);
                JsonObject obj = new JsonParser().parse(response).getAsJsonObject();
                if (!obj.get("rechargeList").toString().equals("null")) {
                    JsonArray jsonArray = obj.get("rechargeList").getAsJsonArray();
                    for (int i = 0; i < jsonArray.size(); i++) {
                        Map<String, Object> chargeInfo = new HashMap<>();
                        JsonObject job = (JsonObject) jsonArray.get(i);
                        chargeInfo.put("accountNumber", /*Constants.PREFIX +*/ accountNumber);
                        chargeInfo.put("amount", job.get("amount").getAsString());
                        chargeInfo.put("tradeType", job.get("tradeType").getAsString());
                        chargeInfo.put("extendDays", job.get("extendDays").getAsString());
                        chargeInfo.put("tradeTime", job.get("tradeTime").getAsString());
                        chargeInfo.put("tradeMethod", job.get("tradeMethod").getAsString());
                        rechargeList.add(chargeInfo); // ②此处其实是异步的!!

                    }

                    myTopUpHistoryListViewAdapter.notifyDataSetChanged();

                    if (rechargeList.size() <= 0) {
                        nodataTipsView.setVisibility(View.VISIBLE);
                        rechargeHistoryListview.setVisibility(View.GONE);
                    } else {
                        nodataTipsView.setVisibility(View.GONE);
                        rechargeHistoryListview.setVisibility(View.VISIBLE);
                    }
                }
            }

            @Override
            public void onError(Request request, Exception e) {
                if (e != null) {
                    Logger.e(e.getMessage());
                } else {
                    Logger.e("Exception is null");
                }
            }
        });
    }
```

## 在`activity`的`oncreate`方法中使用`popupwindow`出现以下错误：

android.view.WindowManager$BadTokenException: `Unable to add window --
token null is not valid; is your activity running?` 真是醉啦,研究了好久无头绪。

*爬完坑后*我自己写了个[引导的Demo](https://github.com/yangxiaoge/Yindao_Animation)

`google`了好多文章找到了原因，[原文链接](http://www.jcodecraeer.com/a/anzhuokaifa/androidkaifa/2013/0304/963.html):http://www.jcodecraeer.com/a/anzhuokaifa/androidkaifa/2013/0304/963.html
`错误的原因是`：popupwindow要依附于一个activity，而activity的onCreate()还没执行完，哪来的popup让你弹出来嘛。
`解决方法`:应把pop.showAtLocation(parent, Gravity.TOP,0, 0)这一句`移出`oncreate方法，在控件渲染完毕后再使用(按钮点击等时机执行)。

当然还有绝佳的解决方法(`其实是不行的`, 引导页面一直循环!!!)：
```
@Override
public void onWindowFocusChanged(boolean hasFocus) {
 // TODO Auto-generated method stub
 super.onWindowFocusChanged(hasFocus);
 if(hasFocus){
    newbieGuide();
 }
}

其中newbieGuide()是我自己定义的专门显示popupwindow的一个函数。
当activity获得焦点之后，activity是加载完毕的了，这个方法的技巧性比较强，很难想到。
`但是`,onWindowFocusChanged方法中这么执行会重复popup,具体要看需求,实在不行就用上面方法(按钮点击执行)!!~
```

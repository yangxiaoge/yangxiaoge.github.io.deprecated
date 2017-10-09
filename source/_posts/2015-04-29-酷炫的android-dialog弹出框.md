---
title: 酷炫的android dialog弹出框
date: 2015-04-29 13:52:49
tags: [Android,Gradle]
categories: Android
---
基于github开源框架基础上运用在自己的项目中,
`效果如下`:
![弹出框动图](http://ww2.sinaimg.cn/mw690/c05ae6b6gw1f3dxm8t071g20cm0jqnpd.gif)
<!-- more -->
本演示项目 基于`Android Studio`开发,
在对应`moudle`下的`gradle.build`中添加以下依赖
```
compile 'com.nineoldandroids:library:2.4.0' 
compile 'com.github.sd6352051.niftydialogeffects:niftydialogeffects:1.0.0@aar'
```
`核心代码`列出:

> effect是样式(具体要根据需求来)

``` 
	String []type = {"Fadein", "Slideleft", "Slidetop", "SlideBottom", "Slideright", "Fall", "Newspager", "Fliph", "Flipv", "RotateBottom", "RotateLeft", "Slit", "Shake", "Sidefill"};
            int i= (int) (type.length*Math.random());
            Effectstype effect = null;
            switch (i){
                case 0:effect=Effectstype.Fadein;break;
                case 1:effect=Effectstype.Slideright;break;
                case 2:effect=Effectstype.Slideleft;break;
                case 3:effect=Effectstype.Slidetop;break;
                case 4:effect=Effectstype.SlideBottom;break;
                case 5:effect=Effectstype.Newspager;break;
                case 6:effect=Effectstype.Fall;break;
                case 7:effect=Effectstype.Sidefill;break;
                case 8:effect=Effectstype.Fliph;break;
                case 9:effect=Effectstype.Flipv;break;
                case 10:effect=Effectstype.RotateBottom;break;
                case 11:effect=Effectstype.RotateLeft;break;
                case 12:effect=Effectstype.Slit;break;
                case 13:effect=Effectstype.Shake;break;
            }
```


> 弹出框核心如下

```
    final NiftyDialogBuilder dialogBuilder = NiftyDialogBuilder.getInstance(this);

            dialogBuilder
                    // 重点设置
                    .withEffect(effect)        //设置对话框弹出样式
                    //.setCustomView(R.layout.custom, MainActivity.this) // 设置自定义对话框的布局
                    .withDuration(700)              //动画显现的时间（时间长就类似放慢动作）

                    // 基本设置
                    .withTitle("Info")         //设置对话框标题
                    .withTitleColor("#FFFFFF")          //设置标题字体颜色
                    .withDividerColor("#11000000")      //设置分隔线的颜色
                    .withMessage("Are you sure logout?")//设置对话框显示内容
                    .withMessageColor("#FFFFFFFF")       //设置消息字体的颜色
                    .withDialogColor("#FFE74C3C")        //设置对话框背景的颜色
                    //.withIcon(getResources().getDrawable(R.drawable.logo)) //设置标题的图标
                    // 设置是否模态，默认false，表示模态，
                    //要求必须采取行动才能继续进行剩下的操作 | isCancelable(true)
                    .isCancelableOnTouchOutside(true)
                    .withButton1Text("Yes")               //设置按钮1的文本
                    .withButton2Text("No")          //设置按钮2的文本

                    .setButton1Click(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            Toast.makeText(v.getContext(), "I am btnYes", Toast.LENGTH_SHORT).show();
                            dialogBuilder.dismiss();
                        }
                    })
                    .setButton2Click(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            Toast.makeText(v.getContext(), "I am btnNo", Toast.LENGTH_SHORT).show();
                            dialogBuilder.dismiss();
                        }
                    })
                    .show();
```

app [demo](http://fir.im/NiftyDialog)下载地址: [http://fir.im/NiftyDialog](http://fir.im/NiftyDialog)
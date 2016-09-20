---
title: 自定义Button(图文居中)
date: 2015-04-29 13:39:56
tags: [Android,自定义View]
categories: Android
---

>首先看下 **效果**

![带图片箭头的按钮](http://ww4.sinaimg.cn/mw690/c05ae6b6gw1f3dxjw0a3aj208601ft8j.jpg)
`核心代码:`
<!-- more -->
```
package com.ztesoft.zsmart.datamall.app.widget;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.widget.Button;

/**
 * Description: 自定义Button(图文居中)
 * Author: 0027008122 [yang.jianan@zte.com.cn]
 * Time: 2016/1/26 14:21
 * Version: 1.0
 */
public class DrawableCenterButton extends Button{

    public DrawableCenterButton(Context context) {
        super(context);
        // TODO Auto-generated constructor stub
    }

    public DrawableCenterButton(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
    }

    public DrawableCenterButton(Context context, AttributeSet attrs) {
        super(context, attrs);
    }


    @Override
    protected void onDraw(Canvas canvas) {
        Drawable[] drawables = getCompoundDrawables();
        if (drawables != null) {
            Drawable drawableLeft = drawables[2];
            if (drawableLeft != null) {
                float textWidth = getPaint().measureText(getText().toString());
                int drawablePadding = getCompoundDrawablePadding();
                int drawableWidth = 0;
                drawableWidth = drawableLeft.getIntrinsicWidth();
                // 20 是偏移量,不加,长文本会折行
                float bodyWidth = textWidth + 20 + drawableWidth + drawablePadding;
                setPadding(0, 0, (int)(getWidth() - bodyWidth), 0);
                canvas.translate((getWidth() - bodyWidth) / 2, 0);
            }
        }
        super.onDraw(canvas);
    }
}

```

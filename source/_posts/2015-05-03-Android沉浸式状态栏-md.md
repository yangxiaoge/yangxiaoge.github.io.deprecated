---
title: Android沉浸式状态栏
date: 2016-03-25 17:04:30
tags: Android
categories: Android
---

>`GitHub`Demo[ 源码](https://github.com/yangxiaoge/ImmersiveStatusBar)


## 1. 首先看下`状态栏`与`导航栏`结构图
>主要设置以下两个颜色一致
> 1. **colorPrimary **
> 2. **colorPrimaryDark** 

![状态栏结构.jpg](http://ww2.sinaimg.cn/mw690/c05ae6b6gw1f3hyhtv36cj20j60b5q39.jpg)
<!-- more -->
## 2. 引用库  [SystemBarTint](https://github.com/jgilfelt/SystemBarTint), 并在`module / build.gradle`里添加以下依赖:
>compile 'com.readystatesoftware.systembartint:systembartint:1.0.3'
![](http://ww1.sinaimg.cn/mw690/c05ae6b6jw1f3llhi475qj20jr04u75n.jpg)

## 3. 写一个公共的`BaseActivity`, 只要继承`BaseActivity`即可实现沉浸式效果
```
package androidautolayout.yjn.com.statusbar;

import android.annotation.TargetApi;
import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.Window;
import android.view.WindowManager;

import com.readystatesoftware.systembartint.SystemBarTintManager;

public class BaseActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            setTranslucentStatus(true);
        }
        SystemBarTintManager tintManager = new SystemBarTintManager(this);
        tintManager.setStatusBarTintEnabled(true);
        tintManager.setStatusBarTintResource(R.color.colorPrimary);
    }


    @TargetApi(Build.VERSION_CODES.KITKAT)
    private void setTranslucentStatus(boolean on) {
        Window win = getWindow();
        WindowManager.LayoutParams winParams = win.getAttributes();
        final int bits = WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS;
        if (on) {
            winParams.flags |= bits;
        } else {
            winParams.flags &= ~bits;
        }
        win.setAttributes(winParams);
    }
}

```

>`Avtivity`直接 extends `BaseActivity`

```
public class MainActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }
}
```

## 4.注册清单设置 `AndroidManifest.xml`

![](http://ww1.sinaimg.cn/mw690/c05ae6b6jw1f3llhgnmzyj20yg0b4ade.jpg)

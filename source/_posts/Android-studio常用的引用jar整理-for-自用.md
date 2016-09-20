---
title: Android Studio常用的引用jar整理 for 自用
date: 2015-05-10 15:29:50
tags: [Android Studio,Gradle]
categories: Android
---

## 1. [orhanobut/logger](https://github.com/orhanobut/logger)

```
allprojects {
    repositories {
        jcenter()
        // 项目gradle中添加 jitpack仓库
        maven { url "https://jitpack.io" }
    }
}

dependencies {
        //  moudle/gradle中添加
  	  compile 'com.github.orhanobut:logger:1.12'
}
```
<!-- more -->
**注意**: `Logger.init(YOUR_TAG)`为初始化入口

## 2. [orhanobut/dialogplus](https://github.com/orhanobut/dialogplus)

```
compile 'com.orhanobut:dialogplus:1.11@aar'
```
> 例如:

```
	private DialogPlus generateDialog(String tag) {

        View contentView = this.getActivity().getLayoutInflater().inflate(R.layout.bundle_filelter_pop, null);

        bundleFilterList = (ListView) contentView.findViewById(R.id.bundle_filter_list);

        cancelBundleFilterBtn = (TextView) contentView.findViewById(R.id.bundle_selfilter_cancel_btn);

        if (catalogs != null && !catalogs.isEmpty()) {
            ArrayAdapter<String> adapter = new ArrayAdapter<>(this.getActivity(), R.layout.simple_list_item_1_center, catalogs);
            bundleFilterList.setAdapter(adapter);
        }

        DialogPlus dialog = DialogPlus.newDialog(this.getActivity())
                .setContentHolder(new ViewHolder(contentView))
                .create();
        return dialog;
}
```
`效果图如下:`
![dialogplus.png](http://ww3.sinaimg.cn/mw690/c05ae6b6gw1f41medvgiuj20ah0iawfb.jpg)

## 3. [懒人框架 ](https://github.com/JakeWharton/butterknife)

```
compile 'com.jakewharton:butterknife:7.0.0'
```

## 4. [http封装-hongyang](https://github.com/hongyangAndroid/okhttp-utils)

```
compile 'com.zhy:okhttputils:2.4.1'
```

## 5. [Gson](https://github.com/google/gson)

```
compile 'com.google.code.gson:gson:2.2.4'
```


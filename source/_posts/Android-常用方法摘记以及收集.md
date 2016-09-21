---
title: Android 常用方法摘记
date: 2016-01-08 10:50:55
tags: Android
categories: Android
top: 100
---
## Android调用微信扫一扫和支付宝扫一扫(2016-9-20 19:01:47)
摘自:[习惯沉默的Blog
](https://ydmmocoo.github.io/2016/06/30/Android%E8%B0%83%E7%94%A8%E5%BE%AE%E4%BF%A1%E6%89%AB%E4%B8%80%E6%89%AB%E5%92%8C%E6%94%AF%E4%BB%98%E5%AE%9D%E6%89%AB%E4%B8%80%E6%89%AB/)
现在微信不能直接跳转到微信扫一扫:详见 [Android调用微信扫一扫_CSDN](http://blog.csdn.net/l_lhc/article/details/51636130)
## 访问或者下载单个github文件(2016-9-20 18:43:37)
**用途:**可以用来存一些配置文件,图片等.
url固定格式: https://raw.githubusercontent.com/username/repository/branch/filename 
例如: https://raw.githubusercontent.com/yangxiaoge/MumuXi/master/README.md
> 参考stackoverflow:[Download single files from GitHub](http://stackoverflow.com/questions/4604663/download-single-files-from-github)

<!-- more -->

## Gson构造JsonArray(2016-8-23 16:11:25)
最近项目中请求参数传参用到了 JsonArray对象
构造方法如下:

```
    Object[] object = new Object[]{"111", "222", "24G"};
    JsonArray jsonArr = new JsonArray();
    for (Object anObject : object) {
        JsonObject jo = new JsonObject(); //构造json
        jo.addProperty("offerCode", (String) anObject);
        jsonArr.add(jo);
    }
    Toast.makeText(this, "jsonArr:  " + jsonArr.toString(), Toast.LENGTH_SHORT).show();
    System.out.println("jsonArr:  " + jsonArr.toString());
```


## LICEcap录制Gif工具(2016-8-2 18:57:50)
[官网地址](http://www.cockos.com/licecap/)

![录制的gif图](http://www.cockos.com/licecap/licecap_rules.gif)

## 读取Assets( 下面 cityId查询天气 中的是另一种读取方法)目录下文件(`2016-06-12`)

*[例如:](http://www.jianshu.com/p/b87fee2f7a23)*

>简书:http://www.jianshu.com/p/b87fee2f7a23


```
InputStreamReader isr = new InputStreamReader(this.getClass()
					.getClassLoader()
					.getResourceAsStream("assets/" + "student.json")
					,"utf-8"
					);
//从assets获取json文件
BufferedReader bfr = new BufferedReader(isr);
```

## cityId查询天气(`2016-6-20 19:00:35`)
1. citycode.txt是cityid文件(数据 101190101=南京 ) 
2. 下面代码是 逐行根据"="分隔符,读写城市id跟name,可以写到文件中

```
	/**
     * 根据城市名找到对应的id如果没有则说明在中国气象网不存在该城市
     *
     * @param cityname
     * @return
     */
    private String findId(String cityname) {
        if (null == cityname || "".equals(cityname))
            return null;
        try {
            InputStreamReader inputReader = new InputStreamReader(getResources().getAssets().open("citycode.txt"));
            BufferedReader bufReader = new BufferedReader(inputReader);
            String line = "";
            String[] str = new String[2];
            while ((line = bufReader.readLine()) != null) {
                str = line.split("=");
                if (str.length == 2 && null != str[1] && !"".equals(str[1]) && cityname.equals(str[1])) {
                    //返回对应city编号
                    return str[0];
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
        return null;
    }
```


## 双击两次返回键退出 (2秒内退出)
``` 
private long exitTime = 0; // 返回键 退出时间
 /**
     *  返回键 (2秒内退出)
     * @param keyCode 返回键code
     * @param event keyEvent
     * @return true
     */
 @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {

        if (keyCode == KeyEvent.KEYCODE_BACK && event.getAction() == KeyEvent.ACTION_DOWN) {
            //两秒之内按返回键就会退出
            if (System.currentTimeMillis() - exitTime > 2000) {
                Toast.makeText(this, "再按一次退出", Toast.LENGTH_SHORT).show();
                exitTime = System.currentTimeMillis();
            } else {
                finish();
            }
            return true; // 不要忘记 return true
        }

        return super.onKeyDown(keyCode, event);
}
```
下面是点击返回键 关闭DrawerLayout等等
```
/**
     * 系统返回键监听,事件处理
     * @return
     */
    @Override
    public void onBackPressed() {
        HomeViewPagerFragment homeFragment = null;
        boolean isDrawerOpen = false;
        boolean isPopFragment = false;
        String currentTabTag = mTabHost.getCurrentTabTag();

        String homeName = getResources().getString(MainTab.HOME.getResName());

        String bundleName = getResources().getString(MainTab.BUNDLES.getResName());

        String billName = getResources().getString(MainTab.BILL.getResName());

        if (currentTabTag.equals(bundleName)) {
            isPopFragment = ((BaseContainerFragment)getSupportFragmentManager().findFragmentByTag(bundleName)).popFragment();
        } else if (currentTabTag.equals(billName)) {
            isPopFragment = ((BaseContainerFragment)getSupportFragmentManager().findFragmentByTag(billName)).popFragment();
        }

        if(currentTabTag.equals(homeName)){
            homeFragment= ((HomeViewPagerFragment)getSupportFragmentManager().findFragmentByTag(homeName));
            isDrawerOpen = homeFragment.isDrawerOpen();
        }

        if(isDrawerOpen){
            homeFragment.closeDrawer();
        }else if(!isPopFragment){
            finish();
        }
}
```



## RadioButton 点击事件 (`2016-06-08`)

>借助[`ButterKnife`](https://github.com/JakeWharton/butterknife)快速实现

```
@OnCheckedChanged({R.id.searchRb1, R.id.searchRb2, R.id.searchRb3, R.id.searchRb4})
void onTagChecked(RadioButton searchRb, boolean checked) {
    if (checked) {
        //实现代码...
    }
}
```

## 夜神 模拟器连接(`2016-6-22 13:44:46`)
`流畅度杠杆的!`
```
adb connect 127.0.0.1:62001
```
`Fiddler抓包设置`: `具体参考`👉[trinea分享](http://www.trinea.cn/android/android-network-sniffer/)
1)![模拟器抓包配置](http://ww1.sinaimg.cn/mw690/c05ae6b6gw1f567o10j00j209r0ag0t8.jpg)
2)(实验证明已经不需要这一步了,只要设置好代理服务器主机名就行了!! add 2016-8-16 16:09:01) 模拟器浏览器打开: http://10.45.16.34:8888/(10.45.16.34就是本机地址, 所有模拟器都是这么访问)

## 海马玩 模拟器连接(`2016-06-14`)
> http://www.jianshu.com/p/c2e6a4e7e9c4/comments/2742091#comment-2742091
```
adb connect 127.0.0.1:26944
```
`抓包设置`: 代理服务器主机名: 10.0.3.2 (genymotion也是这个), 夜神的是电脑ip

## app启动页面(AlphaAnimation渐变) (`2016-06-14`)

`效果图:`![AlphaAnimation透明到不透明](http://ww3.sinaimg.cn/mw1024/c05ae6b6gw1f4x1cf5056g20kb0k3nb0.gif)

> 完整代码如下↓↓↓↓↓↓


```
public class StartActivity extends AppCompatActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        final View view = View.inflate(this, R.layout.activity_start, null);
        setContentView(view);
        // 渐变展示启动屏 , 0.0-1.0 透明到不透明
        AlphaAnimation aa = new AlphaAnimation(0.1f, 1.0f);
        aa.setDuration(3000);
        view.startAnimation(aa);
        aa.setAnimationListener(new Animation.AnimationListener() {
            @Override
            public void onAnimationEnd(Animation animation) {
                // 动画结束跳转登陆界面
                redirectTo();
            }

            @Override
            public void onAnimationRepeat(Animation animation) {
            }

            @Override
            public void onAnimationStart(Animation animation) {
            }
        });
    }

    private void redirectTo() {
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
        finish();
    }
}
```
## adapter中setTag()的使用

可以用来当前方法中传数据

```
	@Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        final ViewHolder holder;
        if (convertView == null) {
            holder = new ViewHolder();
            convertView = LayoutInflater.from(context).inflate(R.layout.temp, parent, false);
            holder.nameTv = (TextView) convertView.findViewById(R.id.name);
            holder.group = (RadioGroup) convertView.findViewById(R.id.group);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }

        HashMap<String, Object> map = getItem(position);
        map.put("position", position);
 --->   holder.group.setTag(map); // 通过group视图设置setTag(map)
		...
		...
		...
 ---> 	HashMap<String, Object> radioMap = (HashMap<String, Object>) group.getTag(); // getTag()
```

## Gson把JsonArray的字符串转成bean实体类

```
	String offerItemGroupStr;
	
	JsonArray array = (JsonArray) new JsonParser().parse(offerItemGroupStr);

    List<OfferItemGroup> offerDepGroupsList = new Gson().fromJson(array.toString(), new TypeToken<List<OfferItemGroup>>() {
        }.getType());
```

## [圆形进度条](https://github.com/DmitryMalkovich/circular-with-floating-action-button)(`2016-7-1 13:20:24`)
![Float Button 圆形进度条效果](http://ww3.sinaimg.cn/mw690/c05ae6b6gw1f809mvxj8uj209x0bvq36.jpg)

`week`开源啦!! [alibaba-week入口](https://github.com/alibaba/weex)

## 保存图片到本地文件(2016-7-11 12:35:51)
参考: [Mumuxi代码](https://github.com/yangxiaoge/MumuXi/blob/master/app/src/main/java/com/yang/bruce/mumuxi/util/ImgSaveUtil.java)

```
/**
 * Created by allen on 2016/6/19.
 *
 *  Here reference is https://github.com/gaolonglong/GankGirl/blob/master/app/src/main/java/com/app/gaolonglong/gankgirl/util/ImageUtil.java
 */
public class ImgSaveUtil {

        public static Uri saveImage(Context context, String url, Bitmap bitmap, ImageView imageView, String tag){
            //妹纸保存路径
            String imgDir = Environment.getExternalStorageDirectory().getPath() + "/GankGirl";
            //图片名称处理
            String[] fileNameArr = url.substring(url.lastIndexOf("/") + 1).split("\\.");
            String fileName = fileNameArr[0] + ".png";
            //创建文件路径
            File fileDir = new File(imgDir);
            if (!fileDir.exists()){
                fileDir.mkdir();
            }
            //创建文件
            File imageFile = new File(fileDir,fileName);
            try {
                FileOutputStream fos = new FileOutputStream(imageFile);
                boolean compress = bitmap.compress(Bitmap.CompressFormat.PNG, 100, fos);
                Snackbar.make(imageView,"妹纸已经躺在你的图库里啦.. ( ＞ω＜)", Snackbar.LENGTH_SHORT).show();

                fos.flush();
                fos.close();
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }

            Uri uri = Uri.fromFile(imageFile);
            //发送广播，通知图库更新
            context.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE,uri));
            return uri;
        }
}
```

## 样式统一设置 (2016-7-12 15:06:40)
>例如:

```
 <!--全边框 输入框样式-->
    <style name="edittext_style">
        <item name="android:layout_width">match_parent</item>
        <item name="android:layout_height">wrap_content</item>
        <item name="android:layout_marginLeft">@dimen/space_20</item>
        <item name="android:layout_marginRight">@dimen/space_20</item>
        <item name="android:layout_marginTop">@dimen/space_10</item>
        <item name="android:background">@drawable/input_bg</item>
        <item name="android:singleLine">true</item>
    </style>

    <!--只有底边边框 输入框样式-->
    <style name="edittext_style1" parent="edittext_style">
        <item name="android:background">?attr/editTextBackground</item>
    </style>
```

## touch事件监听之tab页再次点击刷新数据 (2016-7-15 14:23:06)

>具体可以看 开源中国源码: [MainActivity](http://git.oschina.net/oschina/android-app/blob/v2.6.3/app/src/main/java/net/oschina/app/ui/MainActivity.java?dir=0&filepath=app%2Fsrc%2Fmain%2Fjava%2Fnet%2Foschina%2Fapp%2Fui%2FMainActivity.java&oid=b7ab17b172b074e42015b3f5d806473216aec919&sha=0e04398d8fd738c25abf7a0a61f988d15cbf2a08)中

```
 @Override
    public boolean onTouch(View v, MotionEvent event) {
        super.onTouchEvent(event);
        boolean consumed = false;
        // use getTabHost().getCurrentTabView to decide if the current tab is
        // touched again
        if (event.getAction() == MotionEvent.ACTION_DOWN
                && v.equals(mTabHost.getCurrentTabView())) {
            // use getTabHost().getCurrentView() to get a handle to the view
            // which is displayed in the tab - and to get this views context
            Fragment currentFragment = getCurrentFragment();
            if (currentFragment != null
                    && currentFragment instanceof OnTabReselectListener) {
                OnTabReselectListener listener = (OnTabReselectListener) currentFragment;
                listener.onTabReselect();
                consumed = true;
            }
        }
        return consumed;
    }
```

## ProgressDialog使用:例如登录等待时 (2016-7-15 14:55:24)
`下面的代码可以参考 Afrimax或者MPT的[BaseActivity](https://coding.net/u/yangxiaoge/p/AfrimaxMI/git/blob/master/app/src/main/java/com/ztesoft/zsmart/datamall/app/base/BaseActivity.java)`

```
// =======================DIALOG_CONTROL_INTERFACE START========================

    // dialog 是否处于可见状态
    private boolean _isVisible;

    private ProgressDialog _waitDialog;

    @Override
    public void hideWaitDialog() {
        if (_isVisible && _waitDialog != null) {
            try {
                _waitDialog.dismiss();
                _waitDialog = null;
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    @Override
    public ProgressDialog showWaitDialog() {
        return showWaitDialog(R.string.loading);
    }

    @Override
    public ProgressDialog showWaitDialog(int resid) {
        return showWaitDialog(getString(resid));
    }

    /**
     * 显示耗时操作等待弹出框
     *
     * @param message 提示消息
     * @return ProgressDialog
     */
    @Override
    public ProgressDialog showWaitDialog(String message) {
        if (_isVisible) {
            if (_waitDialog == null) {
                _waitDialog = DialogHelp.getWaitDialog(this, message);
            } else if (_waitDialog != null) {
                _waitDialog.setMessage(message);
            }
            _waitDialog.show();
            return _waitDialog;
        }
        return null;
    }


    // =======================DIALOG_CONTROL_INTERFACE END==========================
```

## 远程调试App或者WiFi调试(2016-7-19 19:34:09)
>http://www.jianshu.com/p/e9c243b5060b

![效果图](http://upload-images.jianshu.io/upload_images/721315-6978db5b6f2c1c75.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

## ScrollView初始化数据时不置顶(2016-7-20 16:36:01)
>ScrollView布局设置一个属性即可!如果不设置,那么默认显示位置在ListView(等等..)底部
具体可以参考: [ScrollView嵌套ListView不置顶显示](http://blog.csdn.net/ronaldong99/article/details/50736423)
```
mScrollView.smoothScrollTo(0, 0);
```

## 使用BroadCast发送广播,通知home页刷新数据(2016-7-29 13:05:32)
```
 //----------------发送广播 , intent传值--------------//
 private void sendRefreshAccountBroadcast() {
        Intent intent = new Intent(Constants.REFRESH_HOME_ACCOUNT_LIST);
        intent.putExtra(Constants.REFRESH_HOME_ACCOUNT_LIST, true);
        getBaseContext().sendBroadcast(intent);
    }
	
	

//----------------------接收广播 start------------------//
 private final BroadcastReceiver mReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent.getBooleanExtra(Constants.REFRESH_HOME_ACCOUNT_LIST, false)) {
                // 刷新数据
				initExpendListViewData();
            }
        }
    };

	
@Override
public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // 注册广播监听
        IntentFilter filter = new IntentFilter(Constants.REFRESH_HOME_ACCOUNT_LIST);
        getActivity().registerReceiver(mReceiver, filter);
    }
//-------------------接收广播 end------------------------//
	

```

## EditText数据监听!登录模块,动态搜索模块等(2016-7-30 14:29:58)
```
	etUsertel.addTextChangedListener(new TextChange());
    etPassword.addTextChangedListener(new TextChange());

	// EditText监听器
    class TextChange implements TextWatcher {

        @Override
        public void afterTextChanged(Editable arg0) {

        }

        @Override
        public void beforeTextChanged(CharSequence arg0, int arg1, int arg2,
                int arg3) {

        }

        @Override
        public void onTextChanged(CharSequence cs, int start, int before,
                int count) {

            boolean Sign2 = et_usertel.getText().length() > 0;
            boolean Sign3 = et_password.getText().length() > 0;

			// 设置登录按钮的颜色,以及是否可点击!
            if (Sign2 & Sign3) {
                btnLogin.setTextColor(0xFFFFFFFF);
                btnLogin.setEnabled(true);
            }
            // 在layout文件中，对Button的text属性应预先设置默认值，否则刚打开程序的时候Button是无显示的
            else {
                btnLogin.setTextColor(0xFFD0EFC6);
                btnLogin.setEnabled(false);
            }
        }

    }
```

## AS快捷键(2016-8-2 18:58:02)
![android_studio快捷键](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1f6fkhxh18yj214k0pw4bs.jpg)

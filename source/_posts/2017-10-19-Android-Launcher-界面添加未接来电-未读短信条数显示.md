---
title: Android Launcher 界面添加未接来电/未读短信条数显示
date: 2017-10-19 16:00:50
tags: [Android]
---

本文代码基于 Android 6.0（高通），原生不支持未接来电以及未读短信的图标右上角数目显示。

涉及到几个文件： 

1. packages/apps/Launcher3/src/com/android/launcher3/Launcher.java
2. packages/apps/Launcher3/src/com/android/launcher3/Utilities.java
3. packages/apps/Launcher3/AndroidManifest.xml 

具体的思路：`Launcher` 中注册 `ContentObserver` 来监听短信和电话数据库，当数据发生变化时，读取读取数据库未读数目之后通过 ICON_NAME ，`重新绘制`短信，电话的图标（在原图右上角画圆和数字）。

-------------------------
具体代码：

#### 1. *Launcher.java*

- 首先是定义两个 ContentObserver

```
private final static int UPDATE_MMS_ICON = 826;  
private final static int UPDATE_CALL_ICON = 1206;

public class SMSContentObserver extends ContentObserver {
    private Handler mHandler;

    public SMSContentObserver(Context context, Handler handler) {
        super(handler);
        mHandler = handler;
    }

    @Override
    public void onChange(boolean selfChange) {
        Log.i("Launcher-","SMSContentObserver onChange");
        mHandler.removeMessages(UPDATE_MMS_ICON);
        Message msg = mHandler.obtainMessage(UPDATE_MMS_ICON);
        msg.obj = getMissMmsCount();
        mHandler.sendMessage(msg);
    }
}

public class CallContentObserver extends ContentObserver {
    private Handler mHandler;
    public CallContentObserver(Context context, Handler handler) {
        super(handler);
        mHandler = handler;
    }

    @Override
    public void onChange(boolean selfChange) {
        Log.i("Launcher-","CallContentObserver onChange");
        mHandler.removeMessages(UPDATE_CALL_ICON);
        Message msg = mHandler.obtainMessage(UPDATE_CALL_ICON);
        msg.obj = getMissCallCount();
        mHandler.sendMessage(msg);
    }
}
```

- 在 onCreate() 中注册 ContentObserver

```
private SMSContentObserver smsContentObserver = null;  
private CallContentObserver callContentObserver = null;  

smsContentObserver = new SMSContentObserver(this,mHandler);
callContentObserver =new CallContentObserver(this,mHandler);

getContentResolver().registerContentObserver(Calls.CONTENT_URI,true,callContentObserver);
getContentResolver().registerContentObserver(Uri.parse("content://mms-sms/"),true,smsContentObserver);
```

- 定义两个 ICON_NAME

```
// 这两个 ICON_NAME 根据自己实际系统短信和电话页面对应包名填写
private final static String PHONE_ICON_NAME = "com.android.dialer.DialtactsActivity";
private final static String MMS_ICON_NAME = "com.android.messaging.ui.conversationlist.ConversationListActivity";
```

- mHandler 中处理

```
@Thunk
final Handler mHandler = new Handler(new Handler.Callback() {
    @Override
    public boolean handleMessage(Message msg) {
        Log.i("Launcher-","mHandler msg.what = " + msg.what);
        if (msg.what == ADVANCE_MSG) {
            int i = 0;
            for (View key : mWidgetsToAdvance.keySet()) {
                final View v = key.findViewById(mWidgetsToAdvance.get(key).autoAdvanceViewId);
                final int delay = mAdvanceStagger * i;
                if (v instanceof Advanceable) {
                    mHandler.postDelayed(new Runnable() {
                        public void run() {
                            ((Advanceable) v).advance();
                        }
                    }, delay);
                }
                i++;
            }
            sendAdvanceMessage(mAdvanceInterval);
        }
        //ADD BY Bruce Yang FOR SHOW UNREAD MMS
        else if (msg.what == UPDATE_MMS_ICON) {
            setMmsOrPhoneNum(MMS_ICON_NAME, getMissMmsCount());
        } else if (msg.what == UPDATE_CALL_ICON) {
            setMmsOrPhoneNum(PHONE_ICON_NAME, getMissCallCount());
        }
        return true;
    }
});
```

- 获取数据库中未读数目

```
 private int getMissMmsCount() {
    Log.i("Launcher-","getMissMmsCount");
    int missSmsCount = 0;
    Cursor cursorSMS = null;
    Cursor cursorMMS = null;
    try {
        cursorSMS = getContentResolver().query(
                Uri.parse("content://sms"), null, "(read=0 and type=1)",
                null, null);
        cursorMMS = getContentResolver().query(
                Uri.parse("content://mms"), null, "(read=0)", null,
                null);
    } catch (SQLiteException e) {
        return missSmsCount;
    }
    if (cursorSMS != null) {
        missSmsCount = cursorSMS.getCount();
        cursorSMS.close();
    }
    if (cursorMMS != null) {
            missSmsCount = missSmsCount + cursorMMS.getCount();
        cursorMMS.close();
    }

    Log.i("Launcher-","getMissMmsCount  missSmsCount = " + missSmsCount);
    return missSmsCount;
}

private int getMissCallCount() {
    Log.i("Launcher-","getMissCallCount");
    int missCallCount = 0;
    Uri missingCallUri = Calls.CONTENT_URI;
    String where = Calls.TYPE + "='" + Calls.MISSED_TYPE + "'"
            + " AND new=1";
    Cursor cursorCall = null;
    try {
        cursorCall = getContentResolver().query(missingCallUri,
                null, where, null, null);
    } catch (SQLiteException e) {
        return missCallCount;
    }

    if (cursorCall != null) {
        missCallCount = cursorCall.getCount();
        cursorCall.close();
    }
    Log.i("Launcher-","getMissCallCount  missCallCount = " + missCallCount);
    return missCallCount;
}
```

- 设置 ICON 未读数

```
/**
    *
    * @param flag 更新电话或短信 ICON
    * @param missCount 未读数
*/
private void setMmsOrPhoneNum(final String flag, final int missCount) {
    Log.i("Launcher-","flag = "+flag +" missCount = "+missCount);
    if(mWorkspace == null) return;
    ArrayList<CellLayout> cellLayouts = mWorkspace.getWorkspaceAndHotseatCellLayouts();
    for (final CellLayout layoutParent: cellLayouts) {
        final ViewGroup shortcutAndWidgetContainer = layoutParent.getShortcutsAndWidgets();

        mWorkspace.post(new Runnable() {
            public void run() {

                int childCount = shortcutAndWidgetContainer.getChildCount();
                for (int j = 0; j <childCount; j++) {
                    View view = shortcutAndWidgetContainer.getChildAt(j);

                    Object tag = view.getTag();
                    if (tag instanceof ShortcutInfo) {
                        final ShortcutInfo info = (ShortcutInfo) tag;
                        final Intent intent = info.intent;

                        if (intent != null) {
                            final ComponentName name = intent.getComponent();
                            if (name != null && name.getClassName().equals(flag)) {
                                BubbleTextView bv = (BubbleTextView) view;
                                Bitmap defaultIconBitmap = Bitmap.createBitmap(info.getIcon(mIconCache));
                                Bitmap bitmap = Utilities.createIconBitmap(defaultIconBitmap, missCount);
                                bv.setCompoundDrawablesWithIntrinsicBounds(null,
                                        new FastBitmapDrawable(bitmap),
                                        null, null);
                            }
                        }
                    }
                }
            }
        });
    }
}
```

- 第一次启动 Launcher 就能获取未读数目，在 finishBindingItems() 添加逻辑

```
//ADD BY Bruce Yang
int missCall = getMissCallCount();
int missMms = getMissMmsCount();
if(missCall != 0) {
    setMmsOrPhoneNum(PHONE_ICON_NAME, missCall);
}
if(missMms != 0) {
    setMmsOrPhoneNum(MMS_ICON_NAME, missMms);
}
```

- 在 onDestroy() 中反注册 ContentObserver

```
getContentResolver().unregisterContentObserver(smsContentObserver);
getContentResolver().unregisterContentObserver(callContentObserver);
```

#### 2. *Utilities.java*

新增构造方法，用于重新绘制带数字的应用图标。

```
//add by Bruce Yang for ...
static Bitmap createIconBitmap(Bitmap b, int count) {
    Bitmap bitmap = b.copy(Bitmap.Config.ARGB_8888,true);
    Log.i("Launcher-","b.isMutable() = "+b.isMutable()); // 如果为 false 就会抛出 java.lang.IllegalStateException 异常， http://bbs.csdn.net/topics/370021698
    if (count == 0) return b;
    int textureWidth = bitmap.getWidth();
    final Canvas canvas = sCanvas;
    Paint paint = new Paint(Paint.ANTI_ALIAS_FLAG | Paint.DEV_KERN_TEXT_FLAG);
    canvas.setBitmap(bitmap);

    paint.setColor(Color.RED);
    canvas.drawCircle(textureWidth - 17-6, 16+6, 16+6, paint);
    paint.setColor(Color.WHITE);
    paint.setStyle(Paint.Style.STROKE);
    paint.setStrokeWidth(2);
    canvas.drawCircle(textureWidth - 17-6, 16+6, 16+6, paint);

    Paint countPaint = new Paint(Paint.ANTI_ALIAS_FLAG | Paint.DEV_KERN_TEXT_FLAG);
    countPaint.setColor(Color.WHITE);
    countPaint.setTextSize(26f);
    countPaint.setTypeface(Typeface.DEFAULT_BOLD);

    float x = textureWidth - 24-4;
    if (count > 9) x -= 4+6;

    if (count > 99) {
        countPaint.setTextSize(22f);
        String text = String.valueOf(99) + "+";
        canvas.drawText(text, x-2, 25+5, countPaint);
    } else {
        String text = String.valueOf(count);
        canvas.drawText(text,x, 25+5, countPaint);
    }
    return bitmap;
}
```

#### 3. *AndroidManifest.xml*

添加如下两个权限，由于 Android 6.0 以上需要动态权限申请，这里为了直接获取权限，可以将 argetSdkVersion 改成 21（原来是 23）。
```
<uses-permission android:name="android.permission.READ_SMS" />
<uses-permission android:name="android.permission.READ_CALL_LOG" />
```

#### 4. 修改对比

> 修改前：

<img src="https://i.loli.net/2017/10/19/59e865f6b26df.png" width="270" height="450"/>

> 修改后：

<img src="https://i.loli.net/2017/10/19/59e86659672b9.png" width="270" height="450"/>


> 参考文章： 

http://blog.csdn.net/chenxiong668/article/details/12851357
http://blog.csdn.net/kerancsdn/article/details/26705767
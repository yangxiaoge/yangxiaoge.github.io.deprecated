---
title: 实现多行多列的RadioButton
date: 2016-08-02 18:21:33
tags: Android
categories: Android
---

>由于最近的项目中多处需要用到多行多列的RadioButton,而google原生的RadioGroup又不能实现!因此就要自己动手实现了~

`注意:`*这里所说的RadioButton都是在代码中动态添加的!*

看下效果图:
![实现多行多列的RadioButton](http://ww2.sinaimg.cn/mw1024/c05ae6b6gw1f6fkjnjio2j20b404ewed.jpg)
<!-- more -->
![行列对齐RadioButton](http://ww1.sinaimg.cn/mw1024/c05ae6b6gw1f6ga5gamz4j20ba047mx3.jpg)

## 开始造轮子: *分为四步*
### 重写RadioGroup-->目的是使 RadioButton可以自动换行
### 布局中引用MyRadioGroupAuto
### 代码中根据数据动态添加RadioButton,然后MyRadioGroup通过`addView`把RadioButton加进去
 - 这里需要讲下RadioButton的`几个属性 `
    - radioButton.setPadding(20, 0, screenWidth / 6, 0);// 设置文字距离按钮图片四周的距离
    - radioButton.setButtonDrawable(R.drawable.transfer_radiobutton_drawable); //点击效果
    - radioButton.setTag(loanAndFeeList.get(i)); // 设置tag,可以存一些数据
    - radioButton.setTextSize(13); //默认单位是 sp
    - radioButton.setHeight(50); //默认单位是px
    - RadioButton clickRadioButton = (RadioButton) radioGroup.findViewById(checkedId); //通过RadioGroup对象获取点击的RadioButton组件
	
### 设置RadioGroup点击事件


## 下面直接上代码: *三步*

### 自定义MyRadioGroupAuto

```
/**
 * Author: 0027008122 [yang.jianan@zte.com.cn]
 * Time: 2016-08-02 11:33
 * Version: 1.0
 * TaskId:
 * Description:
 */
 public class MyRadioGroupAuto extends RadioGroup {
    public MyRadioGroupAuto(Context context) {
        super(context);
    }

    public MyRadioGroupAuto(Context context, AttributeSet attrs) {
        super(context, attrs);
    }

    @Override
    protected void onMeasure(int widthMeasureSpec, int heightMeasureSpec) {
        //获取最大宽度
        int maxWidth = MeasureSpec.getSize(widthMeasureSpec);
        //获取Group中的Child数量
        int childCount = getChildCount();
        //设置Group的左边距，下面也会使用x计算每行所占的宽度
        int x = 0;
        //设置Group的上边距，下面也会使用y计算Group所占的高度
        int y = 30;
        //设置Group的行数
        int row = 0;
        for (int index = 0; index < childCount; index++) {
            final View child = getChildAt(index);
            if (child.getVisibility() != View.GONE) {
                child.measure(MeasureSpec.UNSPECIFIED, MeasureSpec.UNSPECIFIED);
                //重新计算child的宽高
                int width = child.getMeasuredWidth();
                int height = child.getMeasuredHeight();
                //添加到X中，(width+10) 设置child左边距
                x += (width + 10);
                //行数*child高度+这次child高度=现在Group的高度,(height + 10)设置child上边距
                y = row * (height + 10) + (height + 10);
                //当前行宽X大于Group的最大宽度时，进行换行
                if (x > maxWidth) {
                    //当index不为0时，进行row++，防止FirstChild出现大于maxWidth时,提前进行row++
                    if (index != 0)
                        row++;
                    //child的width大于maxWidth时，重新设置child的width为最大宽度
                    if (width >= maxWidth) {
                        width = maxWidth - 30;
                    }
                    //重新设置当前X
                    x = (width + 20);
                    //重新设置现在Group的高度
                    y = row * (height + 10) + (height + 10);
                }
            }
        }
        // 设置容器所需的宽度和高度
        setMeasuredDimension(maxWidth, y);
    }


    @Override
    protected void onLayout(boolean changed, int l, int t, int r, int b) {
        final int childCount = getChildCount();
        int maxWidth = r - l;
        int x = 10;
        int y = 0;
        int row = 0;
        for (int i = 0; i < childCount; i++) {
            final View child = this.getChildAt(i);
            if (child.getVisibility() != View.GONE) {
                int width = child.getMeasuredWidth();
                int height = child.getMeasuredHeight();
                x += (width + 10);
                y = row * (height + 10) + (height + 10);
                if (x > maxWidth) {
                    if (i != 0)
                        row++;
                    if (width >= maxWidth) {
                        width = maxWidth - 30;
                    }
                    x = (width + 20);
                    y = row * (height + 10) + (height + 10);
                }
                child.layout(x - width, y - height, x, y);
            }
        }
    }
}

```

### 布局中引用MyRadioGroupAuto

```
<com.ztesoft.zsmart.datamall.app.widget.MyRadioGroupAuto
        android:id="@+id/my_radio_group_auto"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_marginBottom="33dp"
        android:layout_marginLeft="22dp"
        android:layout_marginRight="22dp"
        android:layout_marginTop="16dp">
</com.ztesoft.zsmart.datamall.app.widget.MyRadioGroupAuto>
```

### 代码中动态添加RadioButton

```
public class CheckboxRadiobuttonDemo extends Activity {
    /**
     * Called when the activity is first created.
     */
    private RadioGroupAuto rgp;
    private RadioGroup yuansheng;

    private String[] loanList;
    private String[] loanFeeList;
    private List<String> loanAndFeeList;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

        //获取屏幕信息
        DisplayMetrics dm = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        int screenWidth = dm.widthPixels;

        loanAndFeeList = new ArrayList<>();
        loanList = "800,1000,1600,200,300,500,700".split(",");
        loanFeeList = "50,80,100,20,30,50,70".split(",");
		
		//求最大最小值 (为了保持RadioButton文字长度一致,跟最长的保持一致!)
        int max = Integer.parseInt(loanList[0]);
        int min = Integer.parseInt(loanList[0]);
        for (String i : loanList) {
            int j = Integer.parseInt(i);
            max = max > j ? max : j;
            min = min < j ? min : j;
        }
        
        String maxS = String.valueOf(max);
        int maxLen = maxS.length();

        for (int i = 0; i < loanList.length; i++) {
            loanAndFeeList.add( loanList[i] + "," + loanFeeList[i]);
        }


        rgp = (RadioGroupAuto) findViewById(R.id.RadioGroup01);

        int len = loanAndFeeList.size();

        for (int j = 0; j < len; j++) {

            RadioButton radioButton = new RadioButton(this);
            radioButton.setPadding(20, 0, screenWidth / 6, 0); // 设置文字距离按钮四周的距离
            radioButton.setButtonDrawable(R.drawable.transfer_radiobutton_drawable);

            String newLoanList = loanList[j];
            if (loanList[j].length() < maxLen) {
                newLoanList = newLoanList + appendLength(maxLen - loanList[j].length());

                // 实现 TextView同时显示两种风格文字 http://txlong-onz.iteye.com/blog/1142781
                SpannableStringBuilder sb = new SpannableStringBuilder(newLoanList);
                final ForegroundColorSpan fcs = new ForegroundColorSpan(Color.WHITE);
                sb.setSpan(fcs, loanList[j].length(), maxLen, Spannable.SPAN_INCLUSIVE_INCLUSIVE);
                radioButton.setText(sb);
            } else {
                newLoanList = loanList[j];
                radioButton.setText(newLoanList);
            }
			
			radioButton.setId(j); //设置RadioButton的id
            radioButton.setTag(loanAndFeeList.get(j));
            radioButton.setTextSize(13); //默认单位是 sp
            radioButton.setHeight(50); //默认单位是px
            rgp.addView(radioButton); //添加到RadioGroup中

        }

        rgp.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {

            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                RadioButton clickRadioButton = (RadioButton) group.findViewById(checkedId);

                String tipInfo = "id: " + clickRadioButton.getId() + " text: " + clickRadioButton.getText() +
                        /*"hint: " + clickRadioButton.getHint() +*/ " tag:" + clickRadioButton.getTag();
                System.out.println(tipInfo);

                Toast.makeText(CheckboxRadiobuttonDemo.this, tipInfo,
                        Toast.LENGTH_SHORT).show();
            }
        });
		
		//根据这个来设置默认选中的项, 注意,这个要设置在监听之后!,否则默认点击监听不到!虽然有选中效果
        //参考 http://blog.csdn.net/lzqjfly/article/details/16963645
        //以及http://stackoverflow.com/questions/9175635/how-to-set-radio-button-checked-as-default-in-radiogroup-with-android
        rgp.check(0);
    }

    /**
     * 补全长度,保持最长的长度
     *
     * @param count 字符串长度
     * @return 补全后的长度
     * 这里长度不够的就用 "s" 占位, 赋值的时候将字体设置白色!
     */
    public String appendLength(int count) {
        String st = "";
        if (count < 0) {
            count = 0;
        }
        for (int i = 0; i < count; i++) {
            st = st + "s";
        }
        return st;
    }
}
```

## 总结:
碰到的问题: RadioGroup中RadioButton不能互斥
解决方法: 需要用`RadioGroup.check(id)`,来设置被默认选中的项，其中id为RadioButton的id，如果`动态添加的RadioButton`，需要设置好`id`
参考:http://blog.csdn.net/lzqjfly/article/details/16963645 , http://stackoverflow.com/questions/9175635/how-to-set-radio-button-checked-as-default-in-radiogroup-with-android
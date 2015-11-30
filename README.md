# RRCircleProgressBar
圆形进度条

* version 0.0.1    
初始版本。

##Requirements【系统要求】
- iOS >= 7.0
- ARC


## <a id="Installation"></a> Installation【安装】

### From CocoaPods【使用CocoaPods】

```ruby
pod 'RRCircleProgressBar'
```


## <a id="How to use"></a> How to use【使用方法】

```objective-c
//进度条数值(0~1.0)
@property (nonatomic) CGFloat progressValue;

//进度条颜色(默认orangeColor)
@property (nonatomic, strong) UIColor *progressBarColor;

//进度条背景色(默认lightGrayColor)
@property (nonatomic, strong) UIColor *progressBarBackgroundColor;

//进度条宽度(默认9.0)
@property (nonatomic) CGFloat progressWidth;

//设置百分比数字字体大小(默认30)
@property (nonatomic) NSInteger percentageLabelSize;

//百分比数字体颜色(默认orangeColor)
@property (nonatomic, strong) UIColor *percentageTextColor;

//百分比数字是否隐藏
@property (nonatomic) BOOL percentageTextHidden;

//百分比数字是否显示2位小数
@property (nonatomic) BOOL percentageTextIsFloat;

//年化收益百分比数字
@property (nonatomic,copy) NSString *incomeString;

//标题内容
@property (nonatomic, copy) NSString *titleString;

//多少起投
@property (nonatomic, copy) NSString *moneyString;

//期限时间
@property (nonatomic, copy) NSString *timeString;

//设置进度条数值和是否动画
- (void)setProgressValue:(CGFloat)progressValue animated:(BOOL)animated;

//设置进度条的开始和结束数值
- (void)setProgressValue:(CGFloat)progressValue animatedFromProgressValue:(CGFloat)startProgressValue;

//如果设置了incomeString、titleString、moneyString、timeString属性必须调用此方法
- (void)refreshCircularProgress;

```


### <a id="Examples"></a> Examples

####【示例一】
```objective-c
    CircularProgressView *cir = [[CircularProgressView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    [cir setProgressValue:0.67 animated:YES];
    cir.progressWidth = 10;
    [self.view addSubview:cir];
```

![image](https://github.com/EmotionV/RRCircleProgressBar/blob/master/screenshots/example1.png)


####【示例二】
```objective-c
    CircularProgressView *cir = [[CircularProgressView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    [cir setProgressValue:0.89 animated:YES];
    cir.progressWidth = 10;
    cir.percentageTextHidden = YES; //隐藏进度条百分比数字
    cir.titleString = @"车金融Y137444";
    cir.moneyString = @"#1000元#起投";  //#...#之间的字会改变颜色
    cir.timeString = @"期限#12#个月";
    cir.incomeString = @"13.40%"; //添加年化收益
    [cir refreshCircularProgress];  //设置了incomeString、titleString、moneyString、timeString属性必须调用此方法
    [self.view addSubview:cir];
```

![image](https://github.com/EmotionV/RRCircleProgressBar/blob/master/screenshots/example2.png)


## Contact 联系方式
* Mteam:[仁润科技](http://www.renrunkeji.com)

## 基于上述版本修改
https://github.com/mangofever/CircularProgressView


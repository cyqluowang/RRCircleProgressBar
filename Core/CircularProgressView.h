//
//  CircularProgressView.h
//  CircularProgressViewSample
//
//  Created by Mangofever on 2015. 3. 12..
//  Copyright (c) 2015 FFF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgressUpdator.h"

@interface CircularProgressView : UIView <ProgressUpdatorDelegate>

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

@property (nonatomic) CGFloat animatedDeltaSize;

//设置完titleString、moneyString、timeString调用此方法
- (void)refreshCircularProgress;

//设置进度条数值和是否动画
- (void)setProgressValue:(CGFloat)progressValue animated:(BOOL)animated;


- (void)setProgressValue:(CGFloat)progressValue animatedFromProgressValue:(CGFloat)startProgressValue;

@end

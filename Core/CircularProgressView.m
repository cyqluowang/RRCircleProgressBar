//
//  CircularProgressView.m
//  CircularProgressViewSample
//
//  Created by Mangofever on 2015. 3. 12..
//  Copyright (c) 2015 FFF. All rights reserved.
//

#import "CircularProgressView.h"

#define DefaultProgressValue 0.0
#define DefaultProgressWidth 9.0
#define DefaultProgressBarColor [UIColor orangeColor]
#define DefaultProgressBarBackgroundColor [UIColor lightGrayColor]
#define DefaultPercentageTextColor [UIColor orangeColor]
#define DefaultPercentageTextSize  40
#define InsideViewWide (self.cirProgress.size.width / 2.0 - self.progressWidth) * 1.30

@interface CircularProgressView ()

@property (nonatomic, strong) UILabel *percentageLabel;

@property (nonatomic, strong) ProgressUpdator *progressUpdator;

@property (nonatomic) CGRect cirProgress;

@end

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame
{
    _cirProgress = frame;
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (void)internalInit {
    
    self.backgroundColor = [UIColor clearColor];
    self.progressBarColor = DefaultProgressBarColor;
    self.progressBarBackgroundColor = DefaultProgressBarBackgroundColor;
    self.progressWidth = DefaultProgressWidth;
    self.progressValue = DefaultProgressValue;
    self.percentageTextColor = DefaultPercentageTextColor;
    self.percentageTextHidden = NO;
    self.percentageLabelSize = DefaultPercentageTextSize;
    self.percentageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.percentageLabel.backgroundColor = [UIColor clearColor];
    self.percentageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.percentageLabel];
    self.progressUpdator = [[ProgressUpdator alloc] init];
    self.progressUpdator.delegate = self;

}

- (void)refreshCircularProgress
{
    
    UIView *insideView1 = [[UIView alloc] initWithFrame:CGRectMake(( self.cirProgress.size.height -  InsideViewWide ) / 2, ( self.cirProgress.size.height -  InsideViewWide ) / 2, InsideViewWide, InsideViewWide / 3)];
    insideView1.backgroundColor = [UIColor clearColor];
    [self addSubview:insideView1];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake( 0,0, insideView1.frame.size.width,  insideView1.frame.size.height) ];
    lab1.text = self.titleString;
    lab1.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    lab1.numberOfLines = 0;
    lab1.lineBreakMode = NSLineBreakByWordWrapping;
    lab1.textAlignment = NSTextAlignmentCenter;
    [insideView1 addSubview:lab1];
    
    UIView *insideView2 = [[UIView alloc] initWithFrame:CGRectMake(( self.cirProgress.size.height -  InsideViewWide ) / 2 - 5, self.cirProgress.size.width - ( self.cirProgress.size.height -  InsideViewWide ) , InsideViewWide + 10, InsideViewWide / 3)];
    [self addSubview:insideView2];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake( 0,0, insideView2.frame.size.width, insideView2.frame.size.height / 2 )];
    lab2.text = @"年化收益";
    lab2.textColor = [UIColor lightGrayColor];
    lab2.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lab2.textAlignment = NSTextAlignmentCenter;
    [insideView2 addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake( 0, insideView2.frame.size.height / 2,  insideView2.frame.size.width / 2 , insideView2.frame.size.height / 2 )];
    
    NSArray *array1 = [self changeStringColor:self.timeString];
    
    NSString *s1 = [self.timeString stringByReplacingOccurrencesOfString:@"#" withString:@""];

    NSMutableAttributedString *attriString1 = [[NSMutableAttributedString alloc] initWithString:s1];
    [attriString1 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange([array1[0] intValue]  ,[[array1 lastObject] intValue] - 1)];
    lab3.attributedText = attriString1;
    lab3.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lab3.textAlignment = NSTextAlignmentLeft;
    [insideView2 addSubview:lab3];
    
    
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake( insideView2.frame.size.width / 2 , insideView2.frame.size.height / 2,  insideView2.frame.size.width / 2 , insideView2.frame.size.height / 2 )];
    
    NSArray *array2 = [self changeStringColor:self.moneyString];

    NSString *s2 = [self.moneyString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    NSMutableAttributedString *attriString2 = [[NSMutableAttributedString alloc] initWithString:s2];
    [attriString2 addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange([array2[0] intValue] ,[[array2 lastObject] intValue] - 1)];
    lab4.attributedText = attriString2;

    lab4.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    lab4.textAlignment = NSTextAlignmentRight;
    [insideView2 addSubview:lab4];
    
    UILabel *incomeLab = [[UILabel alloc] initWithFrame:CGRectMake(( self.cirProgress.size.height -  InsideViewWide ) / 2 - 10, ( self.cirProgress.size.height -  InsideViewWide ) , InsideViewWide + 20, InsideViewWide / 3)];
    incomeLab.text = self.incomeString;
    incomeLab.textColor = [UIColor orangeColor];
    incomeLab.textAlignment = NSTextAlignmentCenter;
    incomeLab.font = [UIFont fontWithName:@"HelveticaNeue" size:38];
    [self addSubview:incomeLab];
    
}

- (NSArray *)changeStringColor:(NSString *)string
{
    unichar s;
    int x = 0;
    NSMutableArray *array = [NSMutableArray array];
    for (int i; i < string.length; i++) {
        s = [string characterAtIndex:i];
        NSString *str = [NSString stringWithCharacters:&s length:1];
        if ([str isEqualToString:@"#"]) {
            x = i - x;
            [array addObject:[NSString stringWithFormat:@"%d",x]];
       }
    }
    return array;
}

- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [self.progressBarBackgroundColor CGColor]);
    CGContextSetLineWidth(ctx, self.progressWidth);
    CGContextAddArc(ctx, center.x, center.y, self.frame.size.width / 2.0 - self.progressWidth, 0, 2*(float)M_PI, 0);

    CGContextStrokePath(ctx);
    
    CGContextBeginPath(ctx);
    CGContextSetStrokeColorWithColor(ctx, [self.progressBarColor CGColor]);
    CGContextSetLineWidth(ctx, self.progressWidth);
    CGContextAddArc(ctx, center.x, center.y, self.frame.size.width / 2.0 - self.progressWidth, -0.5*(float)M_PI, MIN(2*self.progressValue-0.5, 2)*(float)M_PI, 0);
    CGContextStrokePath(ctx);
    
    [self refreshCurrentPercentageText];
}

- (void)setProgressValue:(CGFloat)progressValue animated:(BOOL)animated {
    if (self.progressValue != progressValue) {
        if (animated) {
            [self.progressUpdator scheduleUpdateFromProgress:self.progressValue toProgress:progressValue];
        } else {
            self.progressValue = progressValue;
        }
    }
}

- (void)setProgressValue:(CGFloat)progressValue animatedFromProgressValue:(CGFloat)startProgressValue {
    self.progressValue = startProgressValue;
    if (progressValue != startProgressValue) {
        [self.progressUpdator scheduleUpdateFromProgress:self.progressValue toProgress:progressValue];
    }
}

#pragma mark - Overriding Setters/Getters

- (void)setIncomeString:(NSString *)incomeString
{
    _incomeString = incomeString;
    [self setNeedsDisplay];
}

- (void)setProgressBarColor:(UIColor *)progressBarColor {
    _progressBarColor = progressBarColor;
    [self setNeedsDisplay];
}

- (void)setProgressBarBackgroundColor:(UIColor *)progressBarBackgroundColor {
    _progressBarBackgroundColor = progressBarBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setPercentageLabelSize:(NSInteger)percentageLabelSize{
    _percentageLabelSize = percentageLabelSize;
    [self setNeedsDisplay];
}


- (void)setProgressValue:(CGFloat)progressValue {
    _progressValue = progressValue;
    [self setNeedsDisplay];
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    [self setNeedsDisplay];
}

- (void)setPercentageTextHidden:(BOOL)percentageStringHidden {
    self.percentageLabel.hidden = percentageStringHidden;
}

- (BOOL)percentageTextHidden {
    return self.percentageLabel.hidden;
}

- (void)setAnimatedDeltaSize:(CGFloat)animatedDeltaSize {
    self.progressUpdator.deltaSize = animatedDeltaSize;
}

- (CGFloat)animatedDeltaSize {
    return self.progressUpdator.deltaSize;
}

#pragma mark - ProgressAnimatorDelegate
- (void)progressUpdator:(ProgressUpdator *)progressUpdator didUpdateProgress:(double)progress {
    self.progressValue = progress;
}

#pragma mark - Percentage String

- (void)refreshCurrentPercentageText {

    NSString *percentageString;
    
    if (self.percentageTextIsFloat) {
        
       float percentage = self.progressValue * 100;
       percentageString = [NSString stringWithFormat:@"%.2f%%",percentage];

    }else{
        
      NSInteger percentage = self.progressValue * 100;
      percentageString = [NSString stringWithFormat:@"%ld%%",(long)percentage];

    }

    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:percentageString];
    
    [attString addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"HelveticaNeue" size:self.percentageLabelSize]
                      range:NSMakeRange(percentageString.length-1, 1)];
    [attString addAttribute:NSForegroundColorAttributeName
                      value:self.percentageTextColor
                      range:NSMakeRange(0, percentageString.length)];

    self.percentageLabel.attributedText = attString;
    
    self.percentageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:self.percentageLabelSize];

    [self.percentageLabel sizeToFit];
    
    self.percentageLabel.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
}

@end

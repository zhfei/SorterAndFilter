//
//  Utitly.m
//  SorterAndFilter
//
//  Created by zhoufei on 16/8/4.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import "Utitly.h"

@implementation Utitly

+(void)addTopSinglePixLine:(CGFloat)width toView:(UIView *)view
{
    [self addCustomLayerSinglePixLineWithRect:CGRectMake(0, 0, width, 1.0/[[UIScreen mainScreen] scale]) toView:view];
}

+(void)addBottomSinglePixLine:(CGFloat)width toView:(UIView *)view
{
    CGFloat heigh=1.0/[[UIScreen mainScreen] scale];
    [self addCustomLayerSinglePixLineWithRect:CGRectMake(0, view.bounds.size.height-heigh, width, heigh) toView:view];
}

+(void)addCustomLayerSinglePixLineWithRect:(CGRect)rect toView:(UIView *)view
{
    UIBezierPath *bezier =[UIBezierPath bezierPathWithRect:rect];
    CAShapeLayer *layer =[CAShapeLayer layer];
    layer.path=bezier.CGPath;
    layer.fillColor=[UIColor blackColor].CGColor;
    
    [view.layer addSublayer:layer];
}


+ (CGFloat)screenScale {
    static CGFloat screenScale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            screenScale = [[UIScreen mainScreen] scale];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                screenScale = [[UIScreen mainScreen] scale];
            });
        }
    });
    return screenScale;
}


+ (CGFloat)KScreenW
{
   return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)KScreenH
{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (UIButton *)defaultBtn
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBounds:CGRectMake(0, 0, 100, 44)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    btn.layer.cornerRadius=3;
    btn.layer.borderColor=[UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth=1.f;
    btn.layer.masksToBounds=YES;
    
    
    return btn;
}


//计算子规划选项名称长度
+ (CGSize)calculateWidthWithHeihgt:(CGFloat)height Font:(CGFloat)font textString:(NSString *)textString itemHeigh:(CGFloat)itemHeigh
{
    CGSize size = CGSizeMake(0, height);
    CGSize tempSize;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    tempSize = [textString boundingRectWithSize:size options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    if (tempSize.width<60) {
        tempSize.width=60;
    }
    tempSize.width +=20;
    tempSize.height = itemHeigh;
    
    return tempSize;
}

@end

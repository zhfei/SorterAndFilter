//
//  Utitly.h
//  SorterAndFilter
//
//  Created by zhoufei on 16/8/4.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Utitly : NSObject

/*!
 *  @author zhoufei
 *
 *  @brief 顶部添加一根1像素的分割线
 *  @param width 分割线宽度
 */
+(void)addTopSinglePixLine:(CGFloat)width toView:(UIView *)view;

/*!
 *  @author zhoufei
 *
 *  @brief 低部添加一根1像素的分割线
 *  @param width 分割线宽度
 */
+(void)addBottomSinglePixLine:(CGFloat)width toView:(UIView *)view;
/*!
 *  @author zhoufei
 *
 *  @brief 自定义在view的图层上添加一像素的线
 *  @param rect 线的rect
 */
+ (void)addCustomLayerSinglePixLineWithRect:(CGRect)rect toView:(UIView *)view;


+ (CGFloat)screenScale ;


+ (CGFloat)KScreenW;

+ (CGFloat)KScreenH;


+ (UIButton*)defaultBtn;

//计算子规划选项名称长度
+ (CGSize)calculateWidthWithHeihgt:(CGFloat)height Font:(CGFloat)font textString:(NSString *)textString itemHeigh:(CGFloat)itemHeigh;

@end

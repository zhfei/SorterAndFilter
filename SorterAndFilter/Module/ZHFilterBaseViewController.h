//
//  ZHFilterBaseViewController.h
//  SorterAndFilter
//
//  Created by 周飞 on 2019/11/12.
//  Copyright © 2019年 zhoufei. All rights reserved.
//
//  定义筛选列表的基类，基类只是单纯的公共功能提取，并不实现筛选协议
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHFilterBaseViewController : UIViewController
/**
 点击灰色蒙层
 */
- (void)tapGrayCoverView;

@end

NS_ASSUME_NONNULL_END

//
//  SorterTableViewController.h
//  SorterAndFilter
//
//  Created by zhoufei on 16/8/4.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SorterTableViewController : UIViewController
@property (assign,nonatomic) CGRect      viewBounds;
//蒙板点击block
@property (copy,nonatomic)void(^hideBlock)();

/*!
 *  @author zhoufei
 *
 *  @brief 隐藏视图
 */
- (void)coverViewHide;
@end

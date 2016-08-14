//
//  SpecCollectionCell.h
//  SorterAndFilter
//
//  Created by zhoufei on 16/2/18.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import <UIKit/UIKit.h>


//规格item状态
typedef enum : NSUInteger {
    SepcStateNormal,    //普通状态
    SepcStateSelected,  //选中状态
    SepcStateUnable,    //不可用状态
} SepcState;

@interface SpecCollectionCell : UICollectionViewCell

- (void)updateItemState:(SepcState)sepcState;

@property (strong,nonatomic)NSString*contentText;

@end

//
//  ZHFilterTwoTableController.h
//  SorterAndFilter
//
//  Created by 周飞 on 2019/11/12.
//  Copyright © 2019年 zhoufei. All rights reserved.
//

#import "ZHFilterBaseViewController.h"
#import "ZHFilterProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZHFilterTwoTableController : ZHFilterBaseViewController <ZHFilterProtocol>
@property (weak, nonatomic) id<ZHFilterDelegateProtocol> delegate;

@end

NS_ASSUME_NONNULL_END

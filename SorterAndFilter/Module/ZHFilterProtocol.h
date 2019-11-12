//
//  ZHFilterProtocol.h
//  SorterAndFilter
//
//  Created by 周飞 on 2019/11/12.
//  Copyright © 2019年 zhoufei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ZHFilterHideBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@protocol ZHFilterProtocol <NSObject>
@required
@property (copy,nonatomic) ZHFilterHideBlock hideBlock;
@property (assign,nonatomic) CGRect  contentBounds;


@optional
//隐藏视图
- (void)coverViewHide;

@end

NS_ASSUME_NONNULL_END

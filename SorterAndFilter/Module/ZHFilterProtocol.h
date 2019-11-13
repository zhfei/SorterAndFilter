//
//  ZHFilterProtocol.h
//  SorterAndFilter
//
//  Created by 周飞 on 2019/11/12.
//  Copyright © 2019年 zhoufei. All rights reserved.
//
//  定义一套筛选接口，只需遵守筛选暴露的接口，就可以随意扩展，
//  只关心暴露接口的功能完整，内部实现无需关心。
//

#import <Foundation/Foundation.h>

typedef void(^ZHFilterHideBlock)(void);

NS_ASSUME_NONNULL_BEGIN
#pragma mark - 各类筛选列表对外暴露的属性/接口
@protocol ZHFilterProtocol <NSObject>
//MARK: 对外属性
@required
@property (copy,   nonatomic) ZHFilterHideBlock hideFilterListBlock; //隐藏筛选列表时回调
@property (assign, nonatomic) CGRect  filterListSize; //筛选列表size

//MARK: 对外接口
@optional
- (void)updateWithDataSource:(NSArray *)dataSource;

@end



#pragma mark - 各类筛选列表的代理需要遵守的协议
@protocol ZHFilterDelegateProtocol <NSObject>
@optional
/**
 筛选列表结果回调
 @param filterVC 当前筛选控制器
 @param table0IndexPath table0选中项
 @param table1IndexPath table1选中项
 */
- (void)filterListVC:(UIViewController<ZHFilterProtocol> *)filterVC didSelectInFirstTable:(NSIndexPath *)table0IndexPath secondTable:(NSIndexPath *)table1IndexPath;

@end


NS_ASSUME_NONNULL_END

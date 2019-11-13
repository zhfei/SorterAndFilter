//
//  ZHFilterBaseViewController.m
//  SorterAndFilter
//
//  Created by 周飞 on 2019/11/12.
//  Copyright © 2019年 zhoufei. All rights reserved.
//

#import "ZHFilterBaseViewController.h"
#import <Masonry/Masonry.h>

@interface ZHFilterBaseViewController ()

@end

@implementation ZHFilterBaseViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *gray = [UIView new];
    gray.backgroundColor = [UIColor blackColor];
    gray.alpha = 0.5;
    [self.view insertSubview:gray atIndex:0];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGrayCoverView)];
    [gray addGestureRecognizer:tap];
}

#pragma mark - Private Method
- (void)tapGrayCoverView {

}

#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject



@end

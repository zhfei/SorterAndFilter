//
//  ZHFilterBaseViewController.m
//  SorterAndFilter
//
//  Created by 周飞 on 2019/11/12.
//  Copyright © 2019年 zhoufei. All rights reserved.
//

#import "ZHFilterBaseViewController.h"

@interface ZHFilterBaseViewController ()

@end

@implementation ZHFilterBaseViewController
@synthesize contentBounds,hideBlock;
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewHide)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Private Method
//隐藏视图
- (void)coverViewHide {
    if (self.hideBlock) {
        self.hideBlock();
    }
}

#pragma mark - Public Method

#pragma mark - Event

#pragma mark - Delegate

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject



@end

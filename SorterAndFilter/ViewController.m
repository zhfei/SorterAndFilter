//
//  ViewController.m
//  SorterAndFilter
//
//  Created by zhoufei on 16/8/4.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import "ViewController.h"
#import "SorterTableViewController.h"
#import "FilterCollectionViewController.h"
#import "Utitly.h"
#import <Masonry.h>

@interface ViewController ()
@property (strong,nonatomic)UIView *contentView;

@property (strong,nonatomic) FilterCollectionViewController *filter;
@property (strong,nonatomic) SorterTableViewController *sorter;

@property (strong,nonatomic) UIButton *leftBtn;
@property (strong,nonatomic) UIButton *rightBtn;


@property (strong,nonatomic) UIViewController *currentVC;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //添加内容视图
    [self addContentViews];
    
    //添加内容控制器
    [self addContentControllers];
    
    //点击事件
    [self btnClick:self.leftBtn];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 *  @author zhoufei
 *
 *  @brief 添加内容视图
 */
- (void)addContentViews
{
    UIView *view =[UIView new];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    self.contentView=view;
    
    [Utitly addTopSinglePixLine:[Utitly KScreenW] toView:view];
    
    //排序按钮
    UIButton *leftBtn =[Utitly defaultBtn];
    [leftBtn setTitle:@"排序" forState:UIControlStateNormal];
    leftBtn.tag=100;
    [leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:leftBtn];
    [leftBtn setFrame:CGRectMake(20, 0.5, 100, 44)];
    self.leftBtn=leftBtn;
    
    //筛选按钮
    UIButton *rightBtn =[Utitly defaultBtn];
    [rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    rightBtn.tag=101;
    [rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:rightBtn];
    [rightBtn setFrame:CGRectMake([Utitly KScreenW]-120, 0.5, 100, 44)];
    self.rightBtn=rightBtn;

}
/*!
 *  @author zhoufei
 *
 *  @brief 添加内容控制器
 */
- (void)addContentControllers
{
    
    __weak typeof(self)weakSelf=self;
    //过滤控制器
    FilterCollectionViewController *filter =[[FilterCollectionViewController alloc]init];
    filter.viewBounds=CGRectMake(0, CGRectGetMaxY(self.leftBtn.frame), [Utitly KScreenW], [Utitly KScreenH]-CGRectGetMaxY(self.leftBtn.frame));
    filter.hideBlock=^{
        weakSelf.rightBtn.selected=NO;
    };
    [filter.view setFrame:filter.viewBounds];
    self.filter=filter;
    
    //排序控制器
    SorterTableViewController *sorter =[[SorterTableViewController alloc]init];
    sorter.viewBounds=CGRectMake(0, CGRectGetMaxY(self.leftBtn.frame), [Utitly KScreenW], [Utitly KScreenH]-CGRectGetMaxY(self.leftBtn.frame));
    [sorter.view setFrame:sorter.viewBounds];
    sorter.hideBlock=^{
        weakSelf.leftBtn.selected=NO;
    };
    self.sorter=sorter;

}

/*!
 *  @author zhoufei
 *
 *  @brief 展现蒙板视图
 *  @param vc 视图控制器
 */
- (void)showSelectingViewWithVC:(UIViewController *)vc
{
    [self addChildViewController:vc];
    [self.contentView addSubview:vc.view];
}

/*!
 *  @author zhoufei
 *
 *  @brief 隐藏蒙板视图
 *  @param vc 视图控制器
 */
- (void)hideSelectingViewWithVC:(UIViewController *)vc
{
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}



- (void)btnClick:(UIButton *)btn
{
    if (btn==self.leftBtn) {
        [self hideSelectingViewWithVC:self.filter];
        [self showSelectingViewWithVC:self.sorter];
        
        self.rightBtn.selected=NO;
        self.leftBtn.selected=!self.leftBtn.selected;
        
        if (!self.leftBtn.selected) {
            [self.sorter coverViewHide];
        }
    }else{
        [self hideSelectingViewWithVC:self.sorter];
        [self showSelectingViewWithVC:self.filter];
        
        self.leftBtn.selected=NO;
        self.rightBtn.selected=!self.rightBtn.selected;
        
        if (!self.rightBtn.selected) {
            [self.filter coverViewHide];
        }
    }
}



@end

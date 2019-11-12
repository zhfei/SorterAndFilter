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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [Utitly addCustomLayerSinglePixLineWithRect:CGRectMake(CGRectGetMaxX(self.leftBtn.frame)-0.5, 0, 0.5, CGRectGetMaxY(self.leftBtn.frame)) toView:self.leftBtn];
    [Utitly addBottomSinglePixLine:CGRectGetMaxX(self.leftBtn.frame) toView:self.leftBtn];
    [Utitly addBottomSinglePixLine:CGRectGetMaxX(self.rightBtn.frame) toView:self.rightBtn];
    
    CGPoint targetP = [self.leftBtn convertPoint:CGPointMake(0, CGRectGetMaxY(self.leftBtn.frame)) toView:[UIApplication sharedApplication].keyWindow];
    self.filter.viewBounds=CGRectMake(0, targetP.y, [Utitly KScreenW], [Utitly KScreenH]-targetP.y);
    [self.filter.view setFrame:self.filter.viewBounds];
    self.sorter.viewBounds=CGRectMake(0, targetP.y, [Utitly KScreenW], [Utitly KScreenH]-targetP.y);
    [self.sorter.view setFrame:self.sorter.viewBounds];
    //点击事件
    [self btnClick:self.leftBtn];
}

- (void)addContentViews {
    UIView *view =[UIView new];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
    self.contentView=view;
    
    [Utitly addTopSinglePixLine:[Utitly KScreenW] toView:view];
    [self addStackViewContentViews];
}

- (void)addStackViewContentViews {
    UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectZero];
    stack.axis = UILayoutConstraintAxisHorizontal;
    stack.distribution = UIStackViewDistributionFillEqually;//类似于UIImageView中的image填充方式
    stack.spacing = 0;
    stack.alignment = UIStackViewAlignmentFill; //类似于UILabel的text偏移设置
    [self.view addSubview:stack];
    [stack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(40);
    }];
    
    self.leftBtn = [self createBtn:@"排序"];
    _leftBtn.tag=100;
    self.rightBtn = [self createBtn:@"筛选"];
    _rightBtn.tag=101;
    
    [stack addArrangedSubview:_leftBtn];
    [stack addArrangedSubview:_rightBtn];
}

- (UIButton *)createBtn:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setFrame:CGRectMake(0, 0, 100, 50)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//展现蒙板视图
- (void)showSelectingViewWithVC:(UIViewController *)vc {
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    [self.view bringSubviewToFront:vc.view];
}
//隐藏蒙板视图
- (void)hideSelectingViewWithVC:(UIViewController *)vc {
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

- (void)btnClick:(UIButton *)btn {
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

- (FilterCollectionViewController *)filter {
    if (!_filter) {
        __weak typeof(self)weakSelf=self;
        _filter = [[FilterCollectionViewController alloc]init];
        _filter.hideBlock=^{
            weakSelf.rightBtn.selected = NO;
        };
    }
    return _filter;
}

- (SorterTableViewController *)sorter {
    if (!_sorter) {
        __weak typeof(self)weakSelf=self;
        _sorter = [[SorterTableViewController alloc]init];
        _sorter.hideBlock=^{
            weakSelf.leftBtn.selected = NO;
        };
    }
    return _sorter;
}

@end

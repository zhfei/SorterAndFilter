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
#import "ZHFilterTwoTableController.h"
#import "Utitly.h"
#import "ZHFilterProtocol.h"
#import <Masonry.h>

@interface ViewController () <ZHFilterDelegateProtocol>
@property (strong,nonatomic)UIView *contentView;
@property (strong,nonatomic) FilterCollectionViewController *filter;
@property (strong,nonatomic) SorterTableViewController *sorter;
@property (strong,nonatomic) ZHFilterTwoTableController *filterTwoTable;
@property (strong,nonatomic) UIButton *tabBtn0;
@property (strong,nonatomic) UIButton *tabBtn1;
@property (strong,nonatomic) UIButton *tabBtn2;

@property (strong,nonatomic) NSArray<UIViewController *> *filterVCArray;
@property (strong,nonatomic) UIButton *currentFilterBtn;
@property (strong,nonatomic) UIStackView *stack;
@end

@implementation ViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //添加内容视图
    [self addContentViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.stack.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [Utitly addCustomLayerSinglePixLineWithRect:CGRectMake(CGRectGetWidth(obj.frame)-0.5, 0, 0.5, CGRectGetMaxY(obj.frame)) toView:obj];
        [Utitly addBottomSinglePixLine:CGRectGetMaxX(obj.frame) toView:obj];
    }];
    
    CGPoint targetP = [self.tabBtn0 convertPoint:CGPointMake(0, CGRectGetMaxY(self.tabBtn0.frame)) toView:[UIApplication sharedApplication].keyWindow];
    CGRect viewBounds = CGRectMake(0, targetP.y, [Utitly KScreenW], [Utitly KScreenH]-targetP.y);
    self.filter.viewBounds = viewBounds;
    [self.filter.view setFrame:viewBounds];
    self.sorter.viewBounds = viewBounds;
    [self.sorter.view setFrame:viewBounds];
    [self.filterTwoTable.view setFrame:viewBounds];
    [self.filterTwoTable updateWithDataSource:@[@"1",@"1",@"1"]];
}

#pragma mark - Private Method
- (void)addContentViews {
    UIView *view =[UIView new] ;
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
    [self.view addSubview:self.stack];
    [self.stack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(40);
    }];
    
    self.tabBtn0 = [self createBtn:@"排序"];
    _tabBtn0.tag=100;
    self.tabBtn1 = [self createBtn:@"筛选"];
    _tabBtn1.tag=101;
    self.tabBtn2 = [self createBtn:@"双列表"];
    _tabBtn2.tag=102;
    
    [self.stack addArrangedSubview:_tabBtn0];
    [self.stack addArrangedSubview:_tabBtn1];
    [self.stack addArrangedSubview:_tabBtn2];
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

#pragma mark - Public Method

#pragma mark - Event
- (void)btnClick:(UIButton *)btn {
    if (btn == self.currentFilterBtn) {
        btn.selected = !btn.selected;
        NSInteger index = btn.tag%100;
        if (btn.selected) {
            [self showSelectingViewWithVC:self.filterVCArray[index]];
        } else {
            [self hideSelectingViewWithVC:self.filterVCArray[index]];
        }
    } else {
        
        [self hideSelectingViewWithVC:self.filter];
        [self hideSelectingViewWithVC:self.sorter];
        [self hideSelectingViewWithVC:self.filterTwoTable];
        
        self.tabBtn0.selected = NO;
        self.tabBtn1.selected = NO;
        self.tabBtn2.selected = NO;
        
        
        if (btn == self.tabBtn0) {
            [self showSelectingViewWithVC:self.sorter];
            self.tabBtn0.selected = YES;
            
        } else if (btn == self.tabBtn1) {
            [self showSelectingViewWithVC:self.filter];
            self.tabBtn1.selected = YES;
        } else if (btn == self.tabBtn2) {
            [self showSelectingViewWithVC:self.filterTwoTable];
            self.tabBtn2.selected = YES;
        }
    }
    self.currentFilterBtn = btn;
}
#pragma mark - Delegate
- (void)filterListVC:(UIViewController<ZHFilterProtocol> *)filterVC didSelectInFirstTable:(NSIndexPath *)table0IndexPath secondTable:(NSIndexPath *)table1IndexPath {
    NSLog(@"%@",filterVC);
}

#pragma mark - Getter, Setter
- (FilterCollectionViewController *)filter {
    if (!_filter) {
        __weak typeof(self)weakSelf=self;
        _filter = [[FilterCollectionViewController alloc]init];
        _filter.hideBlock=^{
            weakSelf.tabBtn1.selected = NO;
        };
    }
    return _filter;
}

- (SorterTableViewController *)sorter {
    if (!_sorter) {
        __weak typeof(self)weakSelf=self;
        _sorter = [[SorterTableViewController alloc]init];
        _sorter.hideBlock=^{
            weakSelf.tabBtn0.selected = NO;
        };
    }
    return _sorter;
}

- (ZHFilterTwoTableController *)filterTwoTable {
    if (!_filterTwoTable) {
        __weak typeof(self)weakSelf=self;
        _filterTwoTable = [[ZHFilterTwoTableController alloc]init];
        _filterTwoTable.hideFilterListBlock=^{
            weakSelf.tabBtn2.selected = NO;
        };
        _filterTwoTable.delegate = self;
    }
    return _filterTwoTable;
}

- (UIStackView *)stack {
    if (!_stack) {
        _stack = [[UIStackView alloc] initWithFrame:CGRectZero];
        _stack.axis = UILayoutConstraintAxisHorizontal;
        _stack.distribution = UIStackViewDistributionFillEqually;//类似于UIImageView中的image填充方式
        _stack.spacing = 0;
        _stack.alignment = UIStackViewAlignmentFill; //类似于UILabel的text偏移设置
    }
    return _stack;
}

- (NSArray<UIViewController *> *)filterVCArray {
    return @[self.sorter,self.filter,self.filterTwoTable];
}
#pragma mark - NSCopying

#pragma mark - NSObject


@end

//
//  SorterTableViewController.m
//  SorterAndFilter
//
//  Created by zhoufei on 16/8/4.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import "SorterTableViewController.h"
#import <Masonry.h>

const CGFloat rowHeigh=50.f;

@interface SorterTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)NSArray *dataSource;

@property (strong,nonatomic)UITableView *tableView;

@end

@implementation SorterTableViewController
@synthesize filterListSize,hideFilterListBlock;
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.dataSource=@[@"离我最近",@"距离由远到近",@"距离由近到远"];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect frame =self.tableView.frame;
    frame.size.height=[self.dataSource count]*rowHeigh;
    self.tableView.frame=frame;
    
    self.view.backgroundColor=[UIColor clearColor];

}

#pragma mark 私有方法
- (void)tapGrayCoverView {
    if (self.hideFilterListBlock) {
        self.hideFilterListBlock();
    }
    
    CGRect frame =self.tableView.frame;
    frame.size.height=0;
    [UIView animateWithDuration:0.3 animations:^{
        self.tableView.frame=frame;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

#pragma mark 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeigh;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID =@"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text=[self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

@end

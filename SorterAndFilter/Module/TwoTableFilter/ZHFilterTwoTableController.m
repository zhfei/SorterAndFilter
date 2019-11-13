//
//  ZHFilterTwoTableController.m
//  SorterAndFilter
//
//  Created by 周飞 on 2019/11/12.
//  Copyright © 2019年 zhoufei. All rights reserved.
//

#import "ZHFilterTwoTableController.h"
#import <Masonry.h>

static NSString *cellID =@"myCell";

@interface ZHFilterTwoTableController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *leftTable;
@property (weak, nonatomic) IBOutlet UITableView *rightTable;
@property (strong, nonatomic) NSArray *dataSource;

@end


@implementation ZHFilterTwoTableController
@synthesize filterListSize,hideFilterListBlock;
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupData];
}

#pragma mark - Getter, Setter

#pragma mark - Event

#pragma mark - Public Method
- (void)tapGrayCoverView {
    if (self.hideFilterListBlock) {
        self.hideFilterListBlock();
    }
    
    CGRect lFrame =self.leftTable.frame;
    lFrame.size.height=0;
    CGRect rFrame =self.rightTable.frame;
    rFrame.size.height=0;
    [UIView animateWithDuration:0.3 animations:^{
        self.leftTable.frame=lFrame;
        self.rightTable.frame=rFrame;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)updateWithDataSource:(NSArray *)dataSource {
    self.dataSource = dataSource;
    
    
}

#pragma mark - Private Method
- (void)setupUI {
    [self.leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.leftTable.rowHeight = 40;

    [self.rightTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.rightTable.rowHeight = 40;
}

- (void)setupLayout {
    CGRect frame =self.leftTable.frame;
    CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat filterW = widthS/2;
    CGFloat filterH = 300;
    frame.size.height= filterH > 300?300:filterH;
    self.leftTable.frame = CGRectMake(0, 0, filterW, filterH);
    self.rightTable.frame = CGRectMake(filterW, 0, filterW, filterH);
}

- (void)setupData {
    
}

#pragma mark - Delegate
#pragma mark dataSource
//header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}
//footer
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
//cell
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        [self.rightTable reloadData];
    } else {
        if ([self.delegate respondsToSelector:@selector(filterListVC:didSelectInFirstTable:secondTable:)]) {
            [self.delegate filterListVC:self didSelectInFirstTable:[self.leftTable indexPathForSelectedRow] secondTable:[self.rightTable indexPathForSelectedRow]];
        }
    }
}

#pragma mark - NSCopying

#pragma mark - NSObject

@end


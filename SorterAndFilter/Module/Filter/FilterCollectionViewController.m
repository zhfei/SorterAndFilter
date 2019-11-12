//
//  FilterCollectionViewController.m
//  SorterAndFilter
//
//  Created by zhoufei on 16/8/4.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import "FilterCollectionViewController.h"
#import "LeftAlignedFlowLayout.h"
#import <Masonry.h>
#import "SpecCollectionCell.h"
#import "SpecHeader.h"
#import "Utitly.h"

//CollectionView的section距离上、下以及section内部上下的距离
//通过修改下面的参数，可以动态修改CollectionView的高度
static CGFloat const sectionTopMargin    = 10;//组内到顶部距离
static CGFloat const sectionBottomMargin = 20;//组内到底部距离
static CGFloat const sectionMiddleMargin = 20;//组内选项之间的距离距离
static CGFloat const itemHeigh           = 44;//选项高度
static CGFloat const sectionLeftMargin   = 20;//组内到左部距离
static CGFloat const sectionHeaderHeigh   = 40;//组上面的Header高度
//额外增加的高度
static CGFloat const extraHeigh           = 0;//collectionView下面，格外增加的高度


@interface FilterCollectionViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) NSArray     * dataSource;
@property (strong,nonatomic) UICollectionView   * collectionView;

@end

@implementation FilterCollectionViewController

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    NSDictionary *section0=@{@"手机":@[@"全部手机",@"配件",@"手机",@"微外卖"]};
    NSDictionary *section1=@{@"相机":@[@"全部相机",@"数码单反",@"普通相机",@"胶片相机",@"摄像机"]};
    NSDictionary *section2=@{@"电脑":@[@"全部电脑",@"台式机",@"笔记本",@"平板电脑",@"显示器"]};
    self.dataSource=@[section0,section1,section2];
    
    // Register cell classes
    
    LeftAlignedFlowLayout *layout=[[LeftAlignedFlowLayout alloc ] init];
    [layout configLeftAlignedFlowLayoutWithLeftMargin:sectionLeftMargin ItemMargin:sectionMiddleMargin];
    [layout setItemSize:CGSizeMake(80, itemHeigh)];
    [layout setMinimumLineSpacing:sectionMiddleMargin];
    [layout setMinimumInteritemSpacing:sectionMiddleMargin];
    [layout setSectionInset:UIEdgeInsetsMake(sectionTopMargin, sectionLeftMargin,sectionBottomMargin, sectionLeftMargin)];
    
    

    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,[Utitly KScreenW] , 1) collectionViewLayout:layout];
    [self.collectionView registerClass:[SpecCollectionCell class] forCellWithReuseIdentifier:@"SpecCollectionCell"];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView registerClass:[SpecHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SpecHeader"];

    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewHide)];
    [self.view addGestureRecognizer:tap];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect frame =self.collectionView.frame;
    frame.size.height=[self setCollectionViewHeightWithDataSource]+extraHeigh;
    self.collectionView.frame=frame;
    
    self.view.backgroundColor = [UIColor clearColor];
}

#pragma mark 私有方法
/*!
 *  @author zhoufei
 *
 *  @brief 隐藏视图
 */
- (void)coverViewHide
{
    if (self.hideBlock) {
        self.hideBlock();
    }
    
    CGRect frame =self.collectionView.frame;
    frame.size.height=0;
    [UIView animateWithDuration:0.3 animations:^{
        self.collectionView.frame=frame;
        [self.collectionView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}



/*!
 *  @author zhoufei
 *
 *  @brief 根据数据源，计算colletionView的高度
 *
 *  @return colletionView的高度
 */
- (CGFloat)setCollectionViewHeightWithDataSource
{
    CGFloat totalHeigh=0;
    //组头总高度
    totalHeigh +=[self.dataSource count]*sectionHeaderHeigh;
    
    
    for (NSDictionary *dict in self.dataSource) {
        NSArray *sectionDataArray= [[dict allValues] firstObject];
        NSInteger rowNum=[self sectionHeighWithTextArray:sectionDataArray];
        
        totalHeigh +=(sectionTopMargin+sectionBottomMargin+(rowNum-1)*sectionMiddleMargin)+rowNum*itemHeigh;
        
    }
    
    return totalHeigh;
}



/*!
 *  @author zhoufei
 *
 *  @brief 计算一组选择的高度
 *
 *  @param textArray 字符串数组
 *
 *  @return 组高度
 */
- (NSInteger)sectionHeighWithTextArray:(NSArray *)textArray
{
    CGFloat totalWidth=self.viewBounds.size.width;
    NSInteger rowNum=1;
    CGFloat currentWidth=sectionLeftMargin;
    
    for (NSString *text in textArray) {
        CGSize size= [Utitly calculateWidthWithHeihgt:40 Font:16 textString:text itemHeigh:itemHeigh];
        if (currentWidth+sectionMiddleMargin+size.width+sectionLeftMargin>totalWidth) {
            rowNum+=1;
            currentWidth=sectionLeftMargin+size.width;
        }else{
            if (currentWidth<=sectionLeftMargin) {
                currentWidth+=size.width;
            }else{
                currentWidth+=(sectionMiddleMargin+size.width);
            }
        }
        
    }
    return rowNum;
}



#pragma mark --UICollectionView数据源
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[[self.dataSource objectAtIndex:section] allValues] firstObject] count];
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataSource count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SpecCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SpecCollectionCell" forIndexPath:indexPath];
    
    [cell setBackgroundColor:[UIColor lightGrayColor]];
    
    NSArray *array= [[[self.dataSource objectAtIndex:indexPath.section] allValues] firstObject];
    cell.contentText=array[indexPath.row];
    // Configure the cell
    
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuserId=@"";
    //
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuserId=@"SpecHeader";
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
    }
    
    SpecHeader *reuseView =(SpecHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuserId forIndexPath:indexPath];
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        id dict =[self.dataSource objectAtIndex:indexPath.section];
        [reuseView setHeaderTitle:[[dict allKeys] firstObject]];
        
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        
    }
    
    return reuseView;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, sectionHeaderHeigh);
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array=[[[self.dataSource objectAtIndex:indexPath.section] allValues] firstObject];
    
    
    return [Utitly calculateWidthWithHeihgt:40 Font:16 textString:[array objectAtIndex:indexPath.row] itemHeigh:itemHeigh];
}


#pragma mark <UICollectionViewDelegate>


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end

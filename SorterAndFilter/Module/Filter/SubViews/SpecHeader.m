//
//  SepcHeader.m
//  SorterAndFilter
//
//  Created by zhoufei on 16/2/23.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "SpecHeader.h"

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]


@interface SpecHeader()
@property (strong,nonatomic)UIImageView *flag;
@property (strong,nonatomic)UILabel *specTitle ;
@end

@implementation SpecHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHeadrSubViews];
    }
    return self;
}



- (void)createHeadrSubViews
{
    //标题
    UILabel *label =[[UILabel alloc]init];
    label.text=@"规格名称";
//    label.textColor=RGB(118, 130, 142);
//    label.font=[UIFont systemFontOfSize:16];
    self.specTitle=label;
    
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 20, 0, -20));
    }];
    
    label.backgroundColor=[UIColor clearColor];
    
    //图标
    UIImageView * flag =[[UIImageView alloc]init];
    flag.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:flag];
    
    [flag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(10);
    }];
    self.flag=flag;
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    _headerTitle=headerTitle;
    
    self.specTitle.text=headerTitle;
    
}


@end

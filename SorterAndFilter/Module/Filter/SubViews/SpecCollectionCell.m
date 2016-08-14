//
//  SpecCollectionCell.m
//  SorterAndFilter
//
//  Created by zhoufei on 16/2/18.
//  Copyright © 2016年 zhoufei. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "SpecCollectionCell.h"


@interface SpecCollectionCell()
@property(strong,nonatomic)UILabel *contentLabel;
@end

@implementation SpecCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //子规格选项名
        UILabel * contentLabel =[[UILabel alloc]init];
        [self.contentView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        self.contentLabel          = contentLabel;
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.text=@"内容";

        //更新子规格选项状态
        [self updateItemState:SepcStateNormal];
    }
    
    return self;
}

- (void)updateItemState:(SepcState)sepcState
{
    if (SepcStateSelected==sepcState) {
        [self.contentLabel setTextColor:[UIColor whiteColor]];
        [self.contentLabel setBackgroundColor:[UIColor blackColor]];
    }else{
        [self.contentLabel setTextColor:[UIColor blackColor]];
        [self.contentLabel setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (void)setContentText:(NSString *)contentText
{
    _contentText=contentText;
    self.contentLabel.text=contentText;
}

@end

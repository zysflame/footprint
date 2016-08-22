//
//  YSBeiJingScrollView.m
//  吃什么
//
//  Created by qingyun on 16/7/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSBeiJingScrollView.h"

@implementation YSBeiJingScrollView

#pragma 纯代码时会加载此方法
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self loadDefaultSetting];
    }
    return self;
}
#pragma mark 使用xib时会加载此方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadDefaultSetting];
    }
    return self;
}
#pragma mark 唤醒xib视图
- (void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    
}

- (void)setArrImageNames:(NSArray *)arrImageNames{
    _arrImageNames = arrImageNames;
    
    CGFloat imageBackWidth = self.frame.size.width;
    CGFloat imageBackHeight = self.frame.size.height;
    
    NSUInteger count = _arrImageNames.count;
    for (NSUInteger index = 0; index < count; index ++) {
        UIImageView *imageBack = [UIImageView new];
        imageBack.image = [UIImage imageNamed:_arrImageNames[index]];
        
        imageBack.frame = CGRectMake(index * imageBackWidth, 0, imageBackWidth, imageBackHeight);
        [self addSubview:imageBack];
    }
    self.contentSize = CGSizeMake(count * imageBackWidth, 1);
    self.showsHorizontalScrollIndicator = NO;
    self.pagingEnabled = YES;
}


@end

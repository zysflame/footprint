//
//  YSProFileHeader.m
//  菜谱
//
//  Created by qingyun on 16/8/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSProFileHeader.h"

@implementation YSProFileHeader

+ (instancetype)profileHeaderView{
    YSProFileHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"YSProFileHeader" owner:nil options:nil] firstObject];
    return headerView;
}

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


@end

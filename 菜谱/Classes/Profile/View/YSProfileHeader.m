//
//  YSProFileHeader.m
//  菜谱
//
//  Created by qingyun on 16/8/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSProfileHeader.h"

@interface YSProfileHeader ()

@end

@implementation YSProfileHeader

+ (instancetype)profileHeaderView{
    YSProfileHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:@"YSProfileHeader" owner:nil options:nil] firstObject];
    
    return headerView;
}

#pragma mark  > 点击头像后触发的事件 <
- (IBAction)clickTheHeaderBtn:(UIButton *)sender {
    if (self.blkClickTheHeaderBtn) {
        self.blkClickTheHeaderBtn(sender);
    }
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

- (void)layoutSubviews{
    CGFloat width = self.headerBtn.frame.size.width;
    self.headerBtn.layer.masksToBounds = YES;
    self.headerBtn.layer.cornerRadius = width / 2;
}


@end

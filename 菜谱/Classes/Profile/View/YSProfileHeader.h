//
//  YSProFileHeader.h
//  菜谱
//
//  Created by qingyun on 16/8/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSProfileHeader : UIView

@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UITextField *nickName;
@property (weak, nonatomic) IBOutlet UITextField *txfUserName;

@property (nonatomic, strong) void(^blkClickTheHeaderBtn)(UIButton *button);

+ (instancetype)profileHeaderView;

@end

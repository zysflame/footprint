//
//  QYTabBar.h
//  Demo03_微博
//
//  Created by qingyun on 16/6/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSTabBar : UITabBar

@property (nonatomic, strong) void(^blkTapThePlusBtn)(UIButton *button);

@end

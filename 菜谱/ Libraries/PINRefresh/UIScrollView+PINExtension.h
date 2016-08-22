//
//  UIScrollView+HMExtension.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/26.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (PINExtension)

/// 边距
@property (nonatomic, assign) CGFloat edgeTop;

@property (nonatomic, assign) CGFloat edgeLeft;

@property (nonatomic, assign) CGFloat edgeBottom;

@property (nonatomic, assign) CGFloat edgeRight;

/// 滚动范围
@property (nonatomic, assign) CGFloat contentSizeWidth;

@property (nonatomic, assign) CGFloat contentSizeHeight;

/// 偏移量
@property (nonatomic, assign) CGFloat offsetX;

@property (nonatomic, assign) CGFloat offsetY;

@end

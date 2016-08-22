//
//  PINBaseRefreshControl.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/26.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+PINFrame.h"
#import "UIScrollView+PINExtension.h"
#import "Masonry.h"
#import "PINRefreshConfig.h"

@interface PINBaseRefreshControl : UIView

/** 基础视图控件:
 @property stateLabel: 状态标签
 @property imageView: 箭头imageView
 @property activityView: 指示器
 @property gifImageView: 动图imageView
 @property scrollView: 父视图
 */
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, weak) UIScrollView *scrollView;

/** 基础属性:
 @property textColor: 状态标签字体颜色
 @property font: 状态标签字体
 @property currentState: 当前状态
 @property hiddenStateLabel: 隐藏状态标签
 */
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) PINRefreshState currentState;
@property (nonatomic, assign) BOOL hiddenStateLabel;

/** 状态标签不同状态显示文字:
 @property pullCanRefreshText: 拉动可以（刷新/加载）
 @property releaseCanRefreshText: 松开可以（刷新/加载）
 @property refreshingText: 正在（刷新/加载）
 @property noMoreDataText: 没有更多数据
 */
@property (nonatomic, copy) NSString *pullCanRefreshText;
@property (nonatomic, copy) NSString *releaseCanRefreshText;
@property (nonatomic, copy) NSString *refreshingText;
@property (nonatomic, copy) NSString *noMoreDataText;

/**
 @property pullingPercent: 拖拽的比例
 */
@property (nonatomic, assign) CGFloat pullingPercent;

- (void)setTitle:(NSString *)title forState:(PINRefreshState)state;

- (void)endRefreshing;

@end

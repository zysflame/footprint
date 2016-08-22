//
//  UIScrollView+PINRefresh.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/28.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PINNormalRefreshHeader.h"
#import "PINGifRefreshHeader.h"
#import "PINNormalRefreshFooter.h"
#import "PINGifRefreshFooter.h"
#import "PINAutoRefreshFooter.h"

@interface UIScrollView (PINRefresh)

/**
 * 是否是最后一页
 */
@property (nonatomic, assign) BOOL isLastPage;

/**
 * header背景色
 */
@property (nonatomic, strong) UIColor *refreshHeaderBackgroundColor;

/**
 * footer背景色
 */
@property (nonatomic, strong) UIColor *refreshFooterBackgroundColor;

/**
 * header 字体
 */
@property (nonatomic, strong) UIFont *refreshHeaderFont;

/**
 * header 字体颜色
 */
@property (nonatomic, strong) UIColor *refreshHeaderTextColor;

/**
 * footer 字体
 */
@property (nonatomic, strong) UIFont *refreshFooterFont;

/**
 * footer 字体颜色
 */
@property (nonatomic, strong) UIColor *refreshFooterTextColor;

/**
 * ********************** 以下是调用的方法 **********************
 */
/**
 * 普通的刷新及加载
 */
- (void)addRefreshHeaderWithClosure:(PINRefreshClosure)closure;

- (void)addRefreshFooterWithClosure:(PINRefreshClosure)closure;

/**
 * gif 图刷新及加载（带有状态提示）
 */
- (void)addGifRefreshHeaderWithClosure:(PINRefreshClosure)closure;

- (void)addGifRefreshFooterWithClosure:(PINRefreshClosure)closure;

/**
 * gif 图刷新及加载（不带有状态提示）
 */
- (void)addGifRefreshHeaderNoStatusWithClosure:(PINRefreshClosure)closure;

- (void)addGifRefreshFooterNoStatusWithClosure:(PINRefreshClosure)closure;

/**
 * ******************** 以下是自动加载调用的方法 ********************
 */
/**
 * auto refresh footer with style PINAutoRefreshFooterStyleGifImages
 */
- (void)addAutoRefreshFooterGifImagesStyleWithClosure:(PINRefreshClosure)closure;

/**
 * auto refresh footer with style PINAutoRefreshFooterStyleGifImagesWithoutState
 */
- (void)addAutoRefreshFooterGifImagesWithoutStateStyleWithClosure:(PINRefreshClosure)closure;

/**
 * auto refresh footer with style PINAutoRefreshFooterStyleActivityIndicator
 */
- (void)addAutoRefreshFooterActivityIndicatorStyleWithClosure:(PINRefreshClosure)closure;

/**
 * auto refresh footer with style PINAutoRefreshFooterStyleActivityIndicatorWithoutState
 */
- (void)addAutoRefreshFooterActivityIndicatorWithoutStateStyleWithClosure:(PINRefreshClosure)closure;

/**
 * ******************** 以下方法是对上面方法的再次封装 ********************
 */
/**
 * 普通的刷新及加载
 */
- (void)addRefreshHeaderWithClosure:(PINRefreshClosure)headerClosure
        addRefreshFooterWithClosure:(PINRefreshClosure)footerClosure;

/**
 * gif 图刷新及加载（带有状态提示）
 */
- (void)addGifRefreshHeaderWithClosure:(PINRefreshClosure)headerClosure
        addGifRefreshFooterWithClosure:(PINRefreshClosure)footerClosure;

/**
 * gif 图刷新及加载（不带有状态提示）
 */
- (void)addGifRefreshHeaderNoStatusWithClosure:(PINRefreshClosure)headerClosure
        addGifRefreshFooterNoStatusWithClosure:(PINRefreshClosure)footerClosure;

/**
 * 结束刷新
 */
- (void)endRefreshing;

- (void)headerEndRefreshing;

- (void)footerEndRefreshing;

@end

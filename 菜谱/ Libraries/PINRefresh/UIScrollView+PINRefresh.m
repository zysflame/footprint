//
//  UIScrollView+PINRefresh.m
//  PINRefresh
//
//  Created by 雷亮 on 16/7/28.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UIScrollView+PINRefresh.h"
#import <objc/message.h>

@interface UIScrollView ()

@property (nonatomic, strong) PINNormalRefreshHeader *pin_header;
@property (nonatomic, strong) PINNormalRefreshFooter *pin_footer;
@property (nonatomic, strong) PINGifRefreshHeader *pin_gifHeader;
@property (nonatomic, strong) PINGifRefreshFooter *pin_gifFooter;
@property (nonatomic, strong) PINAutoRefreshFooter *pin_autoFooter;

@end

@implementation UIScrollView (PINRefresh)

YYSYNTH_DYNAMIC_PROPERTY_OBJECT(pin_header, setPin_header, RETAIN_NONATOMIC, PINNormalRefreshHeader *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(pin_footer, setPin_footer, RETAIN_NONATOMIC, PINNormalRefreshFooter *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(pin_gifHeader, setPin_gifHeader, RETAIN_NONATOMIC, PINGifRefreshHeader *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(pin_gifFooter, setPin_gifFooter, RETAIN_NONATOMIC, PINGifRefreshFooter *)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(pin_autoFooter, setPin_autoFooter, RETAIN_NONATOMIC, PINAutoRefreshFooter *)

- (void)addRefreshHeaderWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_gifHeader)
    
    self.pin_header = [PINNormalRefreshHeader header];
    [self.pin_header setTitle:@"下拉即可刷新" forState:PINRefreshStatePullCanRefresh];
    [self.pin_header setTitle:@"松开即可刷新" forState:PINRefreshStateReleaseCanRefresh];
    [self.pin_header setTitle:@"正在为您刷新" forState:PINRefreshStateRefreshing];
    [self addSubview:self.pin_header];
    [self.pin_header addRefreshHeaderWithClosure:closure];
}

- (void)addRefreshFooterWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_gifFooter)
    PIN_VIEW_SAFE_RELEASE(self.pin_autoFooter)
    
    self.pin_footer = [PINNormalRefreshFooter footer];
    [self.pin_footer setTitle:@"上拉即可加载" forState:PINRefreshStatePullCanRefresh];
    [self.pin_footer setTitle:@"松开即可加载" forState:PINRefreshStateReleaseCanRefresh];
    [self.pin_footer setTitle:@"正在为您加载" forState:PINRefreshStateRefreshing];
    [self.pin_footer setTitle:@"已经是最后一页" forState:PINRefreshStateNoMoreData];
    [self addSubview:self.pin_footer];
    [self.pin_footer addRefreshFooterWithClosure:closure];
}

- (void)addGifRefreshHeaderWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_header)
    
    self.pin_gifHeader = [PINGifRefreshHeader header];
    // 是否隐藏状态label
    self.pin_gifHeader.hiddenStateLabel = NO;
    [self.pin_gifHeader setTitle:@"下拉即可刷新" forState:PINRefreshStatePullCanRefresh];
    [self.pin_gifHeader setTitle:@"松开即可刷新" forState:PINRefreshStateReleaseCanRefresh];
    [self.pin_gifHeader setTitle:@"正在为您刷新" forState:PINRefreshStateRefreshing];
    // 这里根据自己的需求来调整图片 by liang;
    NSMutableArray *_idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [_idleImages addObject:image];
    }
    [self.pin_gifHeader setImages:_idleImages forState:PINRefreshStatePullCanRefresh];
    NSMutableArray *_refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [_refreshingImages addObject:image];
    }
    [self.pin_gifHeader setImages:_refreshingImages forState:PINRefreshStateRefreshing];
    [self addSubview:self.pin_gifHeader];
    [self.pin_gifHeader addRefreshHeaderWithClosure:closure];
}

- (void)addGifRefreshFooterWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_footer)
    PIN_VIEW_SAFE_RELEASE(self.pin_autoFooter)
    
    self.pin_gifFooter = [PINGifRefreshFooter footer];
    self.pin_gifFooter.hiddenStateLabel = NO;
    [self.pin_gifFooter setTitle:@"上拉即可加载" forState:PINRefreshStatePullCanRefresh];
    [self.pin_gifFooter setTitle:@"松开即可加载" forState:PINRefreshStateReleaseCanRefresh];
    [self.pin_gifFooter setTitle:@"正在为您加载" forState:PINRefreshStateRefreshing];
    [self.pin_gifFooter setTitle:@"已经是最后一页" forState:PINRefreshStateNoMoreData];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.pin_gifFooter setImages:idleImages forState:PINRefreshStatePullCanRefresh];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.pin_gifFooter setImages:refreshingImages forState:PINRefreshStateRefreshing];
    [self addSubview:self.pin_gifFooter];
    [self.pin_gifFooter addRefreshFooterWithClosure:closure];
}

- (void)addGifRefreshHeaderNoStatusWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_header)
    
    self.pin_gifHeader = [PINGifRefreshHeader header];
    // 是否隐藏状态label
    self.pin_gifHeader.hiddenStateLabel = YES;
    // 这里根据自己的需求来调整图片 by liang;
    NSMutableArray *_idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [_idleImages addObject:image];
    }
    [self.pin_gifHeader setImages:_idleImages forState:PINRefreshStatePullCanRefresh];
    NSMutableArray *_refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [_refreshingImages addObject:image];
    }
    [self.pin_gifHeader setImages:_refreshingImages forState:PINRefreshStateRefreshing];
    [self addSubview:self.pin_gifHeader];
    [self.pin_gifHeader addRefreshHeaderWithClosure:closure];
}

- (void)addGifRefreshFooterNoStatusWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_footer)
    PIN_VIEW_SAFE_RELEASE(self.pin_autoFooter)
    
    self.pin_gifFooter = [PINGifRefreshFooter footer];
    self.pin_gifFooter.hiddenStateLabel = YES;
    [self.pin_gifFooter setTitle:@"已经是最后一页" forState:PINRefreshStateNoMoreData];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self.pin_gifFooter setImages:idleImages forState:PINRefreshStatePullCanRefresh];
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.pin_gifFooter setImages:refreshingImages forState:PINRefreshStateRefreshing];
    [self addSubview:self.pin_gifFooter];
    [self.pin_gifFooter addRefreshFooterWithClosure:closure];
}

- (void)addAutoRefreshFooterGifImagesStyleWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_footer)
    PIN_VIEW_SAFE_RELEASE(self.pin_gifFooter)
    
    self.pin_autoFooter = [PINAutoRefreshFooter footer];
    self.pin_autoFooter.autoRefreshFooterStyle = PINAutoRefreshFooterStyleGifImages;
    [self.pin_autoFooter setTitle:@"正在为您加载" forState:PINRefreshStateRefreshing];
    [self.pin_autoFooter setTitle:@"已经是最后一页" forState:PINRefreshStateNoMoreData];
    
    NSMutableArray <UIImage *>*refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.pin_autoFooter setGifImages:refreshingImages];
    [self addSubview:self.pin_autoFooter];
    [self.pin_autoFooter addAutoRefreshFooterWithClosure:closure];
}

- (void)addAutoRefreshFooterGifImagesWithoutStateStyleWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_footer)
    PIN_VIEW_SAFE_RELEASE(self.pin_gifFooter)
    
    self.pin_autoFooter = [PINAutoRefreshFooter footer];
    self.pin_autoFooter.autoRefreshFooterStyle = PINAutoRefreshFooterStyleGifImagesWithoutState;
    [self.pin_autoFooter setTitle:@"已经是最后一页" forState:PINRefreshStateNoMoreData];
    
    NSMutableArray <UIImage *>*refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self.pin_autoFooter setGifImages:refreshingImages];
    [self addSubview:self.pin_autoFooter];
    [self.pin_autoFooter addAutoRefreshFooterWithClosure:closure];
}

- (void)addAutoRefreshFooterActivityIndicatorStyleWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_footer)
    PIN_VIEW_SAFE_RELEASE(self.pin_gifFooter)
    
    self.pin_autoFooter = [PINAutoRefreshFooter footer];
    self.pin_autoFooter.autoRefreshFooterStyle = PINAutoRefreshFooterStyleActivityIndicator;
    [self.pin_autoFooter setTitle:@"正在为您加载" forState:PINRefreshStateRefreshing];
    [self.pin_autoFooter setTitle:@"已经是最后一页" forState:PINRefreshStateNoMoreData];
    
    [self addSubview:self.pin_autoFooter];
    [self.pin_autoFooter addAutoRefreshFooterWithClosure:closure];
}

- (void)addAutoRefreshFooterActivityIndicatorWithoutStateStyleWithClosure:(PINRefreshClosure)closure {
    PIN_VIEW_SAFE_RELEASE(self.pin_footer)
    PIN_VIEW_SAFE_RELEASE(self.pin_gifFooter)
    
    self.pin_autoFooter = [PINAutoRefreshFooter footer];
    self.pin_autoFooter.autoRefreshFooterStyle = PINAutoRefreshFooterStyleActivityIndicatorWithoutState;
    [self.pin_autoFooter setTitle:@"已经是最后一页" forState:PINRefreshStateNoMoreData];
    [self addSubview:self.pin_autoFooter];
    [self.pin_autoFooter addAutoRefreshFooterWithClosure:closure];
}

- (void)addRefreshHeaderWithClosure:(PINRefreshClosure)headerClosure
        addRefreshFooterWithClosure:(PINRefreshClosure)footerClosure {
    [self addRefreshHeaderWithClosure:headerClosure];
    [self addRefreshFooterWithClosure:footerClosure];
}

/**
 * gif 图刷新及加载（带有状态提示）
 */
- (void)addGifRefreshHeaderWithClosure:(PINRefreshClosure)headerClosure
        addGifRefreshFooterWithClosure:(PINRefreshClosure)footerClosure {
    [self addGifRefreshHeaderWithClosure:headerClosure];
    [self addGifRefreshFooterWithClosure:footerClosure];
}

/**
 * gif 图刷新及加载（不带有状态提示）
 */
- (void)addGifRefreshHeaderNoStatusWithClosure:(PINRefreshClosure)headerClosure
        addGifRefreshFooterNoStatusWithClosure:(PINRefreshClosure)footerClosure {
    [self addGifRefreshHeaderNoStatusWithClosure:headerClosure];
    [self addGifRefreshFooterNoStatusWithClosure:footerClosure];
}

/**
 * 结束刷新
 */
- (void)endRefreshing {
    [self headerEndRefreshing];
    [self footerEndRefreshing];
}

- (void)headerEndRefreshing {
    if (self.pin_header) { [self.pin_header endRefreshing]; }
    if (self.pin_gifHeader) { [self.pin_gifHeader endRefreshing]; }
}

- (void)footerEndRefreshing {
    if (self.pin_footer) { [self.pin_footer endRefreshing]; }
    if (self.pin_gifFooter) { [self.pin_gifFooter endRefreshing]; }
    if (self.pin_autoFooter) { [self.pin_autoFooter endRefreshing]; }
}

#pragma mark -
#pragma mark - setter methods
- (void)setIsLastPage:(BOOL)isLastPage {
    if (self.pin_footer) { self.pin_footer.isLastPage = isLastPage; }
    if (self.pin_gifFooter) { self.pin_gifFooter.isLastPage = isLastPage; }
    if (self.pin_autoFooter) { self.pin_autoFooter.isLastPage = isLastPage; }
}

- (BOOL)isLastPage {
    if (self.pin_footer) { return self.pin_footer.isLastPage; }
    if (self.pin_gifFooter) { return self.pin_gifFooter.isLastPage; }
    if (self.pin_autoFooter) { return self.pin_autoFooter.isLastPage; }
    return NO;
}

- (void)setRefreshHeaderBackgroundColor:(UIColor *)refreshHeaderBackgroundColor {
    if (self.pin_header) {
        self.pin_header.backgroundColor = refreshHeaderBackgroundColor;
    }
    if (self.pin_gifHeader) {
        self.pin_gifHeader.backgroundColor = refreshHeaderBackgroundColor;
    }
}

- (UIColor *)refreshHeaderBackgroundColor {
    if (self.pin_header) {
        return self.pin_header.backgroundColor;
    }
    if (self.pin_gifHeader) {
        return self.pin_gifHeader.backgroundColor;
    }
    return [UIColor clearColor];
}

- (void)setRefreshFooterBackgroundColor:(UIColor *)refreshFooterBackgroundColor {
    if (self.pin_footer) { self.pin_footer.backgroundColor = refreshFooterBackgroundColor; }
    if (self.pin_gifFooter) { self.pin_gifFooter.backgroundColor = refreshFooterBackgroundColor; }
    if (self.pin_autoFooter) { self.pin_autoFooter.backgroundColor = refreshFooterBackgroundColor; }
}

- (UIColor *)refreshFooterBackgroundColor {
    if (self.pin_footer) { return self.pin_footer.backgroundColor; }
    if (self.pin_gifFooter) { return self.pin_gifFooter.backgroundColor; }
    if (self.pin_autoFooter) { return self.pin_autoFooter.backgroundColor; }
    return [UIColor clearColor];
}

- (void)setRefreshHeaderFont:(UIFont *)refreshHeaderFont {
    if (self.pin_header) { self.pin_header.font = refreshHeaderFont; }
    if (self.pin_gifHeader) { self.pin_gifHeader.font = refreshHeaderFont; }
}

- (UIFont *)refreshHeaderFont {
    if (self.pin_header) { return self.pin_header.font; }
    if (self.pin_gifHeader) { return self.pin_gifHeader.font; }
    return [UIFont systemFontOfSize:13];
}

- (void)setRefreshHeaderTextColor:(UIColor *)refreshHeaderTextColor {
    if (self.pin_header) { self.pin_header.textColor = refreshHeaderTextColor; }
    if (self.pin_gifHeader) { self.pin_gifHeader.textColor = refreshHeaderTextColor; }
}

- (UIColor *)refreshHeaderTextColor {
    if (self.pin_header) { return self.pin_header.textColor; }
    if (self.pin_gifHeader) { return self.pin_gifHeader.textColor; }
    return [UIColor clearColor];
}

- (void)setRefreshFooterFont:(UIFont *)refreshFooterFont {
    if (self.pin_footer) { self.pin_footer.font = refreshFooterFont; }
    if (self.pin_gifFooter) { self.pin_gifFooter.font = refreshFooterFont; }
    if (self.pin_autoFooter) { self.pin_autoFooter.font = refreshFooterFont; }
}

- (UIFont *)refreshFooterFont {
    if (self.pin_footer) { return self.pin_footer.font; }
    if (self.pin_gifFooter) { return self.pin_gifFooter.font; }
    if (self.pin_autoFooter) { return self.pin_autoFooter.font; }
    return [UIFont systemFontOfSize:13];
}

- (void)setRefreshFooterTextColor:(UIColor *)refreshFooterTextColor {
    if (self.pin_footer) { self.pin_footer.textColor = refreshFooterTextColor; }
    if (self.pin_gifFooter) { self.pin_gifFooter.textColor = refreshFooterTextColor; }
    if (self.pin_autoFooter) { self.pin_autoFooter.textColor = refreshFooterTextColor; }
}

- (UIColor *)refreshFooterTextColor {
    if (self.pin_footer) { return self.pin_footer.textColor; }
    if (self.pin_gifFooter) { return self.pin_gifFooter.textColor; }
    if (self.pin_autoFooter) { return self.pin_autoFooter.textColor; }
    return [UIColor clearColor];
}

@end

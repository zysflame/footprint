//
//  PINAutoRefreshFooter.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINBaseRefreshControl.h"

typedef NS_ENUM(NSUInteger, PINAutoRefreshFooterStyle) {
    /**
     * gif图(显示当前状态)
     */
    PINAutoRefreshFooterStyleGifImages = 0,
    /**
     * gif图(隐藏当前状态)
     */
    PINAutoRefreshFooterStyleGifImagesWithoutState = 1,
    /**
     * 显示活动指示器(显示当前状态)
     */
    PINAutoRefreshFooterStyleActivityIndicator = 2,
    /**
     * 显示活动指示器(隐藏当前状态)
     */
    PINAutoRefreshFooterStyleActivityIndicatorWithoutState = 3,
};

@interface PINAutoRefreshFooter : PINBaseRefreshControl

/**
 * 注：
 *  使用 PINBaseRefreshControl 你不需要设置 hiddenStateLabel 属性,
 *  只需要设置 autoRefreshFooterStyle 就可以了
 */
+ (instancetype)footer;

/**
 * @property autoRefreshFooterStyle: auto refresh footer control style
 * default is PINAutoRefreshFooterStyleGifImages
 */
@property (nonatomic, assign) PINAutoRefreshFooterStyle autoRefreshFooterStyle;

/**
 * @property isLastPage:
 * if it's YES, the load callback method will not be performed.
 */
@property (nonatomic, assign) BOOL isLastPage;

/**
 * @param images: gif images array
 * if autoRefreshFooterStyle need gif, calling this method.
 */
- (void)setGifImages:(NSArray <UIImage *>*)images;

// add auto refresh footer control call back
- (void)addAutoRefreshFooterWithClosure:(PINRefreshClosure)closure;

@end

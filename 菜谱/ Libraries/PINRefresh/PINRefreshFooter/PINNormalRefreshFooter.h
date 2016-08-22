//
//  PINNormalRefreshFooter.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINBaseRefreshControl.h"

@interface PINNormalRefreshFooter : PINBaseRefreshControl

+ (instancetype)footer;

// add normal refresh footer control call back
- (void)addRefreshFooterWithClosure:(PINRefreshClosure)closure;

/**
 * @property isLastPage:
 * if it's YES, the load callback method will not be performed.
 */
@property (nonatomic, assign) BOOL isLastPage;

@end

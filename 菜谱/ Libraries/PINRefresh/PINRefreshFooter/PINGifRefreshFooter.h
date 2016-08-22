//
//  PINGifRefreshFooter.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINNormalRefreshFooter.h"

@interface PINGifRefreshFooter : PINNormalRefreshFooter

+ (instancetype)footer;

// set gif images for different state
- (void)setImages:(NSArray <UIImage *>*)images forState:(PINRefreshState)state;

@end

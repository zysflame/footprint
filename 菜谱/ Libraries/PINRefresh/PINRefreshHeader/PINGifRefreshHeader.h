//
//  PINGifRefreshHeader.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINNormalRefreshHeader.h"

@interface PINGifRefreshHeader : PINNormalRefreshHeader

+ (instancetype)header;

// set gif images for different state
- (void)setImages:(NSArray <UIImage *>*)images forState:(PINRefreshState)state;

@end

//
//  PINNormalRefreshHeader.h
//  PINRefresh
//
//  Created by 雷亮 on 16/7/27.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINBaseRefreshControl.h"

@interface PINNormalRefreshHeader : PINBaseRefreshControl

+ (instancetype)header;

// add normal refresh header control call back
- (void)addRefreshHeaderWithClosure:(PINRefreshClosure)closure;

@end

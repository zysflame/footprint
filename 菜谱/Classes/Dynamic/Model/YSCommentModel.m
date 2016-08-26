//
//  QYCommentModel.m
//  青云微博
//
//  Created by qingyun on 16/7/15.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSCommentModel.h"
#import "YSUserModel.h"
#import "NSString+QYString.h"

@implementation YSCommentModel

+ (instancetype)commentModelWithDictionary:(NSDictionary *)dicData {
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSCommentModel *comment = [self new];
    
    comment.user = [YSUserModel userModelWithDictionary:dicData[@"user"]];
    comment.strCreateAt = dicData[@"created_at"];
    comment.strText = dicData[@"text"];
    
    return comment;
}

- (void)setStrCreateAt:(NSString *)strCreateAt {
    _strCreateAt = [strCreateAt copy];
    _strTimeDes = [NSString descriptionWithString:_strCreateAt];
}

@end

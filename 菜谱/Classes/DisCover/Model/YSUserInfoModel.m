//
//  YSUser.m
//  菜谱
//
//  Created by qingyun on 16/9/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSUserInfoModel.h"

@implementation YSUserInfoModel

- (instancetype)initUserInfoModelWithDictionary:(NSDictionary *)dicData{
    YSUserInfoModel *userInfoModel = [YSUserInfoModel new];
    userInfoModel.strUserName = dicData[@"userName"];
    return userInfoModel;
}

@end

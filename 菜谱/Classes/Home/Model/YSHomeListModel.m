//
//  YSHomeListModel.m
//  菜谱
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSHomeListModel.h"

@implementation YSHomeListModel

+ (instancetype)homeListModelWithDictionary:(NSDictionary *)dicData{
    if (dicData == nil || [dicData isKindOfClass:[NSNull class]]) return nil;
    YSHomeListModel *homeListModel = [YSHomeListModel new];

    homeListModel.uid = dicData[@"uid"];
    homeListModel.userName = dicData[@"userName"];
    homeListModel.avatar = dicData[@"avatar"];
    homeListModel.commentCount = dicData[@"commentCount"];
    homeListModel.fakePostId = dicData[@"fakePostId"];
    homeListModel.imgUrl = dicData[@"imgUrl"];
    homeListModel.imgUrlBig = dicData[@"imgUrlBig"];
    homeListModel.text = dicData[@"text"];
    
    return homeListModel;
}

@end

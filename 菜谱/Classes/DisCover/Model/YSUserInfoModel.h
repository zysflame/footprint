//
//  YSUser.h
//  菜谱
//
//  Created by qingyun on 16/9/4.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSUserInfoModel : AVObject <AVSubclassing>

/** 用户名  就是用户的账号名*/
@property (nonatomic, copy) NSString *strUserName;
/** 昵称*/
@property (nonatomic, copy) NSString *strNickName;
/** 头像图片的数据*/
@property (nonatomic, strong) NSData *dataHeaderImage;
/** 相距我的距离*/
@property (nonatomic)float distanse;

/** 初始化模型的的方法*/
- (instancetype)initUserInfoModelWithDictionary:(NSDictionary *)dicData;

@end

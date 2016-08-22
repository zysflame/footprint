//
//  YSHomeListModel.h
//  菜谱
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSHomeListModel : NSObject

/** uid 用户的id */
@property (nonatomic,copy) NSString *uid;
/** userName  用户的名字*/
@property (nonatomic,copy) NSString *userName;

/** avatar  用户的头像*/
@property (nonatomic,copy) NSString *avatar;
/** commentCount 评论人数*/
@property (nonatomic,copy) NSString *commentCount ;
/** fakePostId  暂时不知道作用*/
@property (nonatomic,copy) NSString *fakePostId;
/** imgUrl 图片的网址 */
@property (nonatomic,copy) NSString *imgUrl;
/** imgUrlBig 大图的地址 */
@property (nonatomic,copy) NSString *imgUrlBig;
/** text  描述*/
@property (nonatomic,copy) NSString *text;


+ (instancetype)homeListModelWithDictionary:(NSDictionary *)dicData;

@end

//
//  YSAnnotation.h
//  定位
//
//  Created by qingyun on 16/8/26.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YSAnnotation : NSObject <MKAnnotation>

/** 位置点*/
@property (nonatomic) CLLocationCoordinate2D coordinate;

/** 标题*/
@property (nonatomic,copy) NSString *title;
/** 子标题*/
@property (nonatomic,copy) NSString *subtitle;


@end

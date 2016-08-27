//
//  YSRecommendViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSDiscoverViewController.h"
#import "YSListDisCoverViewController.h"

#import <CoreLocation/CoreLocation.h> // 导入系统框架
#import <MapKit/MapKit.h>
#import "YSAnnotation.h"
@interface YSDiscoverViewController () <CLLocationManagerDelegate,MKMapViewDelegate>

/**1、创建位置管理器*/
@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, weak) MKMapView *mapViewBack;

@end

@implementation YSDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self loadNavigationSetting];
}

#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
    UIBarButtonItem *itemListBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(clickTheListBtnAction)];
    self.navigationItem.rightBarButtonItem = itemListBtn;
}

#pragma mark  > 点击了列表按钮 <
- (void)clickTheListBtnAction{
    YSListDisCoverViewController *listVc = [YSListDisCoverViewController new];
    [self.navigationController pushViewController:listVc animated:YES];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.view.backgroundColor = YSColorRandom;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 200, 200)];
    [self.view addSubview:lable];
    lable.numberOfLines = 0;
    lable.text = @"其他人的一些分享";
    
    MKMapView *mapViewBack = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mapViewBack];
    self.mapViewBack = mapViewBack;
    
    // 2、初始化位置管理器
    self.locationManager = [[CLLocationManager alloc] init];
    // 3、设置位置管理器的代理
    self.locationManager.delegate = self;
    // 4、如果用户没有选择  申请授权
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        // 发出当前应用在前台使用的请求
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // 5、设置信息
    // 5.1、设置频率
    self.locationManager.distanceFilter = 10.f;
    // 5.2、设置精确度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // 6、 如果定位总开关打开
    if ([CLLocationManager locationServicesEnabled]) {
        [self.locationManager startUpdatingLocation]; // 开始定位
    }else{
        // 暂停定位
    }
    //修改地图的类型
    //    self.mapView.mapType = MKMapTypeSatellite;
    self.mapViewBack.delegate = self;
}

#pragma mark  > CLLocationManagerDelegate  <
// 获取状态的改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@">>>>>当前状态%d",status);
}

// 定位错误的时候
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位错误>>>%@",error);
}


// 7、定位到准确的位置
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    // 获取位置
    CLLocation *location = locations.lastObject;
    // 如果水平精度过差就放弃该点
    if (location.horizontalAccuracy > kCLLocationAccuracyHundredMeters) {
        return;
    }
    
    // 定位的点
    CLLocationCoordinate2D coordinate = location.coordinate;
    // 设定跨度 --- 经纬度的跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    // 构造区域
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    // 地图调到该区域
    [self.mapViewBack setRegion:region animated:YES];
    
    //    // 添加系统的标注
    //    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    //    point.coordinate = coordinate;
    //    // 添加标注点的应用
    //    [self.mapViewBack addAnnotation:point];
    
    // 自定义的标注
    YSAnnotation *annotation = [[YSAnnotation alloc] init];
    annotation.coordinate = coordinate;
    annotation.title = @"香港";
    annotation.subtitle = @"就在这";
    [self.mapViewBack addAnnotation:annotation];
}

#pragma mark  > MKMapViewDelegate  <
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"当区域改变结束时触发的方法");
}

// 代理方法
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[YSAnnotation class]]) {
        static NSString *strID = @"YSAnnotation";
        MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:strID];
        if (!view) {
            view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:strID];
        }
        
        view.annotation = annotation; // 绑定数据
        view.centerOffset = CGPointMake(0, -15); // 设置内容的偏移
        view.image = [UIImage imageNamed:@"gps"];
        view.canShowCallout = YES; // 设置显示View
        
        return view;
    }
    return nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

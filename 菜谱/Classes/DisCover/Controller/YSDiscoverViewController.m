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
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "YSLocationManager.h"

@interface YSDiscoverViewController () <CLLocationManagerDelegate,BMKMapViewDelegate>


/** 展示地图的图层*/
@property (nonatomic, weak) BMKMapView *mapViewBack;

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    BMKMapView *mapViewBack = [[BMKMapView alloc] init];
    CGFloat mapViewY = (YSScreenHeight - YSScreenWidth) / 2;
    mapViewBack.frame = CGRectMake(0, mapViewY, YSScreenWidth, YSScreenWidth);
    [self.view addSubview:mapViewBack];
    self.mapViewBack = mapViewBack;
    
    YSLocationManager *locationManager = [YSLocationManager shareLocationManager];
    // 开始定位
    [locationManager startTheLocationService];
    __weak typeof(self) weakSelf = self;
    [locationManager setBlkLocationUpdate:^(CLLocationCoordinate2D coordinat) {
        // 更新地图的中心点
        BMKCoordinateRegion region = weakSelf.mapViewBack.region;
        region.center = coordinat;
        weakSelf.mapViewBack.region = region;
        // 设置显示的区域 --- 比例尺级别
        weakSelf.mapViewBack.zoomLevel = 16;
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.mapViewBack viewWillAppear];
    self.mapViewBack.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.mapViewBack viewWillAppear];
    self.mapViewBack.delegate = nil; // 不用时，置nil
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

//
//  ViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "YSNavigationViewController.h"

#import "YSHomeViewController.h"
#import "YSDynamicViewController.h"
#import "YSAddViewController.h"
#import "YSDiscoverViewController.h"
#import "YSProfileViewController.h"

#import "YSTabBar.h"

@interface MainTabBarViewController ()

/** 创建存放控制器的数组*/
@property (nonatomic,copy)NSArray *arrControllers;

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
//    self.view.backgroundColor = YSColorRandom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadTabBarController];
}

- (void)loadTabBarController{
    YSHomeViewController *HomeVC = [YSHomeViewController new];
    [self addViewController:HomeVC WithImageName:@"tabbar_hote" Title:@"热门"];
    
    YSDynamicViewController *dynamicVC = [YSDynamicViewController new];
    [self addViewController:dynamicVC WithImageName:@"tabbar_menu" Title:@"个人动态"];

    YSDiscoverViewController *discoverVC = [YSDiscoverViewController new];
    [self addViewController:discoverVC WithImageName:@"tabar_discover" Title:@"附近的人"];
    [UIImage imageNamed:@"tabbar_menu"];
    
    YSProfileViewController *profileVC = [YSProfileViewController new];
    [self addViewController:profileVC WithImageName:@"tabbar_profile" Title:@"我的设置"];
    
    // 创建自己的TabBar
    YSTabBar *tabBar = [YSTabBar new];
    //self.tabBar = tabBar;
    tabBar.tintColor = [UIColor orangeColor];
    tabBar.barTintColor = [UIColor lightTextColor];
     __weak typeof(self) weakSelf = self;
    [tabBar setBlkTapThePlusBtn:^(UIButton *button) {
        // 点击加号按钮触发的事件
        YSAddViewController *addVC = [YSAddViewController new];
        YSNavigationViewController *naviVC = [[YSNavigationViewController alloc] initWithRootViewController:addVC];
        [weakSelf presentViewController:naviVC animated:YES completion:nil];
//        NSLog(@"点击了加号按钮");
    }];
    [self setValue:tabBar forKey:@"tabBar"];
}


#pragma mark  > 添加子控制器 <
- (void)addViewController:(UIViewController *)viewCotroller WithImageName:(NSString *)imageName Title:(NSString *)title{
    
    viewCotroller.tabBarItem.image = [UIImage imageNamed:imageName];
    viewCotroller.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]];
    viewCotroller.title = title;
    viewCotroller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    self.tabBar.tintColor = [UIColor orangeColor];
    self.tabBar.barTintColor = [UIColor lightTextColor];
    YSNavigationViewController *navigationVC = [[YSNavigationViewController alloc] initWithRootViewController:viewCotroller];
    [self addChildViewController:navigationVC];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

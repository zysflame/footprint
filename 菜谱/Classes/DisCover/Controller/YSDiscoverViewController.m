//
//  YSRecommendViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSDiscoverViewController.h"

@interface YSDiscoverViewController ()

@end

@implementation YSDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.view.backgroundColor = YSColorRandom;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 200, 200)];
    [self.view addSubview:lable];
    lable.numberOfLines = 0;
    lable.text = @"其他人的一些分享";
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

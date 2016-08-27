//
//  YSListDisCoverViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSListDisCoverViewController.h"

@interface YSListDisCoverViewController ()

@end

@implementation YSListDisCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self loadNavigationSetting];
}

#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
    UIBarButtonItem *itemListBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"CoolAddress"] style:UIBarButtonItemStylePlain target:self action:@selector(clickTheMapViewBtnAction)];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"CoolAddress"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = itemListBtn;
}

- (void)clickTheMapViewBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.title = @"列表";
    self.view.backgroundColor = YSColorRandom;
    
    
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

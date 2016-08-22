//
//  YSHomeInfoViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSHomeInfoViewController.h"

@interface YSHomeInfoViewController ()

@end

@implementation YSHomeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
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

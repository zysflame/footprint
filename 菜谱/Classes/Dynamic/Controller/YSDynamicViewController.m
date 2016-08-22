//
//  YSDynamicViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSDynamicViewController.h"

@interface YSDynamicViewController ()

@end

@implementation YSDynamicViewController

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
    lable.text = @"展示关注的好友的动态，以及自己发表的动态";
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

//
//  YSAddViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSAddViewController.h"

@interface YSAddViewController ()

@end

@implementation YSAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self loadNavigationSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.navigationItem.title = @"添加";
    self.view.backgroundColor = YSColorRandom;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 200, 200)];
    [self.view addSubview:lable];
    lable.numberOfLines = 0;
    lable.text = @"添加动态，主要是包含图片与文字，图片支持本地选择与直接拍照";
}

#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
    UIBarButtonItem *itemWrong = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_cuowu"] style:UIBarButtonItemStylePlain target:self action:@selector(clickTheUserAction:)];
    self.navigationItem.leftBarButtonItem = itemWrong;
    
    UIBarButtonItem *itemTrue = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_gouxuan"] style:UIBarButtonItemStylePlain target:self action:@selector(clickTheUserAction:)];
    self.navigationItem.rightBarButtonItem = itemTrue;
}

- (void)clickTheUserAction:(UIBarButtonItem *)button{
    NSLog(@"返回");
    [self dismissViewControllerAnimated:YES completion:nil];
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

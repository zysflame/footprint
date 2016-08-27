//
//  YSDengLuViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSDengLuViewController.h"
#import "YSZhuCeViewController.h"

@interface YSDengLuViewController ()

@end

@implementation YSDengLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationSetting];
    [self loadDefaultSetting];
}

#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
    UIBarButtonItem *zhuCeBtn = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(clickTheZhuCeBtnAction)];
    self.navigationItem.rightBarButtonItem = zhuCeBtn;
}

#pragma mark  > 注册按钮触发的方法 <
- (void)clickTheZhuCeBtnAction{
    YSZhuCeViewController *zhuceVC = [YSZhuCeViewController new];
    [self.navigationController pushViewController:zhuceVC animated:YES];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.title = @"登录";
    
    UIImageView *imageViewBack = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageViewBack.image = [UIImage imageNamed:@"塔"];
    [self.view addSubview:imageViewBack];
    
    
    UIImageView *imvLeft=[self createImageViewFrame:CGRectMake(2, 400, 100, 1) withImageName:nil backgroundColor:[UIColor lightGrayColor]];
    UIImageView *imvRight=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1) withImageName:nil backgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:imvLeft];
    [self.view addSubview:imvRight];
}

#pragma mark  > 创建 UIImageView的方法 <
-(UIImageView *)createImageViewFrame:(CGRect)frame withImageName:(NSString *)imageName backgroundColor:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    return imageView;
}

#pragma mark  > 创建 UITextField <
-(UITextField *)createTextFielfFrame:(CGRect)frame withTextFont:(UIFont *)font andPlaceholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
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

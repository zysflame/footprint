//
//  YSLoginViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSLoginViewController.h"
#import "MainTabBarViewController.h"
#import "YSRegisterViewController.h"

@interface YSLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txfUserName;
@property (weak, nonatomic) IBOutlet UITextField *txfPWD;

@end

@implementation YSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.title = @"登录";
}

#pragma mark  > 注册按钮触发的方法 <
- (IBAction)ZhuCeBtn:(UIButton *)sender {
    
    
    
    YSRegisterViewController *registerVC = [YSRegisterViewController new];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark  > 忘记密码的操作 <
- (IBAction)forgetThePassWordBtn:(UIButton *)sender {
}

#pragma mark  > 登录按钮 <
- (IBAction)loginBtn:(UIButton *)sender {
    
    if (self.txfUserName.text == nil || self.txfPWD.text == nil) {
        NSLog(@"账号密码为空");
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [AVUser logInWithUsernameInBackground:self.txfUserName.text password:self.txfPWD.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {
            NSLog(@"登录成功");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; // 保存
            [defaults setObject:user.username forKey:@"username"];
            [defaults synchronize]; // 立即写入
            
            MainTabBarViewController *mainVC = [MainTabBarViewController new];
            [weakSelf presentViewController:mainVC animated:YES completion:nil];
            
            weakSelf.txfUserName.text = nil;
            weakSelf.txfPWD.text = nil;
        } else {
            NSLog(@"登录失败>>>%@",error);
        }
    }];

}

#pragma mark  > qq 账号登录 <
- (IBAction)QQLoginBtn:(UIButton *)sender {
}

#pragma mark  > 新浪微博账号登录 <
- (IBAction)sinaLoginBtn:(UIButton *)sender {
}

#pragma mark  > 点击屏幕后编辑结束 <
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

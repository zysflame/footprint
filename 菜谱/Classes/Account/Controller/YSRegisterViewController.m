//
//  YSRegisterViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSRegisterViewController.h"
#import "YSPhoneRegisterViewController.h"
#import "YSLoginViewController.h"
#import "MainTabBarViewController.h"
@interface YSRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txfUserName;
@property (weak, nonatomic) IBOutlet UITextField *txfFirstPwd;
@property (weak, nonatomic) IBOutlet UITextField *txfSecPwd;

@end

@implementation YSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.title = @"邮箱注册";
    
}
#pragma mark  > 注册按钮 <
- (IBAction)zhuCeBtn:(UIButton *)sender {
    NSLog(@"注册");
    if (self.txfUserName.text == nil || self.txfFirstPwd.text == nil ) {
        NSLog(@"账号密码为空");
        return;
    }
    if ([self.txfFirstPwd.text isEqualToString:self.txfSecPwd.text]) {
        [AVUser requestEmailVerify:self.txfUserName.text withBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"请求重发验证邮件成功");
            }else{
                NSLog(@">>>>>error>>>>%@",error);
            }
        }];
//        AVUser *user = [AVUser user];// 新建 AVUser 对象实例
//        user.username = self.txfUserName.text;// 设置用户名
//        user.password = self.txfFirstPwd.text;// 设置密码
//        user.email = self.txfUserName.text;// 设置邮箱
//        __weak typeof(self) weakSelf = self;
//        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (succeeded) {
//                NSLog(@"注册成功");
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; // 保存
//                [defaults setObject:user.username forKey:@"username"];
//                [defaults synchronize]; // 立即写入
//                
//                MainTabBarViewController *mainVC = [MainTabBarViewController new];
//                [weakSelf presentViewController:mainVC animated:YES completion:nil];
//                
//                weakSelf.txfUserName.text = nil;
//                weakSelf.txfFirstPwd.text = nil;
//                // 注册成功
//            } else {
//                // 失败的原因可能有多种，常见的是用户名已经存在。
//                NSLog(@"注册失败>>>%@",error);
//            }
//        }];
    }else{
        NSLog(@"两次密码不同");
    }

    
    
    
}

#pragma mark  > 一键注册 <
- (IBAction)phoneRegisterBtn:(UIButton *)sender {
    YSPhoneRegisterViewController *phoneVC = [YSPhoneRegisterViewController new];
    [self.navigationController pushViewController:phoneVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  > 点击屏幕后编辑结束 <
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

//
//  YSPhoneRegisterViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSPhoneRegisterViewController.h"
#import "MainTabBarViewController.h"

@interface YSPhoneRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txfPhoneNum;

@property (weak, nonatomic) IBOutlet UITextField *txfYanZhengMa;
@property (weak, nonatomic) IBOutlet UITextField *txfFirstPwd;
@property (weak, nonatomic) IBOutlet UITextField *txfSecPwd;

@end

@implementation YSPhoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.title = @"手机号一键注册";
    
}

- (IBAction)getTheYanZhengMaBtn:(UIButton *)sender {
    sender.enabled = NO;
    if (self.txfPhoneNum.text == nil) {
        NSLog(@"手机号不能为空");
        return;
    }
    [AVUser requestMobilePhoneVerify:self.txfPhoneNum.text withBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            NSLog(@"发送成功");
            //发送成功
            sender.enabled = YES;
        }else{
            NSLog(@"发送失败>>%@",error);
        }
    }];
}
- (IBAction)zhuCeBtn:(UIButton *)sender {
    if (self.txfPhoneNum.text == nil || self.txfFirstPwd.text == nil ) {
        return;
    }else if([self.txfFirstPwd.text isEqualToString:self.txfSecPwd.text]){
        [AVUser verifyMobilePhone:self.txfYanZhengMa.text withBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                //验证成功
                NSLog(@"注册成功");
            }
        }];
    }
    
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

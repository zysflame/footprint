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

@property (weak, nonatomic) IBOutlet UITextField *txfPsaaword;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation YSPhoneRegisterViewController

- (void)viewWillAppear:(BOOL)animated{
    self.nextBtn.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.title = @"手机号注册";
    
}


#pragma mark  > 注册按钮触发的事件 <
- (IBAction)zhuCeNextBtn:(UIButton *)button {
    
    if ([self.txfPhoneNum.text isEqualToString:@""] || [self.txfPsaaword.text isEqualToString:@""] ) {
        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"请填写手机号和密码" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            
        }];
        [alertContorller addAction:alertAction];
        [self presentViewController:alertContorller animated:YES completion:nil];
        return;
    }
    button.enabled = NO; 
//    [button setTitle:@"请求中。。。。" forState: UIControlStateDisabled];
    
    AVUser *user = [AVUser user];
    user.username = self.txfPhoneNum.text;
    user.password = self.txfPsaaword.text;
    user.mobilePhoneNumber = self.txfPhoneNum.text;
    NSError *error = nil;
    [user signUp:&error];
    
    UIStoryboard *registeredSB = [UIStoryboard storyboardWithName:@"registered" bundle:nil];
    UIViewController *registeredVC = [registeredSB instantiateViewControllerWithIdentifier:@"YSPhoneNumYanZhengVC"];
    [self.navigationController pushViewController:registeredVC animated:YES];
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

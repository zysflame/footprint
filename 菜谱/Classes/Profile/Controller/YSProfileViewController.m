//
//  YSProfileViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSProfileViewController.h"

#import "YSProfileInfoViewController.h"

#import "YSProFileHeader.h"

@interface YSProfileViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
/** 存放标题的数组*/
@property (nonatomic,copy) NSArray *arrTitles;

@end

@implementation YSProfileViewController

- (NSArray *)arrTitles{
    if (!_arrTitles) {
        _arrTitles = @[@"资料设置",@"清除缓存",@"帮助",@"功能介绍",@"退出"];
    }
    return _arrTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
//    self.view.backgroundColor = YSColorRandom;
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(80, 100, 200, 200)];
//    [self.view addSubview:lable];
//    lable.numberOfLines = 0;
//    lable.text = @"包含资料设置，好友的关注列表，自己发的自己的足迹";
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    
    YSProFileHeader *infoView = [YSProFileHeader profileHeaderView];
    tableView.tableHeaderView = infoView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.arrTitles.count -1;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strID = @"strIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = self.arrTitles[indexPath.row];
    }else{
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
        cell.textLabel.text = [self.arrTitles lastObject];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self settingInformation];
                break;
            case 1:
                break;
            case 2:
                [self helpViewController];
                break;
            case 3:
                [self functionViewController];
                break;
            default:
                break;
        }
        
    }else if (indexPath.section == 1){
        // 退出程序的操作
        exit(0);
        //        [UIView animateWithDuration:1 animations:^{
        //            self.view.frame = CGRectMake(-(self.view.frame.size.width),-(self.view.frame.size.height), self.view.frame.size.height,self.view.frame.size.width);
        //        } completion:^(BOOL finished) {
        //            exit(0);
        //        }];
    }
}

#pragma mark  > 点击资料设置后触发的方法 <
- (void)settingInformation{
    YSProfileInfoViewController *infoVC = [YSProfileInfoViewController new];
    [self.navigationController pushViewController:infoVC animated:YES];
}

#pragma mark  > 帮助控制器 <
- (void)helpViewController{
    //    YSHelpViewController *helpVC = [YSHelpViewController new];
    //    [self.navigationController pushViewController:helpVC animated:YES];
    
    UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"帮助" message:@"1、首页是推荐的\n2、随便看看是随机推荐的\n3、推荐是对早中晚三餐的推荐\n4、我的是一些基本设置" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
    
    [alertContorller addAction:alertAction];
    [self presentViewController:alertContorller animated:YES completion:nil];
}

#pragma mark  > 功能介绍 <
- (void)functionViewController{
    //    YSFunctionViewController *functionVC = [YSFunctionViewController new];
    //    [self.navigationController pushViewController:functionVC animated:YES];
    UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"功能介绍" message:@"1、首页是推荐的\n2、随便看看是随机推荐的\n3、推荐是对早中晚三餐的推荐\n4、我的是一些基本设置" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
    
    [alertContorller addAction:alertAction];
    [self presentViewController:alertContorller animated:YES completion:nil];
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

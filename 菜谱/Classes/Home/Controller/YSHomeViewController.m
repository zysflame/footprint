//
//  YSHomeViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSHomeViewController.h"

#import "YSLoginViewController.h"
#import "YSHomeInfoViewController.h"

#import "YSHomeListModel.h"

static NSInteger page = 1;
@interface YSHomeViewController () <UITableViewDelegate,UITableViewDataSource>
/** tableView 视图*/
@property (nonatomic, weak) UITableView *tableView;

/** 存放模型的数组*/
@property (nonatomic, strong) NSMutableArray *arrMData;

@end

@implementation YSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigationSetting];
    [self loadDefaultSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.view.backgroundColor = YSColorRandom;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    
//    __weak typeof(self) weakSelf = self;
//    [self.tableView addGifRefreshHeaderWithClosure:^{
//        [weakSelf loadNewData];
//    }];
//    [self.tableView addGifRefreshFooterWithClosure:^{
//        [weakSelf loadNewData];
//    }];

}
#pragma mark  > 刷新加载新的数据 <
- (void)loadNewData{
    page += 1;
    //    [self sendRequest];
    [self requestInformation];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView endRefreshing];
        [weakSelf.tableView reloadData];
    });
}

#pragma mark  > 发送网络请求 <
- (void)requestInformation{
    NSString *strURL = @"http://www.fotoplace.cc/api/square/hot_post_list.do?osType=android4.4.4-XiaomiMI%204LTE&uid=26102341";
    NSDictionary *dicProgrma = @{@"page":@(page)};
    
    // 创建一个 HTTP管理
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置响应的接收类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",nil];
     __weak typeof(self) weakSelf = self;
    [manager POST:strURL parameters:dicProgrma success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSDictionary *dicData = dic[@"data"];
        NSArray *arrTemp = dicData[@"list"];
        weakSelf.arrMData = [NSMutableArray arrayWithCapacity:arrTemp.count];
        for (NSDictionary *dicList in arrTemp) {
            YSHomeListModel *homeListModel = [YSHomeListModel homeListModelWithDictionary:dicList];
            [weakSelf.arrMData addObject:homeListModel];
        }
        NSLog(@">>>>>arrData %ld",weakSelf.arrMData.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@">>>>>请求失败");
        __weak typeof(self) weakSelf = self;
        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"网络不好，请耐心等待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *alertDengLuAction = [UIAlertAction actionWithTitle:@"刷新试试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf loadNewData];
        }];
        [alertContorller addAction:alertDengLuAction];
        [alertContorller addAction:alertAction];
        [self presentViewController:alertContorller animated:YES completion:nil];
    }];
    
}


#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
    UIBarButtonItem *itemProfile = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_user"] style:UIBarButtonItemStylePlain target:self action:@selector(clickTheUserAction)];
    self.navigationItem.rightBarButtonItem = itemProfile;
}

#pragma mark  > 点击用户后跳转到登录界面 <
- (void)clickTheUserAction{
    YSLoginViewController *loginVC = [YSLoginViewController new];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *strID = @"strIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%lu----%lu",indexPath.section,indexPath.row];
    return cell; 
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

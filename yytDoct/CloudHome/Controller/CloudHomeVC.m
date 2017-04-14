//
//  CloudHomeVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "CloudHomeVC.h"
#import "CloudHomeCell.h"
#import "GTMBase64.h"
#import "PatientPage.h"
#import "MBProgressHUD+MJ.h"
#import "DIYRefreshHeader.h"
#import "LoadFailView.h"
#import "UserInfo.h"
@interface CloudHomeVC ()

@property(strong ,nonatomic) AFHTTPSessionManager *manager;
@property(strong ,nonatomic) NSArray *resultArray;
@property(nonatomic, weak) LoadFailView *failView;
@end

@implementation CloudHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云病房";
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [DIYRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    [self setupFailureView];

}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (NSArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [NSArray array];
    }
    return _resultArray;
}

- (void)setupFailureView {
    LoadFailView *view = [LoadFailView loadFailView];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height);
    [self.tableView addSubview: view];
    view.hidden = YES;
    view.reLoadData = ^{
        [self.tableView.mj_header beginRefreshing];
        
    };
    _failView = view;
}

- (void)loadData {
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    [MBProgressHUD showMessage:@"正在加载中"];
    NSString *str = [NSString stringWithFormat:@"{\"dept_code\":\"\",\"doctor_code\":\"%@\",\"begin_date\":\"%@\",\"end_date\":\"%@\",\"hospital_code\":\"%@\"}",_dataDict[@"doctor_code"],_dataDict[@"created_time"],_dataDict[@"update_time"],userInfo.hospital_code];
    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data];
     NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.patient.list.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    
   [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
       [MBProgressHUD hideHUD];
       [self.tableView.mj_header endRefreshing];
       self.resultArray = dict[@"result"];
       NSLog(@"%@",dict[@"result_message"]);
       if ([dict[@"result_message"] isEqualToString:@"执行成功但没有对应数据"]) {
           self.failView.hidden = NO;
           [self.failView setImgView:@"img_tips_none" :@"" :@"没有任何数据"];
       }else {
           self.failView.hidden = YES;
             [self.tableView reloadData];
       }
     
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [self.tableView.mj_header endRefreshing];
       [MBProgressHUD hideHUD];
       [MBProgressHUD showError:@"加载失败,请稍微重试"];
       [self.failView setImgView:@"img_dataloading_failure" :@"OMG,服务器消化不良" :@"请稍后重试"];
   }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.resultArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  82;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CloudHomeCell *cell = [CloudHomeCell cloudHomeCellWithTableView:tableView];
    cell.dataDict = self.resultArray[indexPath.section];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PatientPage *patientPage = [[PatientPage alloc] init];
    patientPage.dataDict = self.resultArray[indexPath.section];
    [self.navigationController pushViewController:patientPage animated:YES];
}


@end

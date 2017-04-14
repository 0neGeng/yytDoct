//
//  InspectionResultDetailVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/10.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "InspectionResultDetailVC.h"
#import "CommonHeadView.h"
#import "MBProgressHUD+MJ.h"
#import <AFNetworking.h>
#import "DIYRefreshHeader.h"
#import "LoadFailView.h"
#import "UserInfo.h"
#import "ReportContentCell.h"
#import "DoctorAdviceHeadView.h"
@interface InspectionResultDetailVC ()

@property(strong ,nonatomic) AFHTTPSessionManager *manager;
@property(strong ,nonatomic) NSArray *dataArray;
@end

@implementation InspectionResultDetailVC

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.dataDict[@"inspectName"];
   
    self.tableView.mj_header = [DIYRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData {
    [MBProgressHUD showMessage:@"正在加载"];

    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    
    NSDictionary *parameters = @{
                                 @"hospitalCode" : userInfo.hospital_code,
                                 @"inspectId" : self.dataDict[@"inspectId"],
                                 };

    [self.manager GET:[NSString stringWithFormat:@"%@yyt/reports/inspectDetail",listUrl] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        self.dataArray = responseObject[@"message"][@"result"];
      
        [self.tableView reloadData];
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUD];
    }];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.dataArray.count + 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 232;
    }else{
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    DoctorAdviceHeadView *headView = [DoctorAdviceHeadView shareHeadView];
    if (section == 0) {
        headView.leftLabel.text = @"患者信息";
    }else{
      
        headView.leftLabel.text = @"报告内容";
 
    }
    return headView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   ReportContentCell *cell = [ReportContentCell reportContentCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[CommonHeadView class]]) {
            [view removeFromSuperview];
        }
    }
      cell.clipsToBounds = YES;
    if (indexPath.section == 0) {
        CommonHeadView *commonHeadView = [CommonHeadView shareHeadView];
        [cell.contentView addSubview:commonHeadView];
        commonHeadView.frame = cell.contentView.frame;  
        [commonHeadView setDataWithDict:self.dataDict FromController:self];
        commonHeadView.isHidden = NO;
    }else{
        if (indexPath.row) {
            cell.dataDict = self.dataArray[indexPath.row - 1];
            
        }else{
            [cell setIndexOneTitle];
        }
    }
    return cell;

}



@end

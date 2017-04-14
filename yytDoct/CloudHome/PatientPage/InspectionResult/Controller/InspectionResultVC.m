//
//  InspectionResultVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/7.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "InspectionResultVC.h"
#import "InspectionResultCell.h"
#import "MBProgressHUD+MJ.h"
#import "LoadFailView.h"
#import "DIYRefreshHeader.h"
#import "InspectionResultDetailVC.h"
@interface InspectionResultVC ()
@property(strong ,nonatomic) AFHTTPSessionManager *manager;
@property (nonatomic, weak) LoadFailView *failView;

@property(nonatomic, strong)NSArray *dataArray;
@end

@implementation InspectionResultVC

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
//        _manager = shareCustomManager();
        
    }
    return _manager;
}

- (void)viewDidLoad {
   self.title = @"患者检验检查";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.mj_header = [DIYRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    LoadFailView *view = [LoadFailView loadFailView];
    view.frame = CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height);
    [self.tableView addSubview: view];
    view.hidden = YES;
    view.reLoadData = ^{
        [self.tableView.mj_header beginRefreshing];

    };
    _failView = view;
    
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    NSLog(@"%@", dict);
}
- (void)loadData {
    [MBProgressHUD showMessage:@"正在加载"];
    NSString *url = [NSString stringWithFormat:@"%@yyt/reports/inspectList",listUrl];
    NSDictionary *parameters = @{
                           @"hospitalCode" : @"lczyy",
                           @"admission_no" : _dict[@"admission_no"],
                           @"patCardType" : _dict[@"pat_card_type"],
//                            @"patCardType" : @"1",
//                           @"patCardNo" : @"441622196806261877",
                            @"patCardNo" : _dict[@"pat_card_no"],
                           };

    
    NSLog(@"%@===%@",_dict[@"admission_no"],_dict[@"pat_card_type"]);
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@", responseObject);
        self.dataArray = responseObject[@"message"][@"result"];
        if (self.dataArray.count == 0) {
            self.failView.hidden = NO;
            [self.failView setImgView:@"img_tips_none" :@"暂无数据" :@"请稍后重试"];
        }else {
            self.failView.hidden = YES;
        }
        [self.tableView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
          [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD showError:@"加载失败"];
        self.failView.hidden = NO;
        [self.failView setImgView:@"img_dataloading_failure" :@"OMG,服务器消化不良" :@"请稍后重试"];
        
    }];
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InspectionResultCell *cell = [InspectionResultCell InspectionResultCellWithTableView:tableView];
    cell.dataDict = self.dataArray[indexPath.row];
    cell.dataDictTwo = self.dict;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    InspectionResultDetailVC *detailVC = [[InspectionResultDetailVC alloc] init];
     NSMutableDictionary *mutabDict = [NSMutableDictionary dictionary];
     [mutabDict addEntriesFromDictionary:self.dict];
    [mutabDict addEntriesFromDictionary:self.dataArray[indexPath.row]];
    detailVC.dataDict = mutabDict;
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end

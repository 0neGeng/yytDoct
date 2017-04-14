//
//  AdviceDetail.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "AdviceDetail.h"
#import "UserInfo.h"
#import "GTMBase64.h"
#import "DoctorAdviceHeadView.h"
#import "CommonHeadView.h"
#import "AdviceDetailCell.h"
#import "MBProgressHUD+MJ.h"
#import "DIYRefreshHeader.h"

@interface AdviceDetail ()
@property(strong ,nonatomic) AFHTTPSessionManager *manager;
@property(strong ,nonatomic) NSArray *listArray;
@property(strong ,nonatomic) UILabel *noDataLabel;
@end

@implementation AdviceDetail

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = [NSArray array];
    }
    return _listArray;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.mj_header = [DIYRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];

    UILabel *label = [[UILabel alloc] init];
    label.textColor = WGColor(51, 51, 51, 1);
    label.font = [UIFont systemFontOfSize:17];
    label.hidden = NO;
    label.text = @"暂无更多数据!";
    self.noDataLabel = label;
    label.hidden = YES;
    [self.view addSubview:label];
    [label sizeToFit];
    label.wg_y = 172 + 80;
    label.wg_centerX = YYTScreenW / 2;
    
   
}
/*
 "admission_no" = 0069532;
 "bed_no" = 042;
 "in_date" = "2016-09-30";
 "medical_status" = 0;
 "out_date" = "";
 "pat_birth" = 70;
 "pat_card_no" = "";
 "pat_card_type" = 5;
 "pat_name" = "\U66fe\U65b0\U6dfb";
 "pat_sex" = 0;
 住院状态 0住院 1出院
 */
- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
}

- (void)loadData {
    
    [MBProgressHUD showMessage:@"正在加载"];
    NSDate *date = [NSDate date];
    NSDateFormatter *formt = [[NSDateFormatter alloc] init];
    [formt setDateFormat:@"YYYY-MM-dd"];
    NSString *currentTime = [formt stringFromDate:date];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    
    NSString *str = [NSString stringWithFormat:@"{\"admission_no\":\"%@\",\"advice_type\":\"%zd\",\"begin_date\":\"%@\",\"end_date\":\"%@\",\"hospital_code\":\"%@\"}",_dataDict[@"admission_no"],self.index,_dataDict[@"in_date"],currentTime,userInfo.hospital_code];
    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data];
    NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.advice.list.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
            [MBProgressHUD hideHUD];
            [self.tableView.mj_header endRefreshing];
            self.listArray = dict[@"result"][@"advice_list"];
            if (self.listArray) {
                self.noDataLabel.hidden = NO;
            }
            [self.tableView reloadData];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showMessage:@"加载失败"];
        [self.tableView.mj_header endRefreshing];
    }];
}
/*
 "advice_list" =         (
 {
 "advice_id" = 169;
 "advice_items" =                 (
 {
 "item_frequency" = qd;
 "item_name" = "\U87ba\U65cb\U5200\U7247\U5f0f\U9ad3\U5185\U9489";
 "item_unit" = 1;
 "item_use" = "";
 }
 );
 "advice_time" = "2016-10-10 11:32:30";
 },
 */
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.listArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        NSArray *array = self.listArray[section - 1][@"advice_items"];
        return array.count + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 172;
    }else{
        return 44;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   
    DoctorAdviceHeadView *headView = [DoctorAdviceHeadView shareHeadView];
    if (section == 0) {
        headView.leftLabel.text = @"患者信息";
    }else{
        NSString *leftTitle = [NSString stringWithFormat:@"组号:%@",self.listArray[section - 1][@"advice_id"]];
        headView.leftLabel.text = leftTitle;
        headView.rightLabel.text = [NSString stringWithFormat:@"开嘱时间:%@",self.listArray[section - 1][@"advice_time"]];
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   AdviceDetailCell *cell = [AdviceDetailCell shareAdviceDetailCell:tableView];
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
        commonHeadView.dataDict = self.dataDict;
        commonHeadView.department.text = self.departmentStr;
        commonHeadView.isHidden = YES;
    }else{
        self.noDataLabel.hidden = YES;
        if (indexPath.row) {
          
            cell.dataDict = self.listArray[indexPath.section - 1][@"advice_items"][indexPath.row - 1];
                
        }else{
            [cell setIndexOneTitle];
        }
    }
     return cell;
}


@end

//
//  DoctorAdvice.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DoctorAdvice.h"
#import "DoctorAdviceHeadView.h"
#import "DoctorAdviceCell.h"
#import "AdviceListVC.h"
#import "UserInfo.h"
#import "GTMBase64.h"
#import "DIYRefreshHeader.h"
#import "MBProgressHUD+MJ.h"

@interface DoctorAdvice ()
@property(strong ,nonatomic) AFHTTPSessionManager *manager;

@property(strong ,nonatomic) NSArray *dataArray;
@end

@implementation DoctorAdvice

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (void)setInHospitalArray:(NSArray *)inHospitalArray {
    _inHospitalArray = inHospitalArray;
    if (inHospitalArray.count > 0) {
        self.dataArray = inHospitalArray;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    if ([self.titleStr isEqualToString:@"患者病历"]) {
        self.tableView.mj_header = [DIYRefreshHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        [self.tableView.mj_header beginRefreshing];
    }

}

- (void)loadData {
    [MBProgressHUD showMessage:@"正在加载"];
    NSDate *date = [NSDate date];
    NSDateFormatter *formt = [[NSDateFormatter alloc] init];
    [formt setDateFormat:@"YYYY-MM-dd"];
    NSString *currentTime = [formt stringFromDate:date];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    NSLog(@"%@==%@",self.record_id,self.dictData);
    NSString *str = [NSString stringWithFormat:@"{\"pat_card_type\":\"%@\",\"pat_card_no\":\"%@\",\"admission_no\":\"%@\",\"begin_date\":\"2010-01-01\",\"end_date\":\"%@\",\"hospital_code\":\"%@\"}",_dictData[@"pat_card_type"],_dictData[@"pat_card_no"],_dictData[@"admission_no"],currentTime,userInfo.hospital_code];
    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data];
    NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.med.record.list.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];

    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict[@"result_message"]);
        [self.tableView.mj_header endRefreshing];
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
            self.dataArray = dict[@"result"][@"record_items"];
        }
        [MBProgressHUD hideHUD];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [MBProgressHUD hideHUD];
         [self.tableView.mj_header endRefreshing];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

//    NSLog(@"%zd",self.inHospitalArray.count);

        if (self.dataArray.count > 0) {
            if (self.dataArray.count > 1) {
                return 2;
            }else {
                return 1;
            }
//             return 2;
        }else {
            return 0;
        }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        if (section == 0) {
            return 1;
        }else {
          
            return self.dataArray.count - 1;
        }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 135;
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
        if ([self.titleStr isEqualToString:@"患者医嘱"]) {
              headView.leftLabel.text = @"当前住院医嘱";
        }else{
          headView.leftLabel.text = @"当前住院病历";
        }
      
    }else{
        if ([self.titleStr isEqualToString:@"患者医嘱"]) {
            headView.leftLabel.text = @"以往住院医嘱";
        }else {
        headView.leftLabel.text = @"以往住院病历";
        }
      
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoctorAdviceCell *cell = [DoctorAdviceCell doctAdviceCellWithTableView:tableView];
  
        if (indexPath.section == 0) {
            cell.dataDict = self.dataArray[0];
        }else{
            cell.dataDict = self.dataArray[indexPath.row + 1];
        }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdviceListVC *adviceList = [[AdviceListVC alloc] init];
    adviceList.titleStr = _titleStr;
    adviceList.dataDict = _dictData;
    adviceList.record_id = _record_id;
 
        if (indexPath.section == 0) {
            adviceList.departmentStr = self.dataArray[0][@"dept_name"];
        }else{
            adviceList.departmentStr = self.dataArray[indexPath.row + 1][@"dept_name"];
        }
       

    
    if (indexPath.section == 0) {
           adviceList.leftStr = @"当前住院医嘱";
    }else {
      adviceList.leftStr = @"以往住院医嘱";
    }
    
    [self.navigationController pushViewController:adviceList animated:YES];
}
@end

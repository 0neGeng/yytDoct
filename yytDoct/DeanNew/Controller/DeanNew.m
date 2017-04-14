//
//  DeanNew.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/9.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DeanNew.h"
#import "WGDatePickView.h"
#import "MBProgressHUD+MJ.h"
#import "GTMBase64.h"
#import "DeanNewView.h"
#import "DoctorAdviceHeadView.h"
#import "DenNewCell.h"
#import "DIYRefreshHeader.h"
@interface DeanNew ()<WGDatePickViewDelegate> {
    
    WGDatePickView *_pikerView;
}

@property(strong ,nonatomic) AFHTTPSessionManager *manager;
@property(strong ,nonatomic) UIButton *beginTimeBtn;
@property(strong ,nonatomic) UIButton *endTimeBtn;

@property(nonatomic, strong) NSArray *leftArray;
@property(nonatomic, strong) NSDictionary *rightDict;
/**headView*/
@property (weak, nonatomic) DeanNewView *headView;
@end

@implementation DeanNew

- (NSArray *)leftArray{
    if (!_leftArray) {
        _leftArray = @[@"门诊人次",@"入院人次",@"出院人次",@"门诊总费用",@"住院总费用",@"平均住院日",@"住院次均费用",@"住院药占比",@"住院耗材比"];
    }
    return _leftArray;
}


- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (void)setupDateView:(DateType)type {
    
    _pikerView = [WGDatePickView instanceDatePickView];
    _pikerView.frame = CGRectMake(0, 0, YYTScreenW, YYTScreenH + 20);
    [_pikerView setBackgroundColor:[UIColor clearColor]];
    _pikerView.delegate = self;
    _pikerView.type = type;
    [self.view addSubview:_pikerView];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpHeadView];
    self.title = @"院长日报";
    self.view.backgroundColor =[UIColor groupTableViewBackgroundColor];
   
    self.tableView.mj_header = [DIYRefreshHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    [self.tableView.mj_header beginRefreshing];

}

- (void)setUpHeadView{
    DeanNewView *headView = [DeanNewView instanceHeadView];
    _beginTimeBtn = headView.beginTime;
    _endTimeBtn = headView.endTime;
    _headView = headView;
    headView.wg_height = 215 - 20;//
    headView.selectTimeBlock = ^(UIButton *btn) {
      
        if (btn.tag) {
            //点击了endtime
            self.endTimeBtn = btn;
            [self setupDateView:DateTypeOfEnd];
            
        }else{
          //开始时间
            self.beginTimeBtn = btn;
            [self setupDateView:DateTypeOfStart];
        }
    };

    self.tableView.tableHeaderView = headView;//1
}

#pragma mark --- datePickViewDelegate ---

- (void)getSelectDate:(NSString *)date type:(DateType)type {
//    NSLog(@"%d - %@", type, date);
    
    switch (type) {
        case DateTypeOfStart:
            [_beginTimeBtn setTitle:date forState:UIControlStateNormal];
            [self loadData];
            break;
        case DateTypeOfEnd:
            [_endTimeBtn setTitle:date forState:UIControlStateNormal];
            [self loadData];
            break;
            
        default:
            break;
    }
}



- (void)loadData {
    
    [MBProgressHUD showMessage:@"正在加载中"];
    NSString *str = [NSString stringWithFormat:@"{\"begin_date\":\"%@\",\"end_date\":\"%@\",\"hospital_code\":\"lczyy\"}",_beginTimeBtn.titleLabel.text,_endTimeBtn.titleLabel.text];
    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data];
    NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.hospital.report.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
         [MBProgressHUD hideHUD];
        self.rightDict = dict[@"result"];
        [self.tableView.mj_header endRefreshing];
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
            self.headView.peopleNum.text = dict[@"result"][@"zyrs"];
            
            [self.tableView reloadData];
        }else {
            [MBProgressHUD showError:dict[@"result_message"]];
        }
       

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败,请稍微重试"];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

#pragma mark -- tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section  {
    
    DoctorAdviceHeadView *headView = [DoctorAdviceHeadView shareHeadView];
    headView.leftLabel.text = @"医院数据";
    return headView;
};
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DenNewCell *cell = [DenNewCell instanceDenNewCell:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftLabel.text = self.leftArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.rightLabel.text = self.rightDict[@"mzrc"];
            break;
        case 1:
            cell.rightLabel.text = self.rightDict[@"ryrs"];
            break;
        case 2:
            cell.rightLabel.text = self.rightDict[@"cyrs"];
            break;
        case 3:
            cell.rightLabel.text = self.rightDict[@"mzf"];
            break;
        case 4:
            cell.rightLabel.text = self.rightDict[@"zyf"];
            break;
        case 5:
            cell.rightLabel.text = self.rightDict[@"pjzyr"];
            break;
        case 6:
            cell.rightLabel.text = self.rightDict[@"zycjfy"];
            break;
        case 7:
            cell.rightLabel.text = self.rightDict[@"zyyfzb"];
            break;
        case 8:
            cell.rightLabel.text = self.rightDict[@"zyhcb"];
            break;
        default:
            break;
    }
    return cell;
}
//平均住院天数 住院次均费用 住院药比 住院耗材比//
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}
@end

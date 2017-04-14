//
//  PatientPage.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "PatientPage.h"
#import "UserInfo.h"
#import "GTMBase64.h"
#import "DoctorAdvice.h"
#import "InspectionResultVC.h"
#import "MBProgressHUD+MJ.h"
@interface PatientPage ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *departLabel;
@property (weak, nonatomic) IBOutlet UILabel *caseNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *atHospitalState;
//住院时间
@property (weak, nonatomic) IBOutlet UILabel *inHospitalTLabel;
@property(strong ,nonatomic) AFHTTPSessionManager *manager;

@property(strong ,nonatomic) NSArray *dataArray;
@end

@implementation PatientPage

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"患者主页";
    [self setupData];
    [self laodData];
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
  住院状态 0住院 1出院  0男 1女
 */
- (void)setupData {
    _name.text = self.dataDict[@"pat_name"];
    _ageLabel.text = self.dataDict[@"pat_birth"];
    _hospitalNumLabel.text = self.dataDict[@"admission_no"];
    _bedNumLabel.text = self.dataDict[@"bed_no"];
    if ([self.dataDict[@"pat_sex"] isEqualToString:@"1"]) {
        _sexLabel.text = @"女";
    }else{
    _sexLabel.text = @"男";
    }
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    _doctorLabel.text = userInfo.doctName;
    
    if ([_dataDict[@"medical_status"] isEqualToString:@"1"]) {
        _atHospitalState.text = @"已出院";
        _inHospitalTLabel.text = [NSString stringWithFormat:@"%@ 至 %@",_dataDict[@"in_date"],_dataDict[@"out_date"]];
    }else {
        _atHospitalState.text = @"住院中";
        _inHospitalTLabel.text = [NSString stringWithFormat:@"%@ 至 至今",_dataDict[@"in_date"]];
    }
    
   
}
/*
 2017-01-06 15:22:08.230 yytDoct[8439:1463735] {
 result =     {
 "admission_no" = 0069532;
 "in_hospital_items" =         (
 {
 "bed_no" = 042;
 "dept_code" = 02550102;
 "dept_name" = "\U9aa8\U4e00\U79d1";
 "doctor_code" = 0061;
 "doctor_name" = "\U9648\U9038\U5065";
 "in_date" = "2016-09-30";
 "out_date" = "";
 "record_id" = 00695321;
 "total_fee" = 3295461;
 }
 );
 "pat_birth" = 70;
 "pat_card_no" = "";
 "pat_card_type" = 5;
 "pat_id_no" = "";
 "pat_id_type" = 1;
 "pat_mobile" = 13650650306;
 "pat_name" = "\U66fe\U65b0\U6dfb";
 "pat_sex" = 0;
 };
 "result_code" = 0;
 "result_message" = "\U6210\U529f";
 }
 
 住院状态 0住院 1出院
 */
- (void)laodData {
    [MBProgressHUD showMessage:@"正在加载"];
    NSDate *date = [NSDate date];
    NSDateFormatter *formt = [[NSDateFormatter alloc] init];
    [formt setDateFormat:@"YYYY-MM-dd"];
    NSString *currentTime = [formt stringFromDate:date];
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    
    NSString *str = [NSString stringWithFormat:@"{\"pat_card_type\":\"%@\",\"pat_card_no\":\"%@\",\"admission_no\":\"%@\",\"begin_date\":\"%@\",\"end_date\":\"%@\",\"hospital_code\":\"%@\"}",_dataDict[@"pat_card_type"],_dataDict[@"pat_card_no"],_dataDict[@"admission_no"],_dataDict[@"in_date"],currentTime,userInfo.hospital_code];
    NSData *data = [str dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data];
    NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.pat.hospital.record.get&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
         [MBProgressHUD hideHUD];
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
           
            self.dataArray = dict[@"result"][@"in_hospital_items"];
            _caseNumLabel.text = dict[@"result"][@"in_hospital_items"][0][@"record_id"];
            _departLabel.text = self.dataArray[0][@"dept_name"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"加载失败"];

    }];
}

- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    
}
//医嘱
- (IBAction)doctorAdviceClick {
    DoctorAdvice *doctorAdvice = [[DoctorAdvice alloc] init];
    doctorAdvice.inHospitalArray = self.dataArray;
    doctorAdvice.dictData = _dataDict;
     doctorAdvice.titleStr = @"患者医嘱";
    [self.navigationController pushViewController:doctorAdvice animated:YES];
}
//病例
- (IBAction)patientCase {
    DoctorAdvice *doctorAdvice = [[DoctorAdvice alloc] init];
    doctorAdvice.inHospitalArray = self.dataArray;
    doctorAdvice.dictData = _dataDict;
    doctorAdvice.record_id = self.dataArray[0][@"record_id"];
    doctorAdvice.titleStr = @"患者病历";
    [self.navigationController pushViewController:doctorAdvice animated:YES];
}
//检查结果
- (IBAction)inspectionResult {
    InspectionResultVC *inspectionResultVC =[[InspectionResultVC alloc] init];
    inspectionResultVC.dict = _dataDict;
    [self.navigationController pushViewController:inspectionResultVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

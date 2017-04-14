//
//  DoctorHomeVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DoctorHomeVC.h"
#import <UIImageView+WebCache.h>
#import "CloudHomeVC.h"
#import "GTMBase64.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "MainNavViewController.h"
#import "UIBarButtonItem+Item.h"
#import "DeanNew.h"
#import "AboutMeVC.h"
#import "DoctorListTableVC.h"
#import "MBProgressHUD+MJ.h"
@interface DoctorHomeVC ()
@property (weak, nonatomic) IBOutlet UIImageView *doctorIcon;
@property (weak, nonatomic) IBOutlet UILabel *doctorName;
@property (weak, nonatomic) IBOutlet UILabel *doctorLevel;
@property (weak, nonatomic) IBOutlet UILabel *doctorHospital;
@property (weak, nonatomic) IBOutlet UILabel *doctorNum;
@property (weak, nonatomic) IBOutlet UILabel *doctorPara;
@property (weak, nonatomic) IBOutlet UIView *deanNew;
@property(strong ,nonatomic) AFHTTPSessionManager *manager;

@property (weak, nonatomic) IBOutlet UIButton *loginOutBtn;

@end

@implementation DoctorHomeVC

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = shareCustomManager();
    }
    return _manager;
}
//云病房
- (IBAction)homeBtnClick {

    NSString *permissionStr = self.dataDict[@"permission"];
    if (permissionStr.length >0) {
        DoctorListTableVC *cloudHome = [[DoctorListTableVC alloc] init];
        cloudHome.dataDict = _dataDict;
        [self.navigationController pushViewController:cloudHome animated:YES];
        
    }else{
    
        CloudHomeVC *cloudHome = [[CloudHomeVC alloc] init];
        cloudHome.dataDict = _dataDict;
        [self.navigationController pushViewController:cloudHome animated:YES];
    }
}
//院长日报
- (IBAction)deanBtnClick {
    DeanNew *denNew = [[DeanNew alloc] init];
    [self.navigationController pushViewController:denNew animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"医生主页";
    [MobClick event:@"home"];
    self.loginOutBtn.layer.borderWidth = 0.5;
    self.loginOutBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"icon_setting"] highImage:[UIImage imageNamed:@"icon_setting"] target:self action:@selector(aboutMe)];
    if (_dataDict == NULL) {
         [self loadData];
    } else {
        [self setupData];

    }
}

- (void)aboutMe {
    AboutMeVC *aboutMeVC = [[AboutMeVC alloc] init];
    [self.navigationController pushViewController:aboutMeVC animated:YES];

}


- (void)setupData {
    [_doctorIcon sd_setImageWithURL:[NSURL URLWithString:_dataDict[@"img"]] placeholderImage:[UIImage imageNamed:@"icon_ patient_yizhu"]];
    _doctorName.text = _dataDict[@"name"];
    if ([_dataDict[@"doctor_title"] isEqualToNumber:@1] || _dataDict[@"doctor_title"] == NULL) {//0院长1医生就两个字段
        _doctorLevel.text = @"医生";
        self.deanNew.hidden = YES;
    }else {
        self.deanNew.hidden = NO;
        _doctorLevel.text = @"院长";
    }
    _doctorHospital.text = _dataDict[@"hospital_name"];
    _doctorNum.text = self.dataDict[@"doctor_code"];
    _doctorPara.text = _dataDict[@"department_name"];
    

}

- (void)loadData {
    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    [userInfo loadUserInfoFromSanbox];
    [MBProgressHUD showMessage:@"正在加载中..."];
       NSString *str1 = [NSString stringWithFormat:@"{\"doctor_code\":\"%@\",\"hospital_code\":\"lczyy\",\"password\":\"%@\"}",userInfo.doctID,userInfo.passWord];
    NSData *data1 = [str1 dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data1];
    
    NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.login&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [MBProgressHUD hideHUD];
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
            
            self.dataDict = dict[@"result"];
            [self setupData];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"服务器繁忙,请稍后重试!"];
        NSLog(@"%@",error);
    }];
    
}


@end

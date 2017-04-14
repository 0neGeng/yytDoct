//
//  LoginViewController.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/5.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfo.h"
#import "GTMBase64.h"
#import "DoctorHomeVC.h"
#import "MainNavViewController.h"
#import "MBProgressHUD+MJ.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *doctorIDF;
@property (weak, nonatomic) IBOutlet UITextField *pwdF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property(strong ,nonatomic) AFHTTPSessionManager *manager;

@end

@implementation LoginViewController

-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = shareCustomManager();
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云医通医生端";
    self.doctorIDF.delegate = self;
    self.pwdF.delegate = self;
    _loginBtn.enabled = NO;
    _pwdF.secureTextEntry = YES;
    _pwdF.keyboardType = _doctorIDF.keyboardType = UIKeyboardTypeNumberPad;
    _pwdF.clearsOnBeginEditing = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidChangeNotification object:_pwdF];
  
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)loginBtnClick {
    
      [self loadData];
}


- (void)loadData {
    
    [MBProgressHUD showMessage:@"正在加载中"];
    NSString *str1 = [NSString stringWithFormat:@"{\"doctor_code\":\"%@\",\"hospital_code\":\"lczyy\",\"password\":\"%@\"}",_doctorIDF.text,_pwdF.text];
    NSData *data1 = [str1 dataUsingEncoding:NSASCIIStringEncoding];
    NSString *str3 = [GTMBase64 stringByEncodingData:data1];
    
    NSString *url = [NSString stringWithFormat:@"%@/openapi/gateway?app_id=csyy123&v=1000&format=json&sign_type=3&timestamp=1477277052&sessionid=&method=yyt.base.wards.login&sign=29d9e9e130a90e993cb2c1e11c23a032&data=%@",BaseUrl,str3];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
             [MBProgressHUD hideHUD];
        if ([dict[@"result_message"] isEqualToString:@"成功"]) {
            [self trunHomeVC:dict[@"result"]];
        }else{
            [MBProgressHUD showError:dict[@"result_message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络不好，请稍后再试"];
  
    }];
    
}

- (void)trunHomeVC:(NSDictionary *)dict {
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    userInfo.doctID = _doctorIDF.text;
    userInfo.doctName = dict[@"name"];
    userInfo.passWord = _pwdF.text;
    userInfo.hospital_code = dict[@"hospital_code"];
    [userInfo saveUserInfoToSanbox];
    
    DoctorHomeVC *homeVC = [[DoctorHomeVC alloc] init];
    homeVC.dataDict = dict;
    MainNavViewController *mainNav = [[MainNavViewController alloc] initWithRootViewController:homeVC];
    [[UIApplication sharedApplication].delegate window].rootViewController = mainNav;
//    [self.navigationController pushViewController:mainNav animated:YES];
}
#pragma maek ---UITextFieldDelegate---
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_doctorIDF.text.length != 0 && _pwdF.text.length != 0) {
        _loginBtn.backgroundColor =  [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
        _loginBtn.enabled = YES;
    }else {
        _loginBtn.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
      
        _loginBtn.enabled = NO;

    }
    
}



@end

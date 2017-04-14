//
//  AboutMeVC.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/10.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "AboutMeVC.h"
#import "LoginViewController.h"
#import "UserInfo.h"
#import "MainNavViewController.h"
#import "AboutYYTTableVC.h"
@interface AboutMeVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation AboutMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    NSString *appV = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"云医通医生版v%@",appV];
    
}
- (IBAction)aboutYYTClick {

    AboutYYTTableVC *yytTableView = [[AboutYYTTableVC alloc] init];
    [self.navigationController pushViewController:yytTableView animated:YES];
}
- (IBAction)loginOutClick {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定退出?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        
    }else{
        UserInfo *userInfo = [UserInfo sharedUserInfo];
        [userInfo removeUserInfoFroSanbox];
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        
//        MainNavViewController *nav = [[MainNavViewController alloc] initWithRootViewController:loginVC];
        
        [[UIApplication sharedApplication].delegate window].rootViewController = loginVC;
        //        [UIApplication sharedApplication].keyWindow.rootViewController
    }
}

@end

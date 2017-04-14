//
//  AppDelegate.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "AppDelegate.h"
#import "UserInfo.h"
#import "LoginViewController.h"
#import "DoctorHomeVC.h"
#import "MainNavViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UserInfo *userInfo = [[UserInfo alloc] init];
    [userInfo loadUserInfoFromSanbox];
    if (!userInfo.hospital_code) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
//          MainNavViewController *mainNav = [[MainNavViewController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = loginVC;
    }else {
        DoctorHomeVC *doctH = [[DoctorHomeVC alloc] init];
        MainNavViewController *mainNav = [[MainNavViewController alloc] initWithRootViewController:doctH];
        self.window.rootViewController = mainNav;
    }
    
    [self.window makeKeyAndVisible];
    [self setupUMeng];
    return YES;
 
}

- (void)setupUMeng
{
    UMConfigInstance.appKey = @"5881a3ed8630f5022d002567";
    UMConfigInstance.channelId = @"App Store";
    [MobClick profileSignInWithPUID:@"yunyichina@126.com"];
    [MobClick startWithConfigure:UMConfigInstance];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:app_Version];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

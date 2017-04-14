//
//  MainNavViewController.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "MainNavViewController.h"
#import "UIBarButtonItem+Item.h"
#import "LoginViewController.h"
@interface MainNavViewController ()<UINavigationControllerDelegate>
//保存代理
@property(nonatomic, strong) id popDelegate;
@end

@implementation MainNavViewController

+ (void)load {
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    navBar.tintColor = [UIColor whiteColor];
    navBar.barTintColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName:[UIColor whiteColor]
                                     ,
                                     NSFontAttributeName:[UIFont systemFontOfSize:18]
                                     }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //程序开始保存代理
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    //设置代理为自己
    self.delegate = self;
    
    
    for (UIView *view in self.navigationBar.subviews) {
        for (UIView *view1 in view.subviews) {
            if ([view1 isKindOfClass:[UIImageView class]]) {
                view1.hidden = YES;
            }
        }
    }

}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;

    }
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"icon_nav_back_n"] highImage:[UIImage imageNamed:@"icon_nav_back_p"] target:self action:@selector(back) title:@" 返回"];
        [[UIBarButtonItem appearance]  setBackButtonTitlePositionAdjustment:UIOffsetMake(-200, -10) forBarMetrics:UIBarMetricsDefault];
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }
    [super pushViewController:viewController animated:YES];
}


-(void)back
{
    [self popViewControllerAnimated:YES];
}



@end

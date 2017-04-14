//
//  UIBarButtonItem+Item.m
//  yunyichina
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 yunyichina. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image  forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
  
//    UIView *barButtonView = [[UIView alloc] initWithFrame:button.bounds];
//    [barButtonView addSubview:button];
    
 
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}


+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image  forState:UIControlStateNormal];
    [button setImage:selImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    
//    UIView *barButtonView = [[UIView alloc] initWithFrame:button.bounds];
//    [barButtonView addSubview:button];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title
{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
//    UIView *contentView = [[UIView alloc] initWithFrame:backButton.bounds];
//    [contentView addSubview:backButton];
    return  [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}


@end


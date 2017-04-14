//
//  WGMenu.h
//  yunyichina
//
//  Created by WangGeng on 16/4/1.
//  Copyright © 2016年 yunyichina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGMenuItem.h"

typedef void(^WGMenuSelectedItem)(NSInteger index, WGMenuItem *item);

typedef enum {
    WGMenuBackgrounColorEffectSolid      = 0, //!<背景显示效果.纯色
    WGMenuBackgrounColorEffectGradient   = 1, //!<背景显示效果.渐变叠加
} WGMenuBackgrounColorEffect;

@interface WGMenu : NSObject

+ (void)showMenuInView:(UIView *)view fromRect:(CGRect)rect menuItems:(NSArray *)menuItems selected:(WGMenuSelectedItem)selectedItem;

+ (void)dismissMenu;
+ (BOOL)isShow;

// 主题色
+ (UIColor *)tintColor;
+ (void)setTintColor:(UIColor *)tintColor;

// 标题字体
+ (UIFont *)titleFont;
+ (void)setTitleFont:(UIFont *)titleFont;

// 背景效果
+ (WGMenuBackgrounColorEffect)backgrounColorEffect;
+ (void)setBackgrounColorEffect:(WGMenuBackgrounColorEffect)effect;

// 是否显示阴影
+ (BOOL)hasShadow;
+ (void)setHasShadow:(BOOL)flag;

// 选中颜色
+ (UIColor*)selectedColor;
+ (void)setSelectedColor:(UIColor*)selectedColor;
@end
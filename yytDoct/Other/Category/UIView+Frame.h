//
//  UIView+Frame.h
//  yyt
//
//  Created by WangGeng on 16/5/5.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat wg_width;
@property CGFloat wg_height;
@property CGFloat wg_x;
@property CGFloat wg_y;
@property CGFloat wg_centerX;
@property CGFloat wg_centerY;


+ (instancetype)viewFromXib;

@end

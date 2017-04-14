//
//  UIView+Frame.m
//  yyt
//
//  Created by WangGeng on 16/5/5.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

-(void)setWg_width:(CGFloat)wg_width
{
    CGRect frame = self.frame;
    frame.size.width = wg_width;
    self.frame = frame;
}

-(CGFloat)wg_width
{
    return self.frame.size.width;
}

-(void)setWg_height:(CGFloat)wg_height
{
    CGRect frame = self.frame;
    frame.size.height = wg_height;
    self.frame = frame;
}
-(CGFloat)wg_height
{
    return self.frame.size.height;
}

-(void)setWg_x:(CGFloat)wg_x
{
    CGRect frame = self.frame;
    frame.origin.x = wg_x;
    self.frame = frame;
}

-(CGFloat)wg_x
{
    return self.frame.origin.x;
}

-(void)setWg_y:(CGFloat)wg_y
{
    CGRect frame = self.frame;
    frame.origin.y = wg_y;
    self.frame = frame;
    
}

-(CGFloat)wg_y
{
    return self.frame.origin.y;
}


-(void)setWg_centerX:(CGFloat)wg_centerX
{
    CGPoint center = self.center;
    center.x = wg_centerX;
    self.center = center;
}

-(CGFloat)wg_centerX
{
    return self.center.x;
}

-(CGFloat)wg_centerY
{
    return self.center.y;
}
-(void)setWg_centerY:(CGFloat)wg_centerY
{
    CGPoint center = self.center;
    center.y = wg_centerY;
    self.center = center;
}

@end

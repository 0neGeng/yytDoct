//
//  UITextField+TintColor.m
//  yytDoct
//
//  Created by WangGeng on 2017/2/5.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "UITextField+TintColor.h"

@implementation UITextField (TintColor)

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = CommonColor;
}

- (instancetype)init
{
    self.tintColor = CommonColor;
    return self;
}
@end

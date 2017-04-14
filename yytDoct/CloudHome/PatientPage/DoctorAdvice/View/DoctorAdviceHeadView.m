//
//  DoctorAdviceHeadView.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/6.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DoctorAdviceHeadView.h"

@implementation DoctorAdviceHeadView

+ (instancetype)shareHeadView {
    return [[NSBundle mainBundle] loadNibNamed:@"DoctorAdviceHeadView" owner:self options:nil].lastObject;
}

@end

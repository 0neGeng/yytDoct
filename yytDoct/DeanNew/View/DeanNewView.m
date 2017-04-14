//
//  DeanNewView.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/9.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DeanNewView.h"

@interface DeanNewView ()




@end
@implementation DeanNewView

+ (instancetype)instanceHeadView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"DeanNewView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSDate *date = [NSDate date];
    NSDate *lasrtDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
   NSString *beginTime = [formatter stringFromDate:lasrtDay];
    NSString *endTime = [formatter stringFromDate:date];
    [_beginTime setTitle:beginTime forState:UIControlStateNormal];
    [_endTime setTitle:endTime forState:UIControlStateNormal];
    
}
//选择开始时间
- (IBAction)beginTimeClick:(UIButton *)sender {
    
    self.selectTimeBlock(sender);
}

//选择结束时间
- (IBAction)endTimeClick:(UIButton *)sender {
    self.selectTimeBlock(sender);
}

@end

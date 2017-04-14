//
//  WGDatePickView.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/9.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "WGDatePickView.h"
#import "UIColor+HexString.h"
@interface WGDatePickView()
@property (nonatomic, strong) NSString *selectDate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@end
@implementation WGDatePickView

+ (instancetype)instanceDatePickView {
    
    return [[NSBundle mainBundle] loadNibNamed:@"WGDatePickView" owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelBtn.layer.cornerRadius = 4;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.borderColor = [[UIColor colorWithHexString:@"BAB9B9"] CGColor];
    self.cancelBtn.layer.masksToBounds = YES;
    
    self.sureBtn.layer.cornerRadius = 4;
    self.sureBtn.layer.borderWidth = 1;
    self.sureBtn.layer.borderColor = [[UIColor colorWithHexString:@"37C3A9"] CGColor];
    self.sureBtn.layer.masksToBounds = YES;

}

- (NSString *)timeFormat {
    NSDate *selectsd = [self.datePickView date];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDate = [formater stringFromDate:selectsd];
    return selectDate;
}
//取消按钮
- (IBAction)cancelBtnClick:(UIButton *)btn {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
//确定按钮
- (IBAction)sureBtnClick:(UIButton *)btn {
    self.selectDate = [self timeFormat];
    [self.delegate getSelectDate:self.selectDate type:self.type];
    [self cancelBtnClick:nil];
}

@end

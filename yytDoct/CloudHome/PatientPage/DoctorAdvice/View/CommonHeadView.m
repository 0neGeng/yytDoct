//
//  CommonHeadView.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "CommonHeadView.h"
#import "InspectionResultDetailVC.h"
@interface CommonHeadView ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *bedNum;

@property (weak, nonatomic) IBOutlet UILabel *beginTime;

@property (weak, nonatomic) IBOutlet UILabel *outTime;
@property (weak, nonatomic) IBOutlet UILabel *sex;


@property (weak, nonatomic) IBOutlet UILabel *doctor;
@property (weak, nonatomic) IBOutlet UILabel *reportTime;
@property (weak, nonatomic) IBOutlet UILabel *leftDoctor;
@property (weak, nonatomic) IBOutlet UILabel *leftReportTime;



@property (weak, nonatomic) IBOutlet UILabel *hospitalNum;


@end
@implementation CommonHeadView

+ (instancetype)shareHeadView {
    return [[NSBundle mainBundle] loadNibNamed:@"CommonHeadView" owner:self options:nil].lastObject;
}

- (void)setIsHidden:(BOOL)isHidden {
    self.doctor.hidden = isHidden;
    self.reportTime.hidden = isHidden;
    self.leftDoctor.hidden = isHidden;
    self.leftReportTime.hidden = isHidden;
}
/*
 "admission_no" = 0069532;
 "bed_no" = 042;
 "in_date" = "2016-09-30";
 "medical_status" = 0;
 "out_date" = "";
 "pat_birth" = 70;
 "pat_card_no" = "";
 "pat_card_type" = 5;
 "pat_name" = "\U66fe\U65b0\U6dfb";
 "pat_sex" = 0;
 住院状态 0住院 1出院
 0男1女
 */
- (void)setDataDict:(NSDictionary *)dataDict {
    self.name.text = dataDict[@"pat_name"];
    self.age.text = dataDict[@"pat_birth"];
    self.bedNum.text = dataDict[@"bed_no"];
    self.beginTime.text = dataDict[@"in_date"];
    self.outTime.text = dataDict[@"out_date"];
    self.department.text = dataDict[@"dept_name"];
    if ([dataDict[@"pat_sex"] isEqualToString:@"1"]) {
        self.sex.text = @"女";
    }else if([dataDict[@"pat_sex"] isEqualToString:@"0"]){
    self.sex.text = @"男";
    }else{}
    self.hospitalNum.text = dataDict[@"admission_no"];
  
}

- (void)setDataWithDict:(NSDictionary *)dict FromController:(UIViewController *)vc {
    if ([vc isKindOfClass:[InspectionResultDetailVC class]]) {
        
        self.name.text = dict[@"pat_name"];
        self.age.text = dict[@"pat_birth"];
        self.bedNum.text = dict[@"bed_no"];
        self.beginTime.text = dict[@"in_date"];
        self.outTime.text = dict[@"out_date"];
        self.doctor.text = dict[@"doctorName"];
        self.reportTime.text = dict[@"reportTime"];
        self.hospitalNum.text = dict[@"admission_no"];
        self.department.text = dict[@"deptName"];
        if ([dict[@"pat_sex"] isEqualToString:@"1"]) {
            self.sex.text = @"女";
        }else{
            self.sex.text = @"男";
        }
                                    
                                    
    }
}
// "admission_no" = 0071790;
//"bed_no" = 002;
//"in_date" = "2017-01-09";
//"medical_status" = 0;
//"out_date" = "";
//"pat_birth" = 86;
//"pat_card_no" = 441622193107045477;
//"pat_card_type" = 5;
//"pat_name" = "\U9ec4\U8d5e\U7ae0";
//"pat_sex" = 0;
@end

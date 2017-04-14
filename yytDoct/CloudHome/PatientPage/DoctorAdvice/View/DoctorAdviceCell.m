//
//  DoctorAdviceCell.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DoctorAdviceCell.h"
@interface DoctorAdviceCell()
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;

@property (weak, nonatomic) IBOutlet UILabel *bedNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *inHospitalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *outHospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordID;

@end
@implementation DoctorAdviceCell
+ (instancetype)doctAdviceCellWithTableView:(UITableView *)tableView {
    DoctorAdviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoctorAdviceCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DoctorAdviceCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

/*
 {
 "bed_no" = 042;
 "dept_code" = 02550102;
 "dept_name" = "\U9aa8\U4e00\U79d1";
 "doctor_code" = 0061;
 "doctor_name" = "\U9648\U9038\U5065";
 "in_date" = "2016-09-30";
 "out_date" = "";
 "record_id" = 00695321;
 "total_fee" = 3295461;
 }
 */
- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
     NSString *bedNum = dataDict[@"bed_no"];
    if (bedNum.length > 0) {
        _bedNumLabel.text = dataDict[@"bed_no"];
        _departmentLabel.text = dataDict[@"dept_name"];
        _inHospitalTimeLabel.text = dataDict[@"in_date"];
        NSString *outTime = dataDict[@"out_date"];
        if (dataDict[@"out_date"] == NULL || outTime.length == 0) {
            _outHospitalLabel.text = @"----";
        }else {
            _outHospitalLabel.text = dataDict[@"out_date"];
        }
    }else {
       self.recordID.text = @"病案号";
        self.departmentLabel.text = dataDict[@"dept_name"];
        self.bedNumLabel.text = dataDict[@"record_id"];
        self.inHospitalTimeLabel.text = dataDict[@"record_date"];
         _outHospitalLabel.text = @"----";
        
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

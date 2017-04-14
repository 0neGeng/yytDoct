//
//  InspectionResultCell.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/7.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InspectionResultCell : UITableViewCell

@property(strong ,nonatomic) NSDictionary *dataDict;
@property(strong ,nonatomic) NSDictionary *dataDictTwo;
+ (instancetype)InspectionResultCellWithTableView:(UITableView *)tableView;
@end
/*
 dataDict:
 deptName = "\U6025\U8bca\U79d1(\U95e8\U8bca)";
 doctorCode = 0380;
 doctorName = "\U90d1\U65b0\U6ce2";
 fileAddress = "";
 inspectDoctor = "\U9a86\U5e73\U8f89";
 inspectId = 0000373960;
 inspectName = "\U65e5\U7acb7600";
 inspectTime = "2016-12-15 09:11:54";
 provingTime = "2016-12-15 09:55:07";
 reportTime = "2016-12-15 11:28:50";
 reservedFieldFive = "<null>";
 reservedFieldFour = "<null>";
 reservedFieldOne = "<null>";
 reservedFieldThree = "<null>";
 reservedFieldTwo = "<null>";
 verifyDoctor = "\U9a86\U5e73\U8f89";
 verifyTime = "2016-12-15 11:28:50";
 
 dataDictTwo:
 
 "admission_no" = 0071790;
 "bed_no" = 002;
 "in_date" = "2017-01-09";
 "medical_status" = 0;
 "out_date" = "";
 "pat_birth" = 86;
 "pat_card_no" = 441622193107045477;
 "pat_card_type" = 5;
 "pat_name" = "\U9ec4\U8d5e\U7ae0";
 "pat_sex" = 0;
 
 */

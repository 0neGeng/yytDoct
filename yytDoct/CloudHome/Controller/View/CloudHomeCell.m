//
//  CloudHomeCell.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "CloudHomeCell.h"
@interface CloudHomeCell ()
//名字
@property (weak, nonatomic) IBOutlet UILabel *name;
//科室
@property (weak, nonatomic) IBOutlet UILabel *department;
//医院号
@property (weak, nonatomic) IBOutlet UILabel *hospitalNum;
//床位号
@property (weak, nonatomic) IBOutlet UILabel *bedNum;
@end

@implementation CloudHomeCell

+ (instancetype)cloudHomeCellWithTableView:(UITableView *)tableView {
    CloudHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cloudHomeCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CloudHomeCell" owner:self options:nil].lastObject;
    }
    return cell;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**
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
 */

- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    _name.text = dataDict[@"pat_name"];
//    _department.text = self.departmentStr;
    _hospitalNum.text = dataDict[@"admission_no"];
    _bedNum.text = dataDict[@"bed_no"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

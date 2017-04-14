//
//  DoctorListCell.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/16.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DoctorListCell.h"
@interface DoctorListCell()
@property (weak, nonatomic) IBOutlet UILabel *doctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *doctorIDLabel;
   //doctor_name//doctor_no
@end
@implementation DoctorListCell
+ (instancetype)doctorListCellWithTableView:(UITableView *)tableView
{
    DoctorListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"doctorListCell"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DoctorListCell" owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)setDataDict:(NSDictionary *)dataDict {

    _dataDict = dataDict;
    _doctorLabel.text = dataDict[@"doctor_name"];
    _doctorIDLabel.text = dataDict[@"doctor_no"];
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

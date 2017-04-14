//
//  InspectionResultCell.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/7.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "InspectionResultCell.h"
@interface InspectionResultCell()
@property (weak, nonatomic) IBOutlet UILabel *hospitalNum;
@property (weak, nonatomic) IBOutlet UILabel *bedNum;
@property (weak, nonatomic) IBOutlet UILabel *reportName;
@property (weak, nonatomic) IBOutlet UILabel *reportTime;

@end
@implementation InspectionResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    self.reportName.text = dataDict[@"inspectName"];
    self.reportTime.text = dataDict[@"reportTime"];

}

- (void)setDataDictTwo:(NSDictionary *)dataDictTwo {
    _dataDictTwo = dataDictTwo;
    self.hospitalNum.text = dataDictTwo[@"admission_no"];
    self.bedNum.text = dataDictTwo[@"bed_no"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}
+ (instancetype)InspectionResultCellWithTableView:(UITableView *)tableView {
    InspectionResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InspectionResultCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"InspectionResultCell" owner:nil options:nil].lastObject;
    }
    return cell;
}
@end

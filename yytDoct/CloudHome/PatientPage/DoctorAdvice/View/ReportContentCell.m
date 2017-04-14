//
//  ReportContentCell.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/5.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "ReportContentCell.h"
@interface ReportContentCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLable;
@property (weak, nonatomic) IBOutlet UILabel *consultLable;

@end
@implementation ReportContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)reportContentCellWithTableView:(UITableView *)tableView{
    ReportContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportContentCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ReportContentCell" owner:nil options:nil].lastObject;
    }
    return cell;
}

- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    _nameLabel.text = dataDict[@"itemName"];
    _resultLable.text = dataDict[@"result"];
    _consultLable.text = dataDict[@"refRange"];

    _nameLabel.textColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    _resultLable.textColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    _consultLable.textColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    
}

- (void)setIndexOneTitle {
    _nameLabel.text = @"项目";
    _resultLable.text = @"结果";
    _consultLable.text = @"参考";
    
    _consultLable.textColor =  _resultLable.textColor = _nameLabel.textColor = _nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
}
@end

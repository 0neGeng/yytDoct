//
//  AdviceDetailCell.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "AdviceDetailCell.h"
@interface AdviceDetailCell()
//name
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//用量
@property (weak, nonatomic) IBOutlet UILabel *itemUnit;
//途径
@property (weak, nonatomic) IBOutlet UILabel *itemUse;
//时间
@property (weak, nonatomic) IBOutlet UILabel *itemFrequen;

@end
@implementation AdviceDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)shareAdviceDetailCell:(UITableView *)tableView {
    AdviceDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdviceDetailCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AdviceDetailCell" owner:self options:nil].lastObject;
    }
    return cell;
}

/*
 {
 "item_frequency" = qd;//
 "item_name" = "\U87ba\U65cb\U5200\U7247\U5f0f\U9ad3\U5185\U9489";
 "item_unit" = 1;
 "item_use" = "";
 }
 */
- (void)setDataDict:(NSDictionary *)dataDict {
    _dataDict = dataDict;
    _nameLabel.text = dataDict[@"item_name"];
    _itemUnit.text = dataDict[@"item_unit"];
    _itemUse.text = dataDict[@"item_use"];
    _itemFrequen.text = dataDict[@"item_frequency"];
    _nameLabel.textColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    _itemUnit.textColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    _itemUse.textColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    _itemFrequen.textColor = [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1.0];
    
}

- (void)setIndexOneTitle {
    _nameLabel.text = @"医嘱名称";
    _itemUnit.text = @"每次用量";
    _itemUse.text = @"用药途径";
    _itemFrequen.text = @"用法";
  _itemFrequen.textColor = _itemUse.textColor = _itemUnit.textColor = _nameLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
}
@end

//
//  DenNewCell.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/9.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "DenNewCell.h"
@interface DenNewCell()


@end
@implementation DenNewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)instanceDenNewCell:(UITableView *)tb{
    DenNewCell *cell = [tb dequeueReusableCellWithIdentifier:@"DenNewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"DenNewCell" owner:self options:nil].lastObject;
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

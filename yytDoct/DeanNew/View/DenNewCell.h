//
//  DenNewCell.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/9.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DenNewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

+ (instancetype)instanceDenNewCell:(UITableView *)tb;
@end

//
//  AdviceDetailCell.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceDetailCell : UITableViewCell

@property(strong ,nonatomic) NSDictionary *dataDict;;
+ (instancetype)shareAdviceDetailCell:(UITableView *)tableView;

- (void)setIndexOneTitle;
@end

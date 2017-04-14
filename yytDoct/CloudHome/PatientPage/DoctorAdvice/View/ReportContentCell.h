//
//  ReportContentCell.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/5.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportContentCell : UITableViewCell
+ (instancetype)reportContentCellWithTableView:(UITableView *)tableView;
@property(strong ,nonatomic) NSDictionary *dataDict;
- (void)setIndexOneTitle;
@end

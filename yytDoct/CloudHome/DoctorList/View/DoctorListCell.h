//
//  DoctorListCell.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/16.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorListCell : UITableViewCell
+ (instancetype)doctorListCellWithTableView:(UITableView *)tableView;
@property(strong ,nonatomic) NSDictionary *dataDict;
@end

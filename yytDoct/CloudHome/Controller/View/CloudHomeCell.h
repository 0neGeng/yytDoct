//
//  CloudHomeCell.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudHomeCell : UITableViewCell

@property(nonatomic, strong) NSDictionary *dataDict;


+ (instancetype)cloudHomeCellWithTableView:(UITableView *)tableView;
@end

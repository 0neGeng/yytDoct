//
//  AdviceListVC.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceListVC : UITableViewController
@property(strong ,nonatomic) NSDictionary *dataDict;
@property(strong ,nonatomic) NSString *leftStr;

//科室
@property(strong ,nonatomic) NSString *departmentStr;
@property(strong ,nonatomic) NSString *titleStr;
@property(strong ,nonatomic) NSString *record_id;
@end

//
//  AdviceDetail.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdviceDetail : UITableViewController
@property(strong ,nonatomic) NSString *titleStr;
@property(strong ,nonatomic) NSDictionary *dataDict;
/**点击的列数*/
@property (assign, nonatomic) NSInteger index;
//科室
@property(strong ,nonatomic) NSString *departmentStr;
@end

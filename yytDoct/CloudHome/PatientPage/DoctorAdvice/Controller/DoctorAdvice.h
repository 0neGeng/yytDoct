//
//  DoctorAdvice.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorAdvice : UITableViewController
@property(strong ,nonatomic) NSDictionary *dictData;
@property(strong ,nonatomic) NSArray *inHospitalArray;
@property(strong ,nonatomic) NSString *record_id;
@property(strong ,nonatomic) NSString *titleStr;
@end

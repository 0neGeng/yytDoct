//
//  PatientRecord.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/7.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientRecord : UITableViewController

@property(strong ,nonatomic) NSString *titleStr;
@property(strong ,nonatomic) NSDictionary *dataDict;
@property(strong ,nonatomic) NSString *record_id;
@end

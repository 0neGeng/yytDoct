//
//  CommonHeadView.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonHeadView : UIView
+ (instancetype)shareHeadView;
/** 科室 */
@property (weak, nonatomic) IBOutlet UILabel *department;
@property(strong ,nonatomic) NSDictionary *dataDict;
@property(assign, nonatomic) BOOL isHidden;
- (void)setDataWithDict:(NSDictionary *)dict FromController:(UIViewController *)vc;
@end

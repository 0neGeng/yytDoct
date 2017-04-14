//
//  DoctorAdviceHeadView.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/6.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorAdviceHeadView : UIView
+ (instancetype)shareHeadView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end

//
//  DeanNewView.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/9.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeanNewView : UIView
@property (weak, nonatomic) IBOutlet UIButton *beginTime;
@property (weak, nonatomic) IBOutlet UIButton *endTime;

@property(nonatomic, copy)void(^selectTimeBlock)(UIButton *tag);
@property (weak, nonatomic) IBOutlet UILabel *peopleNum;
+ (instancetype)instanceHeadView;
@end

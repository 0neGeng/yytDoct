//
//  WGDatePickView.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/9.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    // 开始日期
    DateTypeOfStart = 0,
    
    // 结束日期
    DateTypeOfEnd,
    
}DateType;

@protocol WGDatePickViewDelegate <NSObject>

- (void)getSelectDate:(NSString *)date type:(DateType)type;

@end

@interface WGDatePickView : UIView
+ (instancetype)instanceDatePickView;

@property(nonatomic, weak) id<WGDatePickViewDelegate>delegate;

@property (nonatomic, assign) DateType type;
@end

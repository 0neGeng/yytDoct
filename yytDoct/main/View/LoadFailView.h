//
//  LoadFailView.h
//  yyt
//
//  Created by Yunyi on 16/5/25.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadFailView : UIView

@property (nonatomic, copy) void(^reLoadData)();

+(instancetype)loadFailView;
- (void)setImgView:(NSString *)iconName :(NSString *)title :(NSString *)subTitle;

@end

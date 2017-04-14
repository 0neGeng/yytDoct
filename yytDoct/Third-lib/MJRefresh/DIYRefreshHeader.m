//
//  DIYRefreshHeader.m
//  yyt
//
//  Created by WangGeng on 16/8/11.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import "DIYRefreshHeader.h"

@implementation DIYRefreshHeader

-(void)prepare
{
    [super prepare];
    

    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim_00%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    self.lastUpdatedTimeLabel.textColor = WGColor(102, 102, 102, 1);
    self.stateLabel.textColor = WGColor(102, 102, 102, 1);
  
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=29; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim_00%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStatePulling];

    
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];

    
}

-(void)placeSubviews
{
    [super placeSubviews];
    self.gifView.contentMode =UIViewContentModeLeft;
    self.gifView.wg_x = YYTScreenW/2 - 30 - 10 - 39;//39图片的爱宽度  20=间距 30 = 文字对齐
    self.stateLabel.textAlignment = NSTextAlignmentLeft;
    self.stateLabel.wg_x = YYTScreenW/2 - 30;
    self.lastUpdatedTimeLabel.textAlignment = NSTextAlignmentLeft;
    self.lastUpdatedTimeLabel.wg_x = YYTScreenW/2 - 30;

}
@end

//
//  AboutYYTView.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/22.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "AboutYYTView.h"
@interface AboutYYTView ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@end
@implementation AboutYYTView

- (void)awakeFromNib {
    [super awakeFromNib];
        CGRect rect = [[NSString stringWithFormat:@"%@%@%@%@",_label1.text,_label2.text,_label3.text,_label4.text] boundingRectWithSize:CGSizeMake(YYTScreenW - 28, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil];//60
    self.ViewHeight = rect.size.height + 160;
}
+ (instancetype)aboutViewForXib {
    AboutYYTView *view =  [[NSBundle mainBundle] loadNibNamed:@"AboutYYTView" owner:self options:nil].lastObject;
    return view;
}
@end

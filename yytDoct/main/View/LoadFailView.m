//
//  LoadFailView.m
//  yyt
//
//  Created by Yunyi on 16/5/25.
//  Copyright © 2016年 yunyiChina. All rights reserved.
//

#import "LoadFailView.h"
#import "UIView+Frame.h"

@interface LoadFailView()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;

@end

@implementation LoadFailView

+(instancetype)loadFailView{
    return [[NSBundle mainBundle] loadNibNamed:@"LoadFailView" owner:nil options:nil].firstObject;
}
- (IBAction)reloadClick:(id)sender {
    if (_reLoadData) {
        _reLoadData();
    }
}

- (void)setImgView:(NSString *)iconName :(NSString *)title :(NSString *)subTitle
{
    UIImage *img = [UIImage imageNamed:iconName];
    _imgView.image = img;
    _imgWidth.constant = img.size.width;
    _imgHeight.constant = img.size.height;
    _titleLable.text = title;
    _subTitleLable.text = subTitle;
}

@end

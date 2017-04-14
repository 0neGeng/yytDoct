//
//  GlobalConst.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/5.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "UIView+Frame.h"
extern NSString *const BaseUrl;
extern NSString *const listUrl;

#define CommonColor [UIColor colorWithRed:11/255.0 green:184/255.0 blue:135/255.0 alpha:1]
NSString * encodeToPercentEscapeString(NSString *input);
AFHTTPSessionManager *shareCustomManager();

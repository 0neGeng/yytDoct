//
//  GlobalConst.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/5.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "GlobalConst.h"
//新平台测试环境
//NSString *const BaseUrl = @"https://120.76.100.27";
//NSString *const BaseUrl   = @"https://192.168.1.66:88";//张得
//旧平台测试环境 科室主任0155 密码0155
//NSString *const listUrl = @"http://test.yunyichina.cn:9090/";


//正式环境
//新平台
NSString *const BaseUrl = @"https://api.yunyichina.cn";
////旧平台
NSString *const listUrl = @"http://app.yunyichina.cn/";


NSString * encodeToPercentEscapeString(NSString *input){
    
    NSString * encodeString = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return encodeString;
}


AFHTTPSessionManager *shareCustomManager() {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    manager.securityPolicy = securityPolicy;
   
    return manager;
}

//
//  UserInfo.h
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "WGMenuItem.h"
@interface UserInfo : NSObject

singleton_interface(UserInfo);

/**
 *  医生id
 */
@property (nonatomic, copy) NSString *doctID;
/**
 *  登录密码
 */
@property (nonatomic, copy) NSString *passWord;
/**
 *  userID
 */
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *cardNo;
@property (nonatomic, assign) int cardType;
@property (nonatomic, copy) NSString *doctName;
@property (nonatomic, copy) NSString *hospital_code;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *encryptedMobile;
@property (nonatomic, copy) NSString *encryptedCardNo;
@property (nonatomic, copy) NSString *encryptedAccount;
@property (nonatomic, copy) NSString *inviteCode;
@property(assign ,nonatomic) NSInteger menuItem;

/**
 *  用户登录时 储存下来的NSDate
 */
@property (nonatomic, copy) NSDate * oldDate;

/**
 *  从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox;

/**
 *  保存用户数据到沙盒
 
 */
-(void)saveUserInfoToSanbox;



- (void)removeUserInfoFroSanbox; //移除



@end

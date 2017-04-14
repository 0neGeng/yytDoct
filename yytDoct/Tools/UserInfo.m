//
//  UserInfo.m
//  yytDoct
//
//  Created by WangGeng on 2017/1/4.
//  Copyright © 2017年 WangGeng. All rights reserved.
//

#import "UserInfo.h"

#define UserKey         @"user"
#define PwdKey          @"pwd"
#define UserId          @"useId"
#define UserCardNo      @"cardNo"
#define UserCardType    @"cardType"
#define UserName        @"name"
#define UserMobile      @"mobile"
#define UserAddress     @"address"
#define HospitalCode     @"HospitalCode"
#define UserencryptedMobile     @"encryptedMobile"
#define UserencryptedCardNo     @"encryptedCardNo"
#define UserencryptedAccount     @"encryptedAccount"
#define OldDate         @"oldDate"
#define InviteCode      @"inviteCode"
#define MenuItem      @"MenuItem"

@implementation UserInfo

singleton_implementation(UserInfo)

-(void)saveUserInfoToSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.doctID forKey:UserKey];
    [defaults setObject:self.passWord forKey:PwdKey];
    [defaults setObject:self.userId forKey:UserId];
    [defaults setObject:self.cardNo forKey:UserCardNo];
    [defaults setObject:@(self.cardType) forKey:UserCardType];
    [defaults setObject:self.doctName forKey:UserName];
    [defaults setObject:self.mobile forKey:UserMobile];
    [defaults setObject:self.address forKey:UserAddress];
    [defaults setObject:self.encryptedMobile forKey:UserencryptedMobile];
    [defaults setObject:self.encryptedCardNo forKey:UserencryptedCardNo];
    [defaults setObject:self.encryptedAccount forKey:UserencryptedAccount];
    [defaults setObject:self.oldDate forKey:OldDate];
    [defaults setObject:self.inviteCode forKey:InviteCode];
    [defaults setObject:self.hospital_code forKey:HospitalCode];
    [defaults setObject:@(self.menuItem) forKey:MenuItem];
    [defaults synchronize];
    
}

-(void)loadUserInfoFromSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.doctID = [defaults objectForKey:UserKey];
    self.passWord = [defaults objectForKey:PwdKey];
    self.userId = [defaults objectForKey:UserId];
    self.cardNo = [defaults objectForKey:UserCardNo];
    self.cardType = [[defaults objectForKey:UserCardType] intValue];
    self.doctName = [defaults objectForKey:UserName];
    self.mobile = [defaults objectForKey:UserMobile];
    self.address = [defaults objectForKey:UserAddress];
    self.encryptedMobile = [defaults objectForKey:UserencryptedMobile];
    self.encryptedCardNo = [defaults objectForKey:UserencryptedCardNo];
    self.encryptedAccount = [defaults objectForKey:UserencryptedAccount];
    self.oldDate = [defaults objectForKey:OldDate];
    self.inviteCode = [defaults objectForKey:InviteCode];
    self.hospital_code = [defaults objectForKey:HospitalCode];
    self.menuItem = [[defaults objectForKey:MenuItem] intValue];
}


- (void)removeUserInfoFroSanbox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:UserKey];
    [defaults removeObjectForKey:PwdKey];
    [defaults removeObjectForKey:UserId];
    [defaults removeObjectForKey:UserCardType];
    [defaults removeObjectForKey:UserCardNo];
    [defaults removeObjectForKey:UserMobile];
    [defaults removeObjectForKey:UserName];
    [defaults removeObjectForKey:OldDate];
    [defaults removeObjectForKey:InviteCode];
    [defaults removeObjectForKey:HospitalCode];
    [defaults removeObjectForKey:MenuItem];
}


@end

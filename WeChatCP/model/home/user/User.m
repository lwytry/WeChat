//
//  User.m
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "User.h"
#import "NSString+PinYin.h"
#import <MJExtension/MJExtension.h>
#import "Macro.h"

static User *user;

@implementation User

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
        @"userId": @"id",
        @"userName":@"username",
        @"wechatId":@"identifier",
        @"avatarPath":@"avatarPath",
        @"phone":@"phone",
    };
}

- (void)setUserName:(NSString *)userName
{
    if (userName) {
        _userName = userName;
        _pinyin = _userName.pinyin;
    }
}

- (NSString *)avatarURL
{
    if (_avatarURL == nil)
    {
        _avatarURL = [FILE_SERVER_DOMAIN_NAME stringByAppendingString:_avatarPath];
    }
    return _avatarURL;
}

@end

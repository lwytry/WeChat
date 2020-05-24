//
//  UserHelper.m
//  WeChatCP
//
//  Created by lwy on 2020/5/20.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper

@synthesize user = _user;

+ (UserHelper *)sharedHelper
{
    static UserHelper *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[UserHelper alloc] init];
    });
    return helper;
}

- (void)setUser:(User *)user
{
    _user = user;
}

- (User *)user
{
    if (!_user) {
        _user = [[User alloc] init];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSDictionary *userInfo = [userDefault objectForKey:@"userInfo"];
        _user.userId = userInfo[@"id"];
        _user.userName = userInfo[@"username"];
        _user.avatarPath = userInfo[@"avatarPath"];
        _user.wechatId = userInfo[@"identifier"];
    }
    return _user;
}

- (NSString *)userId
{
    return self.user.userId;
}

- (NSString *)token
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"token"];
    return token;
}

- (BOOL)isLogin
{
    return self.token.length > 0;
}

@end

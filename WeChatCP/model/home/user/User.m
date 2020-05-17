//
//  User.m
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "User.h"

static User *user;

@implementation User

+ (User *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        user = [[User alloc] init];
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        NSDictionary *userInfo = [userDefault objectForKey:@"userInfo"];
        user.userID = userInfo[@"id"];
        user.name = userInfo[@"username"];
        user.avatarPath = userInfo[@"avatarPath"];
        user.wechatId = userInfo[@"identifier"];
    });
    return user;
}


@end

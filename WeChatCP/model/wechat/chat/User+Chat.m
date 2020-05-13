//
//  User+Chat.m
//  WeChatCP
//
//  Created by lwy on 2020/5/7.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "User+Chat.h"

@implementation User (Chat)

- (NSString *)chat_userID
{
    return self.userID;
}

- (NSString *)chat_username
{
    return self.name;
}

- (NSString *)chat_avatarURL
{
    return self.avatarURL;
}

- (NSString *)chat_avatarPath
{
    return self.avatarPath;
}

- (NSInteger)chat_userType
{
    return ChatUserTypeUser;
}

@end

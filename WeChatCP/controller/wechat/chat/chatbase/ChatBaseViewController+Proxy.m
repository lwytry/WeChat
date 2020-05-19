//
//  ChatBaseViewController+Proxy.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+Proxy.h"
#import "ChatBaseViewController+MessageDisplayView.h"
#import "User.h"
#import "User+Chat.h"


@implementation ChatBaseViewController (Proxy)

- (void)sendMessage:(Message *)message
{
    message.ownerTyper = MessageOwnerTypeSelf;
    message.date = [NSDate date];
    message.userID = [User sharedInstance].userID;
    if ([self.partner chat_userType] == ChatUserTypeUser) {
        message.partnerType = PartnerTypeUser;
        message.dstID = [self.partner chat_userID];
    }
    NSNumber *insertId = [[MessageManager sharedInstance] addMessageStore:message];
    message.ID = insertId;
    [self addToShowMessage:message];
    [[MessageManager sharedInstance] sendMessage:message progress:^(Message *message, CGFloat progress) {
        
    } success:^(Message *message) {
        NSLog(@"sendsuccess");
    } failure:^(Message *message) {
        NSLog(@"sendfail");
    }];
}

// 未接受消息
- (void)didReceivedMessage:(Message *)message
{
    if ([message.dstID isEqualToString:self.user.chat_userID]) {
        
        [self addToShowMessage:message];
    }
}

@end

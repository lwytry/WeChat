//
//  ChatBaseViewController+Proxy.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+Proxy.h"
#import "ChatBaseViewController+MessageDisplayView.h"
#import "UserHelper.h"
#import "ContactHelper.h"
#import "User+Chat.h"
#import "MessageManager+ConversationRecord.h"
#import "ChatBaseViewController+WebRTC.h"


@implementation ChatBaseViewController (Proxy)

- (void)sendMessage:(Message *)message
{
    message.ownerTyper = MessageOwnerTypeSelf;
    message.date = [NSDate date];
    message.fromUser = self.user;
    message.userID = self.user.chat_userID;
    message.dstID = self.partner.chat_userID;
    
    if ([self.partner chat_userType] == ChatUserTypeUser) {
        message.partnerType = PartnerTypeUser;
        message.dstID = [self.partner chat_userID];
    }
    NSNumber *insertId = [[MessageManager sharedInstance] addMessageStore:message];
    [[MessageManager sharedInstance] addConversationByMessage:message];
    [[MessageManager sharedInstance] updateConversationUnread:message.dstID unreadCount:0];
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
    if ([message.dstID isEqualToString:self.partner.chat_userID]) {
        User *user = [[ContactHelper sharedContactHelper] getContactInfoByUserId:message.dstID];
        message.fromUser = user;
        [self addToShowMessage:message];
        [[MessageManager sharedInstance] updateConversationUnread:message.dstID unreadCount:0];
        if (message.messageType == MessageTypeWebRTC) {
            [self launchRTCWithMessage:message];
        }
    }
}

@end

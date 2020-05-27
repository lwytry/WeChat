//
//  WeChatViewController+Proxy.m
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ConversationController+Proxy.h"
#import "ContactHelper.h"
#import "MessageManager+ConversationRecord.h"



@implementation ConversationController (Proxy)

- (void)didReceivedMessage:(Message *)message
{
    // 如果没有会话 新增
    BOOL isExist = [self isExistConversation:message.dstID];
    Conversation *conv = [[Conversation alloc] init];
    if (isExist) {
        conv.content = [message conversationContent];
        conv.unreadCount = [[MessageManager sharedInstance] unreadMessageByUId:message.dstID];
        conv.date = message.date;
        conv.dstID = message.dstID;
        [self updateConvList:conv];
    } else {
        User *user = [[ContactHelper sharedContactHelper] getContactInfoByUserId:message.dstID];
        conv.dstID = message.dstID;
        conv.dstName = user.userName;
        conv.avatarURL = user.avatarURL;
        conv.convType = message.partnerType == PartnerTypeUser ? ConversationTypePersonal : ConversationTypeGroup;
        conv.content = [message conversationContent];
        conv.unreadCount = 1;
        conv.date = message.date;
        [self addConversation:conv];
    }
}

@end

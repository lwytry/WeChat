//
//  MessageManager+ConversationRecord.m
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager+ConversationRecord.h"

@implementation MessageManager (ConversationRecord)

- (BOOL)addConversationByMessage:(Message *)message
{
    NSInteger type = 0;
    if (message.partnerType == PartnerTypeGroup) {
        type = 1;
    }
    
    BOOL ok = NO;
    if (![self.conversationStore isExistConversation:message.dstID]) {
        ok = [self.conversationStore addConversationByUId:message.dstID type:type date:message.date];
    } else {
        ok = [self.conversationStore updateConversationByUId:message.dstID date:message.date];
    }
    return ok;
}

- (void)conversationRecord:(void (^)(NSArray *))complete
{
    NSArray *data = [self.conversationStore conversationGetAll];
    complete(data);
}

- (BOOL)updateConversationUnread:(NSString *)uId unreadCount:(NSInteger)unreadCount
{
    return [self.conversationStore updateConversationUnread:uId unreadCount:unreadCount];
}

- (NSInteger)unreadMessageByUId:(NSString *)uId
{
    return [self.conversationStore unreadMessageByUId:uId];
}

- (BOOL)deleteConversationByUserId:(NSString *)userId
{
    return YES;
}

@end

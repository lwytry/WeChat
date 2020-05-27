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
    NSInteger unread = [self.conversationStore unreadMessageByUId:message.dstID];
    BOOL ok = NO;
    if (unread == 0) {
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

- (NSInteger)unreadMessageByUId:(NSString *)uId
{
    return [self.conversationStore unreadMessageByUId:uId];
}

- (BOOL)deleteConversationByUserId:(NSString *)userId
{
    return YES;
}

@end

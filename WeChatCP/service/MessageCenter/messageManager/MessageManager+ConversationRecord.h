//
//  MessageManager+ConversationRecord.h
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager.h"

@interface MessageManager (ConversationRecord)

- (BOOL)addConversationByMessage:(Message *)message;

- (void)conversationRecord:(void (^)(NSArray *))complete;

- (BOOL)deleteConversationByUserId:(NSString *)userId;

/**
 *  未读消息条数
 */
- (NSInteger)unreadMessageByUId:(NSString *)uId;

@end

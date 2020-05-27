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

- (BOOL)updateConversationUnread:(NSString *)uId unreadCount:(NSInteger)unreadCount;

- (BOOL)deleteConversationByUserId:(NSString *)userId;

- (NSInteger)unreadMessageByUId:(NSString *)uId;

@end

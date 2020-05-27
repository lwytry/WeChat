//
//  ConversationStore.h
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "DBBaseStore.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationStore : DBBaseStore

/**
 *  未读消息条数
 */
- (NSInteger)unreadMessageByUId:(NSString *)uId;

/**
 *  新的会话（未读）
 */
- (BOOL)addConversationByUId:(NSString *)uId type:(NSInteger)type date:(NSDate *)date;

/**
 *  更新会话状态（已读）
 */
- (BOOL)updateConversationByUId:(NSString *)uId date:(NSDate *)date;

/**
 *  查询所有会话
 */
- (NSArray *)conversationGetAll;

/**
 *  删除单条会话
 */
- (BOOL)deleteConversationByUId:(NSString *)uId;

@end

NS_ASSUME_NONNULL_END

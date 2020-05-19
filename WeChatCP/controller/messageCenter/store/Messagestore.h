//
//  Messagestore.h
//  WeChatCP
//
//  Created by lwy on 2020/5/19.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "DBBaseStore.h"
#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface Messagestore : DBBaseStore
#pragma mark - 添加
/**
 *  添加消息记录 返回插入id
 */
- (NSNumber *)addMessageRetID:(Message *)message;

#pragma mark - 查询
/**
 *  获取与某个好友的聊天记录
 */
- (void)messagesByDstID:(NSString *)userID
                dstId:(NSString *)dstId
                count:(NSUInteger)count
                complete:(void (^)(NSArray *data, BOOL hasMore))complete;
@end

NS_ASSUME_NONNULL_END

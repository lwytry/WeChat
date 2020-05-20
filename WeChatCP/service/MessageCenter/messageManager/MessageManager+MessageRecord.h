//
//  MessageManager+MessageRecord.h
//  WeChatCP
//
//  Created by lwy on 2020/5/19.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageManager (MessageRecord)
/**
 *  查询聊天记录
 */
- (void)messageRecordForDstId:(NSString *)dstId
                       fromDate:(NSDate *)date
                          count:(NSUInteger)count
                       complete:(void (^)(NSArray *, BOOL))complete;
@end

NS_ASSUME_NONNULL_END

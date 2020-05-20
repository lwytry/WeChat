//
//  MessageManager+MessageRecord.m
//  WeChatCP
//
//  Created by lwy on 2020/5/19.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager+MessageRecord.h"

@implementation MessageManager (MessageRecord)

- (void)messageRecordForDstId:(NSString *)dstId
                     fromDate:(NSDate *)date
                        count:(NSUInteger)count
                     complete:(void (^)(NSArray *, BOOL))complete
{
    [self.messageStore messagesByUserID:self.userId dstId:dstId count:count complete:^(NSArray * _Nonnull data, BOOL hasMore) {
        complete(data, hasMore);
    }];
}

@end

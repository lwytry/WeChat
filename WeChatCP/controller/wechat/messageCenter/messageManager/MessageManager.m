//
//  MessageManager.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager.h"

static MessageManager *messageManager;

@implementation MessageManager

+ (MessageManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        messageManager = [[MessageManager alloc] init];
    });
    return messageManager;
}

- (void)sendMessage:(Message *)message progress:(void (^)(Message *, CGFloat))progress success:(void (^)(Message *))success failure:(void (^)(Message *))failure
{
    // 发送消息
    
    NSLog(@"Messagemanager send message");
    // 存储数据库
    
}

#pragma mark - # Private
- (BOOL)p_sendMessage:(Message *)message
{
    NSLog(@"p_sendMessage");
    return YES;
}

@end

//
//  ChatBaseViewController+Proxy.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+Proxy.h"

@implementation ChatBaseViewController (Proxy)

- (void)sendMessage:(Message *)message
{
    message.ownerTyper = MessageOwnerTypeSelf;
//    message.userID =
//    message.fromUser =
    message.date = [NSDate date];
    [[MessageManager sharedInstance] sendMessage:message progress:^(Message *message, CGFloat progress) {
        
    } success:^(Message *message) {
        NSLog(@"sendsuccess");
    } failure:^(Message *message) {
        NSLog(@"sendfail");
    }];
}

- (void)didReceivedMessage:(id)message
{
    
}

@end

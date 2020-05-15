//
//  ChatBaseViewController+Proxy.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+Proxy.h"
#import "ChatBaseViewController+MessageDisplayView.h"
#import "User.h"
#import "User+Chat.h"


@implementation ChatBaseViewController (Proxy)

- (void)sendMessage:(Message *)message
{
    message.ownerTyper = MessageOwnerTypeSelf;
    message.date = [NSDate date];
    message.userID = @"1001";
    [self addToShowMessage:message];
    [[MessageManager sharedInstance] sendMessage:message progress:^(Message *message, CGFloat progress) {
        
    } success:^(Message *message) {
        NSLog(@"sendsuccess");
    } failure:^(Message *message) {
        NSLog(@"sendfail");
    }];
}

// 未接受消息
- (void)didReceivedMessage:(Message *)message
{
    if ([message.userID isEqualToString:self.user.chat_userID]) {
        
        [self addToShowMessage:message];
    }
}

@end

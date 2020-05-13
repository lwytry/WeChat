//
//  ChatBaseViewController+MessageDisplayView.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+MessageDisplayView.h"
#import "ChatBaseViewController+ChatBar.h"

@implementation ChatBaseViewController (MessageDisplayView)
#pragma mark - # Delegate
//MARK: TLChatMessageDisplayViewDelegate
// chatView 点击事件
- (void)chatMessageDisplayViewDidTouched:(MessageDisplayView *)chatTVC
{
    [self dismissKeyobard];
}

- (void)addToShowMessage:(Message *)message
{
//    message.showTime = self
    [self.messageDisplayView addMessage:message];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageDisplayView scrollToBottomWithAnimation:YES];
    });
}

- (void)resetChatTVC
{
    [self.messageDisplayView resetMessageView];
    
}

@end

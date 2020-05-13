//
//  ChatBaseViewController+MessageDisplayView.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatBaseViewController (MessageDisplayView) <MessageDisplayViewDelegate>

/**
 *  添加展示消息（添加到chatVC）
 */
- (void)addToShowMessage:(Message *)message;

- (void)resetChatTVC;

@end

NS_ASSUME_NONNULL_END

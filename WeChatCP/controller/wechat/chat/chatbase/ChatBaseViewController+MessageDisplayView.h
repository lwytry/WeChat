//
//  ChatBaseViewController+MessageDisplayView.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController.h"

#define     MAX_SHOWTIME_MSG_COUNT      10
#define     MAX_SHOWTIME_MSG_SECOND     30
NS_ASSUME_NONNULL_BEGIN

@interface ChatBaseViewController (MessageDisplayView) <MessageDisplayViewDelegate>

/**
 *  添加展示消息（添加到chatVC）
 */
- (void)addToShowMessage:(Message *)message;

- (void)resetChatTVC;

@end

NS_ASSUME_NONNULL_END

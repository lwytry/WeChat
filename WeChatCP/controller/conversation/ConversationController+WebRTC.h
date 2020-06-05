//
//  ConversationController+WebRTC.h
//  WeChatCP
//
//  Created by lwy on 2020/6/5.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ConversationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationController (WebRTC)

- (void)launchRTCWithMessage:(Message *)message;

@end

NS_ASSUME_NONNULL_END

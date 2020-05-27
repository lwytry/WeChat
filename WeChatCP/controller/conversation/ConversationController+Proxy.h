//
//  WeChatViewController+Proxy.h
//  WeChatCP
//
//  Created by lwy on 2020/5/26.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ConversationController.h"
#import "MessageManagerChatVCDelegate.h"
#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationController (Proxy)<MessageManagerChatVCDelegate>

@end

NS_ASSUME_NONNULL_END

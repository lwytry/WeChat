//
//  ChatBaseViewController+Proxy.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController.h"

@interface ChatBaseViewController (Proxy)  <MessageManagerChatVCDelegate>

- (void)sendMessage:(Message *)message;

@end

//
//  ChatBaseViewController+WebRTC.h
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController.h"

@interface ChatBaseViewController (WebRTC)

- (void)launchRTCWithMessage:(WebRTCMessage *)message;

@end

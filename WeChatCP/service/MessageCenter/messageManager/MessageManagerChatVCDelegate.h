//
//  MessageManagerChatVCDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@protocol MessageManagerChatVCDelegate <NSObject>

- (void)didReceivedMessage:(Message *)message;

@end

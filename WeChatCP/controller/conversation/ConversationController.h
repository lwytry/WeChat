//
//  ConversationController.h
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conversation.h"

@interface ConversationController : UIViewController

- (void)updateConvList:(Conversation *)data;

- (void)addConversation:(Conversation *)data;

- (BOOL)isExistConversation:(NSString *)userId;

@end


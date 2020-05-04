//
//  MessageManager.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "MessageManagerChatVCDelegate.h"
#import "MessageManagerConvVCDelegate.h"
#import <SRWebSocket.h>

@interface MessageManager : NSObject

@property (nonatomic, assign) id<MessageManagerChatVCDelegate>messageDelegate;
@property (nonatomic, assign) id<MessageManagerConvVCDelegate>conversationDelegate;

@property (nonatomic, strong, readonly) NSString *userID;

//@property (nonatomic, strong) DBMessageStore *messageStore;

//@property (nonatomic, strong) DBConversationStore *conversationStore;

- (void)createWebSocekt;

- (void)closeWebSocekt;

+ (MessageManager *)sharedInstance;

#pragma mark - 发送
- (void)sendMessage:(Message *)message
           progress:(void (^)(Message *, CGFloat))progress
            success:(void (^)(Message *))success
            failure:(void (^)(Message *))failure;

@end


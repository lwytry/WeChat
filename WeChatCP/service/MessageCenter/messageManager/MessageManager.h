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
#import <SRWebSocket.h>
#import "UserHelper.h"
#import "Messagestore.h"
#import "ConversationStore.h"

@interface MessageManager : NSObject
{
    int _index;
    NSTimer * heartBeat;
    NSTimeInterval reConnectTime;
}

@property (nonatomic, assign) id<MessageManagerChatVCDelegate>messageDelegate;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) Messagestore *messageStore;

@property (nonatomic, strong) ConversationStore *conversationStore;

@property (nonatomic, strong)SRWebSocket *ws;

@property (nonatomic, assign, readonly) SRReadyState socketReadState;

- (void)createWebSocekt;

- (void)closeWebSocekt;

+ (MessageManager *)sharedInstance;

- (NSNumber *)addMessageStore:(Message *)message;

#pragma mark - 发送
- (void)sendMessage:(Message *)message
           progress:(void (^)(Message *, CGFloat))progress
            success:(void (^)(Message *))success
            failure:(void (^)(Message *))failure;

@end


//
//  Message.h
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageProtocol.h"
#import "MessageFrame.h"
#import "MessageConstants.h"
#import "ChatUserProtocol.h"

@interface Message : NSObject <MessageProtocol>
{
    MessageFrame *messageFrame;
}

@property (nonatomic, strong) NSString *ID;                         // 消息ID
@property (nonatomic, strong) NSString *userID;                     // 发送者ID
@property (nonatomic, strong) NSString *dstID;                      // 接收者ID
@property (nonatomic, strong) NSString *groupID;                    // 讨论组ID（无则为nil）

@property (nonatomic, strong) NSDate *date;                         // 发送时间

@property (nonatomic, strong) id<ChatUserProtocol> fromUser;      // 发送者

@property (nonatomic, assign) BOOL showTime;
@property (nonatomic, assign) BOOL showName;

@property (nonatomic, assign) PartnerType partnerType;            // 对方类型
@property (nonatomic, assign) MessageType messageType;            // 消息类型
@property (nonatomic, assign) MessageOwnerType ownerTyper;        // 发送者类型
@property (nonatomic, assign) MessageReadState readState;         // 读取状态
@property (nonatomic, assign) MessageSendState sendState;         // 发送状态

@property (nonatomic, strong) NSMutableDictionary *content;

@property (nonatomic, strong, readonly) MessageFrame *messageFrame;         // 消息frame

+ (Message *)createMessageByType:(MessageType)type;

- (void)resetMessageFrame;


@end


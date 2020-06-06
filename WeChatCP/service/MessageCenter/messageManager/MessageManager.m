//
//  MessageManager.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager.h"
#import "TextMessage.h"
#import "ImageMessage.h"
#import "WebRTCMessage.h"
#import "WebRTCViewController.h"
#import "ApiHelper.h"
#import "ConversationController.h"
#import "MessageManager+ConversationRecord.h"
#import "MessageManager+MessageRecord.h"
#import "NSFileManager+Chat.h"
#import "OssManager.h"
#import "MessageManager+Socket.h"

@class WeChatViewController;
@class ChatViewController;
@interface MessageManager () <SRWebSocketDelegate>

@end

static MessageManager *messageManager;

@implementation MessageManager

+ (MessageManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        messageManager = [[MessageManager alloc] init];
        messageManager.userId = [UserHelper sharedHelper].userId;
    });
    return messageManager;
}

- (void)createWebSocekt
{
    if (self.ws == nil) {
        NSString *topicId = self.userId;
        NSString *urlString = [NSString stringWithFormat:@"ws://192.168.31.15:8001/acc?topicId=%@", topicId];
        self.ws = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
        self.ws.delegate = self;
        [self.ws open];
    }
}

- (void)closeWebSocekt
{
    if (self.ws) {
        [self.ws close];
        self.ws = nil;
        [self destoryHeartBeat];
    }
}

// 接收消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    NSError *error;
    NSData * jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        return;
    }
    NSLog(@"接收到信息%@", dataDic);
    // 判断接收的数据类型
    NSNumber *msgTypeNum = [dataDic objectForKey:@"msgType"];
    NSInteger msgType = [msgTypeNum integerValue];
    NSNumber *dstTypeNum = [dataDic objectForKey:@"dstType"];
    NSInteger dstType = [dstTypeNum integerValue];
    if (msgType == MessageTypeText) {
        TextMessage *receiveMsg = [[TextMessage alloc] init];
        receiveMsg.ID = [dataDic objectForKey:@"id"];
        NSString *tempID = [dataDic objectForKey:@"userId"];
        receiveMsg.userID = [dataDic objectForKey:@"dstId"];
        receiveMsg.dstID = tempID;
        receiveMsg.text = [dataDic objectForKey:@"content"];
        receiveMsg.messageType = msgType;
        receiveMsg.partnerType = dstType;
        receiveMsg.date = [NSDate date];
        receiveMsg.ownerTyper = [dataDic objectForKey:@"userId"] == nil ? MessageOwnerTypeSystem : MessageOwnerTypeFriend;
        [self p_receiveMessageStore:receiveMsg];
        [self p_receiveMessageConvStore:receiveMsg];
        if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didReceivedMessage:)]) {
            [self.messageDelegate didReceivedMessage:receiveMsg];
        }
    } else if (msgType == MessageTypeImage) {
        ImageMessage *receiveMsg = [[ImageMessage alloc] init];
        receiveMsg.ID = [dataDic objectForKey:@"id"];
        NSString *tempID = [dataDic objectForKey:@"userId"];
        receiveMsg.userID = [dataDic objectForKey:@"dstId"];
        receiveMsg.dstID = tempID;
        receiveMsg.content = [NSMutableDictionary dictionaryWithDictionary:[[dataDic objectForKey:@"content"] mj_JSONObject]];
        receiveMsg.messageType = msgType;
        receiveMsg.partnerType = dstType;
        receiveMsg.date = [NSDate date];
        receiveMsg.ownerTyper = [dataDic objectForKey:@"userId"] == nil ? MessageOwnerTypeSystem : MessageOwnerTypeFriend;
        // 图片处理 可以下载到本地
        NSString *imageURL = [[OssManager sharedOssManager] getChatFileURL:[NSFileManager pathPartnerImageForOss:[receiveMsg.content objectForKey:@"url"] dstId:receiveMsg.dstID]];
        [receiveMsg.content setValue:imageURL forKey:@"url"];
        [self p_receiveMessageStore:receiveMsg];
        [self p_receiveMessageConvStore:receiveMsg];
        if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didReceivedMessage:)]) {
            [self.messageDelegate didReceivedMessage:receiveMsg];
        }
    } else if (msgType == MessageTypeVideo) {
        // 视频数据类型  下载视频到本地
    } else if (msgType == MessageTypeWebRTC) {
        // 实时音视频通信
        WebRTCMessage *receiveMsg = [[WebRTCMessage alloc] init];
        receiveMsg.ID = [dataDic objectForKey:@"id"];
        NSString *tempID = [dataDic objectForKey:@"userId"];
        receiveMsg.userID = [dataDic objectForKey:@"dstId"];
        receiveMsg.dstID = tempID;
        receiveMsg.content = [NSMutableDictionary dictionaryWithDictionary:[[dataDic objectForKey:@"content"] mj_JSONObject]];
        receiveMsg.messageType = msgType;
        receiveMsg.partnerType = dstType;
        receiveMsg.date = [NSDate date];
        receiveMsg.ownerTyper = [dataDic objectForKey:@"userId"] == nil ? MessageOwnerTypeSystem : MessageOwnerTypeFriend;
        
        [self p_receiveMessageStore:receiveMsg];
        [self p_receiveMessageConvStore:receiveMsg];
        if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didReceivedMessage:)]) {
            [self.messageDelegate didReceivedMessage:receiveMsg];
        }
    }
    
}


- (void)sendMessage:(Message *)message progress:(void (^)(Message *, CGFloat))progress success:(void (^)(Message *))success failure:(void (^)(Message *))failure
{
    NSInteger partnerType = message.partnerType;
    NSNumber *pt = [NSNumber numberWithLong:partnerType];
    NSInteger messageType = message.messageType;
    NSNumber *mt = [NSNumber numberWithLong:messageType];
    NSString *dstId = partnerType == PartnerTypeUser ? message.dstID : message.groupID;
    // 发送消息
    NSString *content = [NSString new];
    if (message.messageType == MessageTypeText) {
        content = [message.content objectForKey:@"text"];
    } else {
        content = [message.content mj_JSONString];
    }
    NSDictionary *dic = @{
       @"id": message.ID,
       @"userId": message.userID,
       @"dstType": pt,
       @"dstId": dstId,
       @"msgType": mt,
       @"content": content
    };
    NSString *urlStr = [HOST_URL stringByAppendingString:[NSString stringWithFormat:@"v1/chat/message?dstId=%@", message.dstID]];
    [ApiHelper postUrl:urlStr parameters:dic useToken:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"发送成功");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"发送失败");
    }];
}


- (NSNumber *)addMessageStore:(Message *)message
{
    NSNumber *insertId = [self.messageStore addMessageRetID:message];
    return insertId;
}
#pragma mark - # private
- (BOOL)p_receiveMessageStore:(Message *)message
{
    return [self addMessage:message];
}

- (BOOL)p_receiveMessageConvStore:(Message *)message
{
    return [self addConversationByMessage:message];
}

#pragma mark - # Getters


- (Messagestore *)messageStore
{
    if (_messageStore == nil) {
        _messageStore = [[Messagestore alloc] init];
    }
    return _messageStore;
}

- (ConversationStore *)conversationStore
{
    if (_conversationStore == nil) {
        _conversationStore = [[ConversationStore alloc] init];
    }
    return _conversationStore;
}

@end

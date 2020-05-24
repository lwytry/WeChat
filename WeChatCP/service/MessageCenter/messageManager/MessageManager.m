//
//  MessageManager.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager.h"
#import "TextMessage.h"
#import <AFNetworking.h>
#import "ApiHelper.h"
@interface MessageManager ()<SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *ws;

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
    NSString *topicId = self.userId;
    NSString *urlString = [NSString stringWithFormat:@"ws://127.0.0.1:8001/acc?topicId=%@", topicId];
    self.ws = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    self.ws.delegate = self;
    [self.ws open];
}

- (void)closeWebSocekt
{
    [self.ws close];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"连接成功....");
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
        if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didReceivedMessage:)]) {
            [self.messageDelegate didReceivedMessage:receiveMsg];
        }
    }
    
}

// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"链接失败 : %@", error);
}


- (void)sendMessage:(Message *)message progress:(void (^)(Message *, CGFloat))progress success:(void (^)(Message *))success failure:(void (^)(Message *))failure
{
    NSInteger partnerType = message.partnerType;
    NSNumber *pt = [NSNumber numberWithLong:partnerType];
    NSInteger messageType = message.messageType;
    NSNumber *mt = [NSNumber numberWithLong:messageType];
    NSString *dstId = partnerType == PartnerTypeUser ? message.dstID : message.groupID;
    // 发送消息
    NSString *text = [message.content objectForKey:@"text"];
    NSDictionary *dic = @{
       @"id": message.ID,
       @"userId": message.userID,
       @"dstType": pt,
       @"dstId": dstId,
       @"msgType": mt,
       @"content": text
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
    return [self.messageStore addMessage:message];
}

#pragma mark - # Getters
- (Messagestore *)messageStore
{
    if (_messageStore == nil) {
        _messageStore = [[Messagestore alloc] init];
    }
    return _messageStore;
}

@end

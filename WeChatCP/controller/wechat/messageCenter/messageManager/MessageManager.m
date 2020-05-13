//
//  MessageManager.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager.h"
#import "TextMessage.h"
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
    });
    return messageManager;
}

- (void)createWebSocekt
{
    self.ws = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://127.0.0.1:8001/acc?userId=1001"]];
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
    
    NSLog(@"收到消息:%@", message);
    return;
    // 判断接受的数据类型
    TextMessage *receiveMsg = [[TextMessage alloc] init];
    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didReceivedMessage:)]) {
        [self.messageDelegate didReceivedMessage:receiveMsg];
    }
    
}

// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"链接失败 : %@", error);
}


- (void)sendMessage:(Message *)message progress:(void (^)(Message *, CGFloat))progress success:(void (^)(Message *))success failure:(void (^)(Message *))failure
{
    // 发送消息
    NSDictionary *dic = @{@"userId": @"1001"};
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self.ws send:jsonStr];
    NSLog(@"Messagemanager send message");
    
    // 将json字符串转换成字典
    NSData * getJsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * getDict = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
    // 存储数据库
    
}

#pragma mark - # Private
- (BOOL)p_sendMessage:(Message *)message
{
    NSLog(@"p_sendMessage");
    return YES;
}

@end

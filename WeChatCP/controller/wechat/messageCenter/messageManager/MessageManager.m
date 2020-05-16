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
    NSInteger partnerType = message.partnerType;
    NSNumber *pt = [NSNumber numberWithLong:partnerType];
    NSInteger messageType = message.messageType;
    NSNumber *mt = [NSNumber numberWithLong:messageType];
    NSString *dstId = partnerType ? message.dstID : message.groupID;
    // 发送消息
    NSString *text = [message.content objectForKey:@"text"];
    NSDictionary *dic = @{
        @"id": message.ID,
        @"userId": message.userID,
        @"dstType": pt,
        @"dstId": @1002,
        @"msgType": mt,
        @"content": text
    };
    NSString *urlStr = [NSString stringWithFormat:@"http://localhost:8080/v1/chat/message?userId=%@", message.userID];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"token"];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:dic error:nil];
    [req addValue:token forHTTPHeaderField:@"token"];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:req uploadProgress:^(NSProgress * _Nonnull uploadProgress) {

    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
    }];
    [dataTask resume];
    
    
//    NSError * error = nil;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
//    NSString * jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // 将json字符串转换成字典
//    NSData * getJsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary * getDict = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:&error];
    // 存储数据库
    
}

#pragma mark - # Private
- (BOOL)p_sendMessage:(Message *)message
{
    NSLog(@"p_sendMessage");
    return YES;
}

@end

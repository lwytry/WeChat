//
//  MessageManager+Socket.m
//  WeChatCP
//
//  Created by lwy on 2020/6/6.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageManager+Socket.h"


#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
        block();\
    } else {\
        dispatch_async(dispatch_get_main_queue(), block);\
    }
#endif


@implementation MessageManager (Socket)


- (void)initHeartBeat
{
    dispatch_main_async_safe(^{
        [self destoryHeartBeat];
        //心跳设置为3分钟，NAT超时一般为5分钟
        self->heartBeat = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(sentheart) userInfo:nil repeats:YES];
        //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
        [[NSRunLoop currentRunLoop] addTimer:self->heartBeat forMode:NSRunLoopCommonModes];
    });
}

-(void)sentheart{
    NSDictionary *dict = @{
        @"userId": self.userId,
        @"cmd": @"heartbeat"
    };
    //传入json
    [self sendData:[dict mj_JSONString]];
}

- (void)sendData:(id)data {
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    
    dispatch_async(queue, ^{
        if (weakSelf.ws != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (weakSelf.ws.readyState == SR_OPEN) {
                [weakSelf.ws send:data];    // 发送数据
            } else if (weakSelf.ws.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                // 代码有点长，我就写个逻辑在这里好了
                [self reConnect];
                
            } else if (weakSelf.ws.readyState == SR_CLOSING || weakSelf.ws.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                NSLog(@"重连");
                [self reConnect];
            }
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
            NSLog(@"其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
        }
    });
}

//重连机制
- (void)reConnect
{
    [self closeWebSocekt];
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        //您的网络状况不是很好，请检查网络后重试
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.ws = nil;
        [self createWebSocekt];
        NSLog(@"重连");
    });
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
}

//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (self->heartBeat) {
            if ([self->heartBeat respondsToSelector:@selector(isValid)]){
                if ([self->heartBeat isValid]){
                    [self->heartBeat invalidate];
                    self->heartBeat = nil;
                }
            }
        }
    });
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    reConnectTime = 0;
    [self initHeartBeat];
    NSLog(@"连接成功....");
}


// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    if (webSocket == self.ws) {
        [self reConnect];
        NSLog(@"链接失败 : %@", error);
    }
}


- (SRReadyState)socketReadState
{
    return self.ws.readyState;
}
@end

//
//  ConversationController+WebRTC.m
//  WeChatCP
//
//  Created by lwy on 2020/6/5.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "Message.h"
#import "ConversationController+WebRTC.h"
#import "Macro.h"
#import "ApiHelper.h"
#import "WebRTCViewController.h"

@implementation ConversationController (WebRTC)

- (void)launchRTCWithMessage:(Message *)message
{
    
    NSString *urlStr = [HOST_URL stringByAppendingString:[NSString stringWithFormat:@"v1/chat/getRTCToken?userId=%@&roomId=%@", message.userID, [message.dstID stringByAppendingString:message.userID]]];
    [ApiHelper getUrl:urlStr parameters:nil useToken:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *token = [responseObject objectForKey:@"data"];
        if (token != nil) {
            WebRTCViewController *roomVC = [[WebRTCViewController alloc] initWithMessage:(WebRTCMessage *)message];
            roomVC.token = token;
            [self presentViewController:roomVC animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


@end

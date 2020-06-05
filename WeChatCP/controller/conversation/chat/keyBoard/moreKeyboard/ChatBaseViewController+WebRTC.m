//
//  ChatBaseViewController+WebRTC.m
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+WebRTC.h"
#import "WebRTCViewController.h"
#import "ApiHelper.h"
#import "ChatBaseViewController+Proxy.h"

@implementation ChatBaseViewController (WebRTC)

- (void)launchRTCWithMessage:(WebRTCMessage *)message
{
    NSString *urlStr = [HOST_URL stringByAppendingString:[NSString stringWithFormat:@"v1/chat/getRTCToken?userId=%@&roomId=%@", self.user.chat_userID, [self.user.chat_userID stringByAppendingString: self.partner.chat_userID]]];
    [ApiHelper getUrl:urlStr parameters:nil useToken:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *token = [responseObject objectForKey:@"data"];
        if (token != nil) {
            WebRTCViewController *roomVC = [[WebRTCViewController alloc] initWithMessage:message];
            roomVC.token = token;
            [self presentViewController:roomVC animated:YES completion:nil];
            [self sendMessage:message];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

@end

//
//  WebRTCViewController.h
//  WeChatCP
//
//  Created by lwy on 2020/5/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@class WebRTCMessage;

@interface WebRTCViewController : UIViewController

@property (nonatomic, copy) NSString *token;

- (id)initWithMessage:(WebRTCMessage *)message;

@end

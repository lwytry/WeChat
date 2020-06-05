//
//  WebRTCMessage.h
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

typedef NS_ENUM(NSInteger, RTCType) {
    UnknownRTC,
    AudioRTC,
    VideoRTC
};

@interface WebRTCMessage : Message

@property (nonatomic, assign) RTCType rtcType;

@property (nonatomic, strong) NSString *duration;

@end

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

typedef NS_ENUM(NSInteger, AnswerType) {
    Unknown,
    Cancel,
    Agree,
    Refuse
};

@interface WebRTCMessage : Message

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSAttributedString *attrText;

@property (nonatomic, assign) RTCType rtcType;

@property (nonatomic, strong) NSString *duration;

@property (nonatomic, assign) AnswerType answerType;

@end

//
//  WebRTCMessage.m
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "WebRTCMessage.h"

@implementation WebRTCMessage
@synthesize rtcType = _rtcType;
@synthesize duration = _duration;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:MessageTypeWebRTC];
    }
    return self;
}

- (RTCType)rtcType
{
    if (_rtcType == UnknownRTC) {
        _rtcType = [[self.content objectForKey:@"rtcType"] intValue];
    }
    return _rtcType;
}

- (void)setRtcType:(RTCType)rtcType
{
    _rtcType = rtcType;
    [self.content setValue:[NSNumber numberWithInteger:_rtcType] forKey:@"rtcType"];
}

- (NSString *)duration
{
    if (_duration == nil) {
        _duration = [self.content objectForKey:@"duration"];
    }
    return _duration;
}

- (void)setDuration:(NSString *)duration
{
    _duration = duration;
    [self.content setValue:_duration forKey:@"duration"];
}

- (NSString *)conversationContent
{
    return [NSString stringWithFormat:@"[%@通话]", _rtcType == AudioRTC ? @"音频" : @"视频"];
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}


@end

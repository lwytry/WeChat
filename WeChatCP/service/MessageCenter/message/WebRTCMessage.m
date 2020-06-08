//
//  WebRTCMessage.m
//  WeChatCP
//
//  Created by lwy on 2020/6/4.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "WebRTCMessage.h"
#import "NSString+Message.h"

static UILabel *textLabel = nil;

@implementation WebRTCMessage
@synthesize rtcType = _rtcType;
@synthesize duration = _duration;
@synthesize answerType = _answerType;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:MessageTypeWebRTC];
        if (textLabel == nil) {
            textLabel = [[UILabel alloc] init];
            [textLabel setFont:[UIFont systemFontOfSize:16.0f]];
            [textLabel setNumberOfLines:0];
        }
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

- (AnswerType)answerType
{
    if (_answerType == Unknown) {
        _answerType = [[self.content objectForKey:@"answerType"] integerValue];
    }
    return _answerType;
}

- (void)setAnswerType:(AnswerType)answerType
{
    _answerType = answerType;
    [self.content setValue:[NSNumber numberWithInteger:_answerType] forKey:@"answerType"];
}

- (NSString *)text
{
    if (_text == nil) {
        if (self.readState == MessageUnRead) {
            _text = @"未接听";
        } else {
            if (self.answerType == Cancel) {
                _text = @"已取消";
            } else if (self.answerType == Agree) {
                _text = [NSString stringWithFormat:@"通话时长: %@", self.duration];
            } else if (self.answerType == Refuse) {
                _text = @"已拒绝";
            } else {
                _text = @"未知";
            }
        }
    }
    return _text;
}

- (MessageFrame *)messageFrame
{
    if (messageFrame == nil) {
        messageFrame = [[MessageFrame alloc] init];
        messageFrame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0) + 20;
        [textLabel setAttributedText:self.attrText];
        messageFrame.contentSize = [textLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
        messageFrame.height += messageFrame.contentSize.height;
    }
    return messageFrame;
}

- (NSAttributedString *)attrText
{
    if (_attrText == nil) {
        _attrText = [self.text toMessageString];
    }
    return _attrText;
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

//
//  Message.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (Message *)createMessageByType:(MessageType)type
{
    NSString *className;
    if (type == MessageTypeText) {
        className = @"TextMessage";
    } else if (type == MessageTypeImage) {
        className = @"ImageMessage";
    } else if (type == MessageTypeVideo) {
        className = @"VideoMessage";
    } else if (type == MessageTypeVoice) {
        className = @"VoiceMessage";
    }
    if (className) {
        return [[NSClassFromString(className) alloc] init];
    }
    return nil;
}

- (id)init
{
    if (self = [super init]) {
    }
    return self;
}

- (void)resetMessageFrame
{
    messageFrame = nil;
}

#pragma mark - # Protocol
- (NSString *)conversationContent
{
    return @"子类未定义";
}

- (NSString *)messageCopy
{
    return @"子类未定义";
}

#pragma mark - # Getter
- (NSMutableDictionary *)content
{
    if (_content == nil) {
        _content = [[NSMutableDictionary alloc] init];
    }
    return _content;
}

@end

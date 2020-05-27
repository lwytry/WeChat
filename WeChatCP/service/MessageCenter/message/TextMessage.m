//
//  TextMessage.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "TextMessage.h"
#import "NSString+Message.h"

static UILabel *textLabel = nil;

@implementation TextMessage
@synthesize text = _text;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:MessageTypeText];
        if (textLabel == nil) {
            textLabel = [[UILabel alloc] init];
            [textLabel setFont:[UIFont systemFontOfSize:16.0f]];
            [textLabel setNumberOfLines:0];
        }
    }
    return self;
}

- (NSString *)text
{
    if (_text == nil) {
        _text = [self.content objectForKey:@"text"];
    }
    return _text;
}

- (void)setText:(NSString *)text
{
    _text = text;
    [self.content setObject:text forKey:@"text"];
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
    return self.text;
}

@end

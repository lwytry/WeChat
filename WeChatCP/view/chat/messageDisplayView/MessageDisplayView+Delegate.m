//
//  MessageDisplayView+Delegate.m
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "MessageDisplayView+Delegate.h"

@implementation MessageDisplayView (Delegate)
- (void)registerCellClassForTableView:(UITableView *)tabView
{
    [tabView registerClass:[TextMessageCell class] forCellReuseIdentifier:@"TextMessageCell"];
    [tabView registerClass:[ImageMessageCell class] forCellReuseIdentifier:@"ImageMessageCell"];
    [tabView registerClass:[VideoMessageCell class] forCellReuseIdentifier:@"VideoMessageCell"];
    [tabView registerClass:[RTCMessageCell class] forCellReuseIdentifier:@"RTCMessageCell"];
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}

#pragma mark - # Delegate
//MARK: UITableViewDataSouce
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Message *message = self.data[indexPath.row];
    if (message.messageType == MessageTypeText) {
        TextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    } else if (message.messageType == MessageTypeImage) {
        ImageMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    } else if (message.messageType == MessageTypeVideo) {
        VideoMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    } else if (message.messageType == MessageTypeWebRTC) {
        RTCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RTCMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.data.count) {
        return 0.0f;
    }
    Message * message = self.data[indexPath.row];
    return message.messageFrame.height;
}

//MARK: MessageCellDelegate
- (void)messageCellTap:(Message *)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chatMessageDisplayView:didClickMessage:)]) {
        [self.delegate chatMessageDisplayView:self didClickMessage:message];
    }
}

@end

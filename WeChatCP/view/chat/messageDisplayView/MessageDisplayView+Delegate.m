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
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    Message *message = self.data[indexPath.row];
    if (message.messageType == MessageTypeText) {
        TextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TextMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

@end

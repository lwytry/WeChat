//
//  ChatBaseViewController+MessageDisplayView.m
//  WeChatCP
//
//  Created by lwy on 2020/5/2.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+MessageDisplayView.h"
#import "ChatBaseViewController+ChatBar.h"

@implementation ChatBaseViewController (MessageDisplayView)
#pragma mark - # Delegate
//MARK: TLChatMessageDisplayViewDelegate
// chatView 点击事件
- (void)chatMessageDisplayViewDidTouched:(MessageDisplayView *)chatTVC
{
    [self dismissKeyobard];
}

- (void)chatMessageDisplayView:(MessageDisplayView *)chatTVC getRecordsFromDate:(NSDate *)date count:(NSUInteger)count completed:(void (^)(NSDate *, NSArray *, BOOL))completed
{
    __weak typeof(self) weakSelf = self;
    [[MessageManager sharedInstance] messageRecordForDstId:[self.partner chat_userID] fromDate:date count:count complete:^(NSArray *arr, BOOL hasMore) {
        if (arr.count > 0) {
            int count = 0;
            NSTimeInterval tm = 0;
            for (Message *message in arr) {
                if (++count > MAX_SHOWTIME_MSG_COUNT || tm == 0 || message.date.timeIntervalSince1970 - tm > MAX_SHOWTIME_MSG_SECOND) {
                    tm = message.date.timeIntervalSince1970;
                    count = 0;
                    message.showTime = NO;
                }
                if (message.ownerTyper == MessageOwnerTypeSelf) {
                    message.fromUser = weakSelf.user;
                } else {
                    if ([weakSelf.partner chat_userType] == ChatUserTypeUser) {
                        message.fromUser = weakSelf.partner;
                    } else if ([weakSelf.partner chat_userType] == ChatUserTypeUser){
                        if ([weakSelf.partner respondsToSelector:@selector(groupMemberByID:)]) {
                            message.fromUser = [weakSelf.partner groupMemberByID:message.dstID];
                        }
                    }
                }
            }
        }
        completed(date, arr, hasMore);
    }];
}

- (void)addToShowMessage:(Message *)message
{
//    message.showTime = self
    [self.messageDisplayView addMessage:message];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageDisplayView scrollToBottomWithAnimation:YES];
    });
}

- (void)resetChatTVC
{
    [self.messageDisplayView resetMessageView];
    
}


@end

//
//  ChatBaseViewController+ChatBar.m
//  WeChatCP
//
//  Created by lwy on 2020/5/1.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController+ChatBar.h"
#import <Masonry/Masonry.h>
#import "ChatBaseViewController+Proxy.h"
#import "TextMessage.h"

@implementation ChatBaseViewController (ChatBar)

- (void)loadKeyboard
{
    
}

- (void)dismissKeyobard
{
    [self.chatBar resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    if (curState != ChatBarStateKeyboard) {
        return;
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if (curState != ChatBarStateKeyboard) {
        return;
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    if (curState != ChatBarStateKeyboard && laseState != ChatBarStateKeyboard) {
        return;
    }
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(MIN(-keyboardFrame.size.height, -SAFEAREA_INSETS_BOTTOM));
    }];
    [self.view layoutIfNeeded];
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if (curState != ChatBarStateKeyboard && laseState != ChatBarStateKeyboard) {
        return;
    }
    if (curState == ChatBarStateEmoji || curState == ChatBarStateMore) {
        return;
    }
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-SAFEAREA_INSETS_BOTTOM);
    }];
    [self.view layoutIfNeeded];
}


#pragma mark - ChatBarDelegate
//MARK: - chatBar状态切换
- (void)chatBar:(ChatBar *)chatBar changeStatusFrom:(ChatBarState)fromState to:(ChatBarState)toState
{
//    NSLog(@"---%ldto--%ld", (long)fromState, (long)toState);
    if (curState == toState) {
        return;
    }
    laseState = fromState;
    curState = toState;
    if (toState == ChatBarStateInit) {
        if (fromState == ChatBarStateMore) {
//            [self.moreKeyboard dismissWithAnimation:YES];
        }
        else if (fromState == ChatBarStateEmoji) {
//            [self.emojiKeyboard dismissWithAnimation:YES];
        }
    }
    else if (toState == ChatBarStateVoice) {
        if (fromState == ChatBarStateMore) {
//            [self.moreKeyboard dismissWithAnimation:YES];
        }
        else if (fromState == ChatBarStateEmoji) {
//            [self.emojiKeyboard dismissWithAnimation:YES];
        }
    }
    else if (toState == ChatBarStateEmoji) {
//        [self.emojiKeyboard showInView:self.view withAnimation:YES];
    }
    else if (toState == ChatBarStateMore) {
//        [self.moreKeyboard showInView:self.view withAnimation:YES];
    }
}

- (void)chatBar:(ChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height
{
    [self.messageDisplayView scrollToBottomWithAnimation:NO];
}


- (void)chatBar:(ChatBar *)chatBar sendText:(NSString *)text
{
    TextMessage *message = [[TextMessage alloc] init];
    message.text = text;
    message.messageType = MessageTypeText;
    [self sendMessage: message];
}

#pragma mark - KeyboardDelegate

- (void)chatKeyboardWillShow:(id)keyboard animated:(BOOL)animated
{
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)chatKeyboardDidShow:(id)keyboard animated:(BOOL)animated
{
    if (curState == ChatBarStateMore && laseState == ChatBarStateEmoji) {
        
    } else if (curState == ChatBarStateEmoji && laseState == ChatBarStateMore) {
        
    }
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}

- (void)chatKeyboard:(id)keyboard didChangeHeight:(CGFloat)height
{
    [self.chatBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(MIN(-height, -SAFEAREA_INSETS_BOTTOM));
    }];
    [self.view layoutIfNeeded];
    [self.messageDisplayView scrollToBottomWithAnimation:YES];
}


@end

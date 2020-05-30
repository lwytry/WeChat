//
//  ChatBaseViewController+ChatBar.h
//  WeChatCP
//
//  Created by lwy on 2020/5/1.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBaseViewController.h"
#import "KeyboardDelegate.h"
#import "MoreKeyboard.h"


NS_ASSUME_NONNULL_BEGIN

@interface ChatBaseViewController (ChatBar) <ChatBarDelegate, KeyboardDelegate>

@property (nonatomic, strong) MoreKeyboard *moreKeyboard;

- (void)loadKeyboard;
- (void)dismissKeyobard;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardDidShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)keyboardFrameWillChange:(NSNotification *)notification;

@end

NS_ASSUME_NONNULL_END

//
//  ChatBarDelegate.h
//  WeChatCP
//
//  Created by lwy on 2020/4/29.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macro.h"

@class ChatBar;

@protocol ChatBarDelegate <NSObject>
/**
 *  chatBar状态改变
 */
- (void)chatBar:(ChatBar *)chatBar changeStatusFrom:(ChatBarState)fromStatus to:(ChatBarState)toStatus;

/**
 *  输入框高度改变
 */
- (void)chatBar:(ChatBar *)chatBar didChangeTextViewHeight:(CGFloat)height;

/**
 *  发送文字
 */
- (void)chatBar:(ChatBar *)chatBar sendText:(NSString *)text;


// 录音控制
- (void)chatBarStartRecording:(ChatBar *)chatBar;

- (void)chatBarWillCancelRecording:(ChatBar *)chatBar cancel:(BOOL)cancel;

- (void)chatBarDidCancelRecording:(ChatBar *)chatBar;

- (void)chatBarFinishedRecoding:(ChatBar *)chatBar;

@end

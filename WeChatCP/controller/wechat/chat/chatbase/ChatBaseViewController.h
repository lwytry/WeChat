//
//  ChatBaseViewController.h
//  WeChatCP
//
//  Created by lwy on 2020/4/28.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatUserProtocol.h"
#import "MessageDisplayView.h"
#import "Macro.h"
#import "ChatBar.h"
#import "MessageManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChatBaseViewController : UIViewController
{
    ChatBarState laseState;
    ChatBarState curState;
}

// 用户信息
@property (nonatomic, strong) id<ChatUserProtocol> user;

// 聊天对象
@property (nonatomic, strong) id<ChatUserProtocol> partner;

// 消息展示页面
@property (nonatomic, strong) MessageDisplayView *messageDisplayView;

// 输入聊天栏
@property (nonatomic, strong) ChatBar *chatBar;

// emoji展示view
@property (nonatomic, strong) UIView *emojiDisplayView;

// 图片展示view
@property (nonatomic, strong) UIView *imageDisplayView;

// 录音展示view
@property (nonatomic, strong) UIView *voiceDisplayView;

/**
 *  设置“更多”键盘元素
 */
//- (void)setChatMoreKeyboardData:(NSMutableArray *)moreKeyboardData;

/**
 *  设置“表情”键盘元素
 */
//- (void)setChatEmojiKeyboardData:(NSMutableArray *)emojiKeyboardData;

/**
 *  重置chatVC
 */
- (void)resetChatVC;

/**
 *  发送图片信息
 */
//- (void)sendImageMessage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END

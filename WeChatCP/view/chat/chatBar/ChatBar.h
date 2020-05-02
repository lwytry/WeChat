//
//  ChatBar.h
//  WeChatCP
//
//  Created by lwy on 2020/4/29.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatBarDelegate.h"
#import "Macro.h"

@interface ChatBar : UIView

@property (nonatomic, assign) id<ChatBarDelegate> delegate;

@property (nonatomic, assign) ChatBarState state;

@property (nonatomic, strong, readonly) NSString *curText;

@property (nonatomic, assign) BOOL activity;

/**
 *  添加EmojiB表情String
 */
- (void)addEmojiString:(NSString *)emojiString;

/**
 *  发送文字消息
 */
- (void)sendCurrentText;

/**
 *  删除最后一个字符
 */
- (void)deleteLastCharacter;


@end
